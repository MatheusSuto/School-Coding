-- WHS = Warehouse Management System

USE db_empresa_integrada;

-- ====================================================================
-- 0. TABELAS AUXILIARES DE DOMÍNIO PARA O WMS
-- ====================================================================

CREATE TABLE aux_tipos_estrutura_armazenagem (
    id_tipo_estrutura INT AUTO_INCREMENT PRIMARY KEY,
    nome_estrutura VARCHAR(50) NOT NULL UNIQUE -- 'PORTA-PALETE', 'BLOCADO', 'PRATELEIRA', 'DRIVE-IN'
);

-- ====================================================================
-- 1. EXPANSÃO DO SETOR: OPERACIONAL, LOGÍSTICA & WMS
-- ====================================================================

-- Solicitada: Cadastro de tipo / classificação de produtos
CREATE TABLE tbl_tipo_produtos (
    id_tipo_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_tipo VARCHAR(50) NOT NULL UNIQUE, -- 'ELETRÔNICOS', 'INFLAMÁVEIS', 'PERECÍVEIS', 'INSUMOS TI'
    descricao_tipo VARCHAR(150),
    exige_refrigeracao CHAR(1) DEFAULT 'N',
    CONSTRAINT chk_mkt_refrig CHECK (exige_refrigeracao IN ('S', 'N'))
);

-- Solicitada: Cadastro de áreas de armazenagem (armazéns macro)
CREATE TABLE tbl_armazens (
    id_armazem INT AUTO_INCREMENT PRIMARY KEY,
    nome_armazem VARCHAR(50) NOT NULL UNIQUE, -- 'BARRACÃO CENTRAL', 'CÂMARA FRIA 01', 'ALMOXARIFADO TI'
    localizacao_predial VARCHAR(100),
    area_total_m2 DECIMAL(10,2) NOT NULL
);

-- Nova: Endereçamento detalhado do estoque (Rua, Prédio, Altura, Nível e Capacidade)
CREATE TABLE tbl_enderecos_estoque (
    id_endereco_estoque INT AUTO_INCREMENT PRIMARY KEY,
    id_armazem INT NOT NULL,
    id_tipo_estrutura INT NOT NULL, -- Porta-palete, Blocado, etc.
    codigo_endereco VARCHAR(30) NOT NULL UNIQUE, -- Ex: 'RUA-A-PREDIO-02-NIVEL-03'
    rua VARCHAR(10) NOT NULL,
    bloco_predio VARCHAR(10) NOT NULL,
    nivel_altura VARCHAR(10) NOT NULL,
    volume_maximo_m3 DECIMAL(6,2) NOT NULL, -- Tamanho/Capacidade cúbica do espaço
    peso_maximo_kg DECIMAL(8,2) NOT NULL,    -- Carga máxima suportada pela estrutura
    CONSTRAINT fk_end_armazem FOREIGN KEY (id_armazem) REFERENCES tbl_armazens(id_armazem),
    CONSTRAINT fk_end_estrutura FOREIGN KEY (id_tipo_estrutura) REFERENCES aux_tipos_estrutura_armazenagem(id_tipo_estrutura)
);

-- Solicitada: Tabela de posicionamento de produto/carga em estoque e área ocupada
CREATE TABLE tbl_posicionamento_estoque (
    id_posicionamento INT AUTO_INCREMENT PRIMARY KEY,
    id_endereco_estoque INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade_alocada INT NOT NULL DEFAULT 0,
    volume_ocupado_m3 DECIMAL(6,2) NOT NULL, -- Área/Volume efetivamente ocupado pela carga
    data_armazenagem TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pos_endereco FOREIGN KEY (id_endereco_estoque) REFERENCES tbl_enderecos_estoque(id_endereco_estoque),
    CONSTRAINT fk_pos_produto FOREIGN KEY (id_produto) REFERENCES tbl_produtos(id_produto)
);

-- ====================================================================
-- 2. ALTERAÇÃO NECESSÁRIA NA TBL_PRODUTOS PARA INTEGRAÇÃO
-- ====================================================================

-- Vincula o produto ao seu respectivo Tipo/Classificação recém-criado
ALTER TABLE tbl_produtos 
ADD COLUMN id_tipo_produto INT NOT NULL AFTER nome_produto,
ADD CONSTRAINT fk_prod_tipo FOREIGN KEY (id_tipo_produto) REFERENCES tbl_tipo_produtos(id_tipo_produto);


-- ====================================================================
-- 3. CARGA DE DOMÍNIO E TESTE PARA O WMS
-- ====================================================================

INSERT INTO aux_tipos_estrutura_armazenagem (nome_estrutura) VALUES 
('PORTA-PALETE'), 
('BLOCADO'), 
('PRATELEIRA'), 
('DRIVE-IN');

INSERT INTO tbl_tipo_produtos (nome_tipo, descricao_tipo, exige_refrigeracao) VALUES
('Geral / Secos', 'Produtos que não exigem condições especiais de armazenamento', 'N'),
('Inflamáveis', 'Produtos químicos e combustíveis que exigem contenção', 'N'),
('Perecíveis / Congelados', 'Alimentos e produtos com shelf-life curto', 'S'),
('Insumos de Informática', 'Hardware, cabos e periféricos gerenciados pela TI', 'N');

INSERT INTO tbl_armazens (nome_armazem, localizacao_predial, area_total_m2) VALUES
('Galpão Logístico Principal', 'Bloco A - Setor Industrial', 1500.00),
('Câmara Fria Industrial', 'Bloco B - Anexo Isotérmico', 300.00),
('DML / Almoxarifado de TI', 'Bloco C - Próximo à Administração', 50.00);
