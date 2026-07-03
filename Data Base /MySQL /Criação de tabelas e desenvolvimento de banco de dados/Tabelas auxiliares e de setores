CREATE DATABASE IF NOT EXISTS db_empresa_integrada;
USE db_empresa_integrada;

-- ====================================================================
-- 0. TABELAS AUXILIARES DE DOMÍNIO (Substitutas de ENUM e CHECK)
-- ====================================================================

CREATE TABLE aux_niveis_acesso (
    id_nivel_acesso INT AUTO_INCREMENT PRIMARY KEY,
    nome_nivel VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE aux_situacoes_funcionario (
    id_situacao_func INT AUTO_INCREMENT PRIMARY KEY,
    nome_situacao VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE aux_status_folha (
    id_status_folha INT AUTO_INCREMENT PRIMARY KEY,
    nome_status VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE aux_status_solicitacao (
    id_status_solicitacao INT AUTO_INCREMENT PRIMARY KEY,
    nome_status VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE aux_condicoes_pagamento_compras (
    id_condicao_compra INT AUTO_INCREMENT PRIMARY KEY,
    nome_condicao VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE aux_status_pedido_compra (
    id_status_pedido INT AUTO_INCREMENT PRIMARY KEY,
    nome_status VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE aux_situacoes_conferencia (
    id_situacao_conf INT AUTO_INCREMENT PRIMARY KEY,
    nome_situacao VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE aux_status_contas_pagar (
    id_status_cp INT AUTO_INCREMENT PRIMARY KEY,
    nome_status VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE aux_tipos_cliente (
    id_tipo_cliente INT AUTO_INCREMENT PRIMARY KEY,
    descricao_tipo VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE aux_status_campanha_mkt (
    id_status_mkt INT AUTO_INCREMENT PRIMARY KEY,
    nome_status VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE aux_formas_pagamento_vendas (
    id_forma_pagto INT AUTO_INCREMENT PRIMARY KEY,
    nome_forma VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE aux_status_transacao_venda (
    id_status_trans INT AUTO_INCREMENT PRIMARY KEY,
    nome_status VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE aux_bandeiras_cartao (
    id_bandeira INT AUTO_INCREMENT PRIMARY KEY,
    nome_bandeira VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE aux_status_ativos_ti (
    id_status_ti INT AUTO_INCREMENT PRIMARY KEY,
    nome_status VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE aux_tipos_fluxo_caixa (
    id_tipo_fluxo INT AUTO_INCREMENT PRIMARY KEY,
    sigla_fluxo CHAR(1) NOT NULL UNIQUE,
    descricao_fluxo VARCHAR(10) NOT NULL
);

CREATE TABLE aux_categorias_previsao (
    id_categoria_previsao INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL UNIQUE
);


-- ====================================================================
-- 1. SETOR: ADMINISTRAÇÃO, RH & AUDITORIA
-- ====================================================================

CREATE TABLE tbl_setores (
    id_setor INT AUTO_INCREMENT PRIMARY KEY,
    nome_setor VARCHAR(50) NOT NULL UNIQUE,
    descricao VARCHAR(150)
);

CREATE TABLE tbl_cargos (
    id_cargo INT AUTO_INCREMENT PRIMARY KEY,
    nome_cargo VARCHAR(50) NOT NULL UNIQUE,
    salario_base DECIMAL(10,2) NOT NULL,
    id_nivel_acesso INT NOT NULL,
    CONSTRAINT fk_cargo_nivel FOREIGN KEY (id_nivel_acesso) REFERENCES aux_niveis_acesso(id_nivel_acesso)
);

CREATE TABLE tbl_funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    id_setor INT NOT NULL,
    id_cargo INT NOT NULL,
    data_admissao DATE NOT NULL,
    id_situacao_func INT NOT NULL,
    CONSTRAINT fk_func_setor FOREIGN KEY (id_setor) REFERENCES tbl_setores(id_setor),
    CONSTRAINT fk_func_cargo FOREIGN KEY (id_cargo) REFERENCES tbl_cargos(id_cargo),
    CONSTRAINT fk_func_situacao FOREIGN KEY (id_situacao_func) REFERENCES aux_situacoes_funcionario(id_situacao_func)
);

CREATE TABLE tbl_folha_pagamento (
    id_folha INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT NOT NULL,
    mes_referencia INT NOT NULL,
    ano_referencia INT NOT NULL,
    salario_bruto DECIMAL(10,2) NOT NULL,
    descontos DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    bonus_comissoes DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    salario_liquido DECIMAL(10,2) GENERATED ALWAYS AS (salario_bruto - descontos + bonus_comissoes) STORED,
    data_pagamento DATE,
    id_status_folha INT NOT NULL,
    CONSTRAINT fk_folha_func FOREIGN KEY (id_funcionario) REFERENCES tbl_funcionarios(id_funcionario),
    CONSTRAINT fk_folha_status FOREIGN KEY (id_status_folha) REFERENCES aux_status_folha(id_status_folha),
    CONSTRAINT chk_mes CHECK (mes_referencia BETWEEN 1 AND 12)
);

CREATE TABLE tbl_historico_acessos_log (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT NOT NULL,
    data_hora_acesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    acao_realizada VARCHAR(100) NOT NULL,
    tabela_afetada VARCHAR(50),
    CONSTRAINT fk_log_func FOREIGN KEY (id_funcionario) REFERENCES tbl_funcionarios(id_funcionario)
);


-- ====================================================================
-- 2. SETOR: OPERACIONAL & ESTOQUE
-- ====================================================================

CREATE TABLE tbl_produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    descricao TEXT,
    id_setor_responsavel INT NOT NULL,
    CONSTRAINT fk_prod_setor FOREIGN KEY (id_setor_responsavel) REFERENCES tbl_setores(id_setor)
);

CREATE TABLE tbl_estoque (
    id_produto INT PRIMARY KEY,
    quantidade_atual INT NOT NULL DEFAULT 0,
    quantidade_minima INT NOT NULL DEFAULT 10,
    preco_custo_medio DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    preco_venda_atual DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_est_produto FOREIGN KEY (id_produto) REFERENCES tbl_produtos(id_produto)
);


-- ====================================================================
-- 3. SETOR: COMPRAS & COTAÇÕES
-- ====================================================================

CREATE TABLE tbl_fornecedores (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(100) NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE tbl_solicitacoes_compra (
    id_solicitacao INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    quantidade_solicitada INT NOT NULL,
    data_solicitacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_status_solicitacao INT NOT NULL,
    id_funcionario_solicitante INT NOT NULL,
    CONSTRAINT fk_sol_produto FOREIGN KEY (id_produto) REFERENCES tbl_produtos(id_produto),
    CONSTRAINT fk_sol_func FOREIGN KEY (id_funcionario_solicitante) REFERENCES tbl_funcionarios(id_funcionario),
    CONSTRAINT fk_sol_status FOREIGN KEY (id_status_solicitacao) REFERENCES aux_status_solicitacao(id_status_solicitacao)
);

CREATE TABLE tbl_cotacoes (
    id_cotacao INT AUTO_INCREMENT PRIMARY KEY,
    id_solicitacao INT NOT NULL,
    id_fornecedor INT NOT NULL,
    preco_unitario_cotado DECIMAL(10,2) NOT NULL,
    prazo_entrega_dias INT NOT NULL,
    id_condicao_compra INT NOT NULL,
    escolhida CHAR(1) DEFAULT 'N',
    CONSTRAINT fk_cot_solicitacao FOREIGN KEY (id_solicitacao) REFERENCES tbl_solicitacoes_compra(id_solicitacao),
    CONSTRAINT fk_cot_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedores(id_fornecedor),
    CONSTRAINT fk_cot_condicao FOREIGN KEY (id_condicao_compra) REFERENCES aux_condicoes_pagamento_compras(id_condicao_compra),
    CONSTRAINT chk_cot_escolhida CHECK (escolhida IN ('S', 'N'))
);


-- ====================================================================
-- 4. FLUXO: PEDIDO DE COMPRA -> FINANCEIRO -> NOTA FISCAL -> RECEBIMENTO
-- ====================================================================

CREATE TABLE tbl_pedidos_compra (
    id_pedido_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_fornecedor INT NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_status_pedido INT NOT NULL,
    valor_total_pedido DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_pedido_forn FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedores(id_fornecedor),
    CONSTRAINT fk_pedido_status FOREIGN KEY (id_status_pedido) REFERENCES aux_status_pedido_compra(id_status_pedido)
);

CREATE TABLE tbl_itens_pedido_compra (
    id_pedido_compra INT,
    id_produto INT,
    quantidade_pedida INT NOT NULL,
    preco_unitario_acordado DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido_compra, id_produto),
    CONSTRAINT fk_itp_pedido FOREIGN KEY (id_pedido_compra) REFERENCES tbl_pedidos_compra(id_pedido_compra),
    CONSTRAINT fk_itp_produto FOREIGN KEY (id_produto) REFERENCES tbl_produtos(id_produto)
);

CREATE TABLE tbl_contas_a_pagar (
    id_conta_pagar INT AUTO_INCREMENT PRIMARY KEY,
    id_fornecedor INT NOT NULL,
    id_pedido_compra INT NOT NULL,
    valor_duplicata DECIMAL(10,2) NOT NULL,
    data_vencimento DATE NOT NULL,
    data_pagamento DATE,
    id_status_cp INT NOT NULL,
    CONSTRAINT fk_cp_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedores(id_fornecedor),
    CONSTRAINT fk_cp_pedido FOREIGN KEY (id_pedido_compra) REFERENCES tbl_pedidos_compra(id_pedido_compra),
    CONSTRAINT fk_cp_status FOREIGN KEY (id_status_cp) REFERENCES aux_status_contas_pagar(id_status_cp)
);

CREATE TABLE tbl_notas_fiscais_entrada (
    id_nf INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido_compra INT NOT NULL,
    numero_nota_fiscal VARCHAR(50) NOT NULL UNIQUE,
    data_emissao DATE NOT NULL,
    data_entrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total_nf DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_nf_pedido FOREIGN KEY (id_pedido_compra) REFERENCES tbl_pedidos_compra(id_pedido_compra)
);

CREATE TABLE tbl_itens_nf_entrada (
    id_nf INT,
    id_produto INT,
    quantidade_faturada INT NOT NULL,
    preco_unitario_nf DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_nf, id_produto),
    CONSTRAINT fk_itn_nf FOREIGN KEY (id_nf) REFERENCES tbl_notas_fiscais_entrada(id_nf),
    CONSTRAINT fk_itn_produto FOREIGN KEY (id_produto) REFERENCES tbl_produtos(id_produto)
);

CREATE TABLE tbl_recebimento_conferencia (
    id_recebimento INT AUTO_INCREMENT PRIMARY KEY,
    id_nf INT NOT NULL UNIQUE,
    id_funcionario_conferente INT,
    data_conferencia TIMESTAMP,
    id_situacao_conf INT NOT NULL,
    CONSTRAINT fk_rec_nf FOREIGN KEY (id_nf) REFERENCES tbl_notas_fiscais_entrada(id_nf),
    CONSTRAINT fk_rec_func FOREIGN KEY (id_funcionario_conferente) REFERENCES tbl_funcionarios(id_funcionario),
    CONSTRAINT fk_rec_situacao FOREIGN KEY (id_situacao_conf) REFERENCES aux_situacoes_conferencia(id_situacao_conf)
);

CREATE TABLE tbl_itens_recebimento_conferencia (
    id_recebimento INT,
    id_produto INT,
    quantidade_nf INT NOT NULL,
    quantidade_fisica_recebida INT DEFAULT 0,
    PRIMARY KEY (id_recebimento, id_produto),
    CONSTRAINT fk_itr_recebimento FOREIGN KEY (id_recebimento) REFERENCES tbl_recebimento_conferencia(id_recebimento),
    CONSTRAINT fk_itr_produto FOREIGN KEY (id_produto) REFERENCES tbl_produtos(id_produto)
);


-- ====================================================================
-- 5. SETOR: MARKETING & VENDAS (Correção da Sintaxe Aplicada Aqui)
-- ====================================================================

CREATE TABLE tbl_clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    documento VARCHAR(14) NOT NULL UNIQUE,
    id_tipo_cliente INT NOT NULL,
    CONSTRAINT fk_cliente_tipo FOREIGN KEY (id_tipo_cliente) REFERENCES aux_tipos_cliente(id_tipo_cliente)
);

CREATE TABLE tbl_campanhas_marketing (
    id_campanha INT AUTO_INCREMENT PRIMARY KEY,
    nome_campanha VARCHAR(50) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    orcamento_aprovado DECIMAL(10,2) NOT NULL,
    id_status_mkt INT NOT NULL,
    id_admin_aprovador INT,
    CONSTRAINT fk_mkt_admin FOREIGN KEY (id_admin_aprovador) REFERENCES tbl_funcionarios(id_funcionario),
    CONSTRAINT fk_mkt_status FOREIGN KEY (id_status_mkt) REFERENCES aux_status_campanha_mkt(id_status_mkt)
);

CREATE TABLE tbl_promocoes_produto (
    id_campanha INT,
    id_produto INT,
    desconto_percentual DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (id_campanha, id_produto),
    CONSTRAINT fk_promo_campanha FOREIGN KEY (id_campanha) REFERENCES tbl_campanhas_marketing(id_campanha),
    CONSTRAINT fk_promo_produto FOREIGN KEY (id_produto) REFERENCES tbl_produtos(id_produto)
);

CREATE TABLE tbl_vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_funcionario_vendedor INT NOT NULL,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_bruto DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    desconto_total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    valor_liquido DECIMAL(10,2) GENERATED ALWAYS AS (valor_bruto - desconto_total) STORED,
    CONSTRAINT fk_venda_cliente FOREIGN KEY (id_cliente) REFERENCES tbl_clientes(id_cliente),
    CONSTRAINT fk_venda_func FOREIGN KEY (id_funcionario_vendedor) REFERENCES tbl_funcionarios(id_funcionario) -- SINTAXE CORRIGIDA COM 'FOREIGN KEY'
);

CREATE TABLE tbl_itens_venda (
    id_venda INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco_unitario_praticado DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_venda, id_produto),
    CONSTRAINT fk_itv_venda FOREIGN KEY (id_venda) REFERENCES tbl_vendas(id_venda),
    CONSTRAINT fk_itv_produto FOREIGN KEY (id_produto) REFERENCES tbl_produtos(id_produto)
);

CREATE TABLE tbl_pagamentos_vendas (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    id_forma_pagto INT NOT NULL,
    valor_pago DECIMAL(10,2) NOT NULL,
    quantidade_parcelas INT DEFAULT 1,
    id_status_trans INT NOT NULL,
    CONSTRAINT fk_pag_venda FOREIGN KEY (id_venda) REFERENCES tbl_vendas(id_venda),
    CONSTRAINT fk_pag_forma FOREIGN KEY (id_forma_pagto) REFERENCES aux_formas_pagamento_vendas(id_forma_pagto),
    CONSTRAINT fk_pag_status FOREIGN KEY (id_status_trans) REFERENCES aux_status_transacao_venda(id_status_trans)
);

CREATE TABLE tbl_transacoes_cartao (
    id_transacao INT AUTO_INCREMENT PRIMARY KEY,
    id_pagamento INT NOT NULL,
    id_bandeira INT NOT NULL,
    codigo_autorizacao VARCHAR(50) NOT NULL,
    taxa_antecipacao_percentual DECIMAL(4,2) NOT NULL DEFAULT 0.00,
    valor_liquido_recebivel DECIMAL(10,2) NOT NULL,
    data_credito_esperada DATE NOT NULL,
    CONSTRAINT fk_tc_pagamento FOREIGN KEY (id_pagamento) REFERENCES tbl_pagamentos_vendas(id_pagamento),
    CONSTRAINT fk_tc_bandeira FOREIGN KEY (id_bandeira) REFERENCES aux_bandeiras_cartao(id_bandeira)
);


-- ====================================================================
-- 6. SETOR: TI (Ativos Internos)
-- ====================================================================

CREATE TABLE tbl_ativos_ti (
    id_ativo INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL, 
    numero_patrimonio VARCHAR(50) NOT NULL UNIQUE,
    id_setor_alocado INT NOT NULL,
    id_funcionario_responsavel INT,
    id_status_ti INT NOT NULL,
    CONSTRAINT fk_ti_produto FOREIGN KEY (id_produto) REFERENCES tbl_produtos(id_produto),
    CONSTRAINT fk_ti_setor FOREIGN KEY (id_setor_alocado) REFERENCES tbl_setores(id_setor),
    CONSTRAINT fk_ti_func FOREIGN KEY (id_funcionario_responsavel) REFERENCES tbl_funcionarios(id_funcionario),
    CONSTRAINT fk_ti_status FOREIGN KEY (id_status_ti) REFERENCES aux_status_ativos_ti(id_status_ti)
);


-- ====================================================================
-- 7. SETOR: ADMINISTRAÇÃO & PREVISÃO GLOBAL
-- ====================================================================

CREATE TABLE tbl_previsao_financeira (
    id_previsao INT AUTO_INCREMENT PRIMARY KEY,
    data_competencia DATE NOT NULL,
    id_tipo_fluxo INT NOT NULL,
    id_categoria_previsao INT NOT NULL,
    valor_previsto DECIMAL(10,2) NOT NULL,
    identificador_origem_id INT NOT NULL,
    CONSTRAINT fk_prev_fluxo FOREIGN KEY (id_tipo_fluxo) REFERENCES aux_tipos_fluxo_caixa(id_tipo_fluxo),
    CONSTRAINT fk_prev_categoria FOREIGN KEY (id_categoria_previsao) REFERENCES aux_categorias_previsao(id_categoria_previsao)
);


-- ====================================================================
-- 8. CARGA DE DOMÍNIO OBRIGATÓRIA (Tabelas aux_ e tbl_setores)
-- ====================================================================

INSERT INTO aux_niveis_acesso (nome_nivel) VALUES ('TOTAL'), ('GERENCIAL'), ('OPERACIONAL'), ('LEITURA');
INSERT INTO aux_situacoes_funcionario (nome_situacao) VALUES ('ATIVO'), ('AFASTADO'), ('DESLIGADO');
INSERT INTO aux_status_folha (nome_status) VALUES ('PROVISIONADO'), ('PAGO'), ('RETIDO');
INSERT INTO aux_status_solicitacao (nome_status) VALUES ('PENDENTE'), ('EM COTAÇÃO'), ('ATENDIDA'), ('REJEITADA');
INSERT INTO aux_condicoes_pagamento_compras (nome_condicao) VALUES ('À VISTA'), ('30 DIAS'), ('30/60 DIAS'), ('60 DIAS');
INSERT INTO aux_status_pedido_compra (nome_status) VALUES ('ABERTO'), ('FINANCEIRO_OK'), ('FATURADO'), ('CANCELADO');
INSERT INTO aux_situacoes_conferencia (nome_situacao) VALUES ('AGUARDANDO'), ('APROVADO'), ('DIVERGENTE_QUANTIDADE'), ('DIVERGENTE_VALOR'), ('REJEITADO');
INSERT INTO aux_status_contas_pagar (nome_status) VALUES ('A VENCER'), ('VENCIDO'), ('PAGO'), ('RENEGOCIADO');
INSERT INTO aux_tipos_cliente (descricao_tipo) VALUES ('FÍSICA'), ('JURÍDICA');
INSERT INTO aux_status_campanha_mkt (nome_status) VALUES ('PLANEJAMENTO'), ('APROVADA'), ('EM EXECUÇÃO'), ('CONCLUÍDA'), ('REJEITADA');
INSERT INTO aux_formas_pagamento_vendas (nome_forma) VALUES ('DINHEIRO'), ('CARTÃO CRÉDITO'), ('CARTÃO DÉBITO'), ('PIX'), ('BOLETO');
INSERT INTO aux_status_transacao_venda (nome_status) VALUES ('PENDENTE'), ('APROVADO'), ('REJEITADO'), ('ESTORNADO');
INSERT INTO aux_bandeiras_cartao (nome_bandeira) VALUES ('VISA'), ('MASTERCARD'), ('ELO'), ('AMEX'), ('HIPERCARD');
INSERT INTO aux_status_ativos_ti (nome_status) VALUES ('OPERACIONAL'), ('MANUTENÇÃO'), ('OBSOLETO'), ('BAIXADO');
INSERT INTO aux_tipos_fluxo_caixa (sigla_fluxo, descricao_fluxo) VALUES ('E', 'ENTRADA'), ('S', 'SAÍDA');
INSERT INTO aux_categorias_previsao (nome_categoria) VALUES ('FOLHA DE PAGAMENTO'), ('DUPLICATA FORNECEDOR'), ('RECEBIMENTO CLIENTE DIRECT'), ('RECEBIMENTO CARTÃO');

INSERT INTO tbl_setores (nome_setor, descricao) VALUES 
('Administração', 'Gestão estratégica e dashboards globais'),
('RH', 'Gestão de pessoas e folha de pagamento'),
('Operacional - Estoque', 'Armazenagem física e conferência de materiais'),
('TI', 'Infraestrutura tecnológica e gestão de insumos de informática'),
('Compras', 'Cotações de mercado e pedidos de aquisição'),
('Marketing', 'Campanhas publicitárias e tabelas promocionais'),
('Vendas', 'Faturamento e controle de recebíveis de clientes');

select * from tbl_setores;

