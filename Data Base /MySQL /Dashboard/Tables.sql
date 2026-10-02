create database dash2026_Matheus_Suto;

use dash2026_Matheus_Suto;

-- 1. Tabela de Categorias
DROP TABLE IF EXISTS itens_venda;
DROP TABLE IF EXISTS vendas;
DROP TABLE IF EXISTS historico_precos_venda;
DROP TABLE IF EXISTS entradas_estoque;
DROP TABLE IF EXISTS fornecedores;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS categorias;

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    eh_perecivel BOOLEAN NOT NULL DEFAULT FALSE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Tabela Mestra de Produtos
CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    codigo_produto VARCHAR(50) NOT NULL UNIQUE,
    nome VARCHAR(150) NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Tabela de Fornecedores
CREATE TABLE fornecedores (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(150) NOT NULL,
    cnpj VARCHAR(18) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Entradas de Estoque / Lotes por Fornecedor (Com Preço de Compra e Validade)
CREATE TABLE entradas_estoque (
    id_entrada INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    id_fornecedor INT NOT NULL,
    preco_compra DECIMAL(10,2) NOT NULL,
    quantidade_comprada INT NOT NULL,
    quantidade_atual INT NOT NULL, -- Saldo físico restante do lote
    data_compra DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_validade DATE NULL, -- Preenchido obrigatoriamente se for perecível
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Histórico de Preços de Venda por Período Vigente
CREATE TABLE historico_precos_venda (
    id_preco INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME NULL, -- NULL indica o preço atual praticado
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Tabela de Vendas
CREATE TABLE vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    data_venda DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. Itens Vendidos associados ao Lote do Fornecedor
CREATE TABLE itens_venda (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    id_entrada INT NOT NULL,
    quantidade INT NOT NULL,
    preco_venda_praticado DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_entrada) REFERENCES entradas_estoque(id_entrada)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
