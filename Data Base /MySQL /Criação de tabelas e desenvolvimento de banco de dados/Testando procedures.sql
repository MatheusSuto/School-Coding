USE db_empresa_integrada;

--
-- Para rodar descomente as 2 linhas apos os comentarios explicativos
-- um de cada vez
--

-- Parâmetros: 'I', id_produto(null), nome, id_tipo, descrição, id_setor
 CALL proc_dius_produtos('I', @mensagem, NULL, 'Notebook Gamer Pro', 4, 'Processador Core i7, 16GB RAM, SSD 512GB', 4);
 select @mensagem;

-- Parâmetros: 'S', id_produto(1), demais campos nulos
 CALL proc_dius_produtos('S',@mensagem, 1, NULL, NULL, NULL, NULL);
 select @mensagem;

-- Forçando um erro ao passar o id_tipo_produto = 999 (que não existe na aux_tipos_produto)
 CALL proc_dius_produtos('U',@mensagem, 1, 'Notebook Alterado',999,'Processador Core i7, 16GB RAM, SSD 512GB',4);
 select @mensagem;

CALL proc_dius_produtos('D',@mensagem, 1, NULL, NULL, NULL, NULL);
select @mensagem;

 
select * from tbl_produtos;
