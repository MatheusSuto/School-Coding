USE db_empresa_integrada;

-- ====================================================================
-- 0. TABELAS AUXILIARES DE DOMÍNIO PARA LOGÍSTICA INTERNA
-- ====================================================================

CREATE TABLE aux_status_movimentacao_interna (
    id_status_movi INT AUTO_INCREMENT PRIMARY KEY,
    nome_status VARCHAR(30) NOT NULL UNIQUE -- 'PENDENTE', 'EM SEPARAÇÃO', 'EM TRÂNSITO', 'CONCLUÍDA', 'CANCELADA'
);

-- ====================================================================
-- 1. NOVO MÓDULO: SOLICITAÇÃO E TRANSFERÊNCIA INTERNA DE CARGAS
-- ====================================================================

CREATE TABLE tbl_solicitacoes_movimentacao_estoque (
    id_solicitacao_movi INT AUTO_INCREMENT PRIMARY KEY,
    
    -- Origem estrita (Aponta para onde o produto ESTÁ mapeado hoje no WMS)
    id_posicionamento_origem INT NOT NULL,
    
    -- Destino (Para qual endereço físico do mapa ele irá)
    id_endereco_destino INT NOT NULL,
    
    -- Detalhes da carga a ser deslocada
    quantidade_solicitada INT NOT NULL,
    volume_estimado_m3 DECIMAL(6,2) NOT NULL,
    
    -- Controle Operacional e Recursos Humanos
    id_funcionario_solicitante INT NOT NULL,
    id_funcionario_operador INT, -- Quem vai de fato empilhar/mover a carga
    
    -- Estados do Processo
    id_status_movi INT NOT NULL,
    data_solicitacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_execucao TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    
    -- Amarrações de Integridade Relacional
    CONSTRAINT fk_movi_pos_origem FOREIGN KEY (id_posicionamento_origem) REFERENCES tbl_posicionamento_estoque(id_posicionamento),
    CONSTRAINT fk_movi_end_destino FOREIGN KEY (id_endereco_destino) REFERENCES tbl_enderecos_estoque(id_endereco_estoque),
    CONSTRAINT fk_movi_func_solic  FOREIGN KEY (id_funcionario_solicitante) REFERENCES tbl_funcionarios(id_funcionario),
    CONSTRAINT fk_movi_func_operador FOREIGN KEY (id_funcionario_operador) REFERENCES tbl_funcionarios(id_funcionario),
    CONSTRAINT fk_movi_status FOREIGN KEY (id_status_movi) REFERENCES aux_status_movimentacao_interna(id_status_movi),
    
    -- Trava de segurança básica inicial via DDL
    CONSTRAINT chk_qtd_movi CHECK (quantidade_solicitada > 0)
);

-- ====================================================================
-- 2. CARGA DE DOMÍNIO OBRIGATÓRIA
-- ====================================================================

INSERT INTO aux_status_movimentacao_interna (nome_status) VALUES 
('PENDENTE'), 
('EM SEPARAÇÃO'), 
('EM TRÂNSITO'), 
('CONCLUÍDA'), 
('CANCELADA');

