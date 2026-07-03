USE db_empresa_integrada;

DROP PROCEDURE IF EXISTS proc_dius_produtos;

DELIMITER $$

CREATE PROCEDURE proc_dius_produtos(
    IN  p_operacao                 CHAR(1),        -- 'I' (Insert), 'S' (Select/Search), 'U' (Update), 'D' (Delete)
    OUT Mensagem                   varchar(255),   -- Retorno em caso de erro
    IN  p_id_produto               INT,            -- Obrigatório para S, U, D. (Pode ser NULL no Insert)
    IN  p_nome_produto             VARCHAR(100),   -- Utilizado em I e U
    IN  p_id_tipo_produto          INT,            -- Utilizado em I e U
    IN  p_descricao                TEXT,           -- Utilizado em I e U
    IN  p_id_setor_responsavel     INT             -- Utilizado em I e U
)
proc_main: BEGIN
    -- Declaração de variáveis para controle de erro interno do MySQL
    DECLARE sql_erro_codigo INT DEFAULT 0;
    DECLARE sql_erro_msg    VARCHAR(255) DEFAULT '';
    
    -- Handler para interceptar qualquer quebra de constraint ou erro de sintaxe SQL
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
        SET sql_erro_codigo = 1;
    END;

    -- ====================================================================
    -- OPERAÇÃO: INSERT (I)
    -- ====================================================================
    IF p_operacao = 'I' THEN
        INSERT INTO tbl_produtos (
            nome_produto, 
            id_tipo_produto, 
            descricao, 
            id_setor_responsavel
        ) VALUES (
            p_nome_produto, 
            p_id_tipo_produto, 
            p_descricao, 
            p_id_setor_responsavel
        );
        
        -- Testa se a operação falhou (Ex: Chave estrangeira de setor ou tipo violada)
        IF sql_erro_codigo = 1 THEN
            -- Como o insert falhou e a linha não nasceu, não há id para dar update. 
            -- Retornamos o erro direto na console da aplicação.
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Erro ao Inserir: Verifique a integridade dos IDs de Setor e Tipo.';
            SET Mensagem = MESSAGE_TEXT;
        ELSE
            -- Retorna o registro recém-criado para conferência
            SELECT * FROM tbl_produtos WHERE id_produto = LAST_INSERT_ID();
            SET Mensagem = 'Sucesso na inserção do produto';
        END IF;
        LEAVE proc_main;
    END IF;

    -- ====================================================================
    -- VALIDAÇÃO DE SEGURANÇA PARA AS DEMAIS OPERAÇÕES (S, U, D)
    -- ====================================================================
    -- Valida se o ID do produto foi enviado para as operações que dependem dele
    IF p_id_produto IS NULL OR p_id_produto <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Operação Inválida: O parâmetro ID do produto é obrigatório para Select, Update e Delete.';
        SET Mensagem = MESSAGE_TEXT;
        LEAVE proc_main;
    END IF;

    -- ====================================================================
    -- OPERAÇÃO: SELECT / SEARCH (S)
    -- ====================================================================
    IF p_operacao = 'S' THEN
        -- Verifica se o produto de fato existe antes do select
        IF NOT EXISTS (SELECT 1 FROM tbl_produtos WHERE id_produto = p_id_produto) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Produto não localizado no banco de dados.';
            SET Mensagem = MESSAGE_TEXT;
        ELSE
            SELECT * FROM tbl_produtos WHERE id_produto = p_id_produto;
        END IF;
        LEAVE proc_main;
    END IF;

    -- ====================================================================
    -- OPERAÇÃO: UPDATE (U)
    -- ====================================================================
    IF p_operacao = 'U' THEN
        -- Tenta executar a atualização dos dados
        UPDATE tbl_produtos 
        SET nome_produto = p_nome_produto,
            id_tipo_produto = p_id_tipo_produto,
            descricao = p_descricao,
            id_setor_responsavel = p_id_setor_responsavel
        WHERE id_produto = p_id_produto;
        
        -- Testa se a operação falhou em tempo de execução
        IF sql_erro_codigo = 1 THEN
            -- Grava o log de erro físico na linha do próprio produto para auditoria interna
                       
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro crítico no Update. ';
            SET Mensagem = MESSAGE_TEXT;
        ELSE
            -- Se deu certo, exibe o produto atualizado
            SELECT * FROM tbl_produtos WHERE id_produto = p_id_produto;
        END IF;
        LEAVE proc_main;
    END IF;

    -- ====================================================================
    -- OPERAÇÃO: DELETE (D)
    -- ====================================================================
    IF p_operacao = 'D' THEN
        -- Tenta deletar o registro
        DELETE FROM tbl_produtos WHERE id_produto = p_id_produto;
        
        -- Testa se o delete foi bloqueado por integridade referencial (Ex: Produto já está no estoque ou em NF)
        IF sql_erro_codigo = 1 THEN
            -- Como o registro não pôde ser deletado, atualizamos o campo dele com o motivo do travamento
           
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Delete negado: Este produto possui movimentações ativas e não pode ser excluído.';
            SET Mensagem = MESSAGE_TEXT;
        ELSE
            SELECT CONCAT('Produto ID ', p_id_produto, ' excluído com sucesso do banco.') AS Resultado;
        END IF;
        LEAVE proc_main;
    END IF;

    -- ====================================================================
    -- TRATAMENTO CASO ENVIE OUTRA LETRA QUE NÃO SEJA I, S, U, D
    -- ====================================================================
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = 'Operação não reconhecida. Utilize apenas I, S, U ou D.';
    SET Mensagem = MESSAGE_TEXT;

END $$

DELIMITER ;
