CREATE DATABASE IF NOT EXISTS prova_1 CHARACTER SET utf8mb4;

USE prova_1;

DROP TABLE IF EXISTS cargos;
DROP TABLE IF EXISTS empresa;
DROP TABLE IF EXISTS clientes_produtos;
DROP TABLE IF EXISTS usuarios_produtos;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS clientes;


CREATE TABLE usuarios(
    id_usuario      INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome_usuario    VARCHAR(255) NOT NULL,
    endereco        VARCHAR(255) NOT NULL,
    cargo_usuario   ENUM('estoquista', 'vendedor', 'secretario')
    
    
);

CREATE TABLE cargos(
    id_cargo        INTEGER PRIMARY KEY AUTO_INCREMENT,
    cargo_usuario   ENUM('estoquista','vendedor','secretario'),
    id_usuario      INTEGER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE produtos(
    id_produto      INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome_produto    VARCHAR(255) NOT NULL,
    preco_compra    VARCHAR(255) NOT NULL,
    preco_venda     VARCHAR(255) NOT NULL,
    quantidade      VARCHAR(255) NOT NULL
    
);

CREATE TABLE empresa(
    empresa         VARCHAR(255) PRIMARY KEY NOT NULL,
    nome_produto    VARCHAR(255) NOT NULL,
    id_produto      INTEGER NOT NULL,
    CONSTRAINT id_produto FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

CREATE TABLE clientes(
    id_cliente      INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome_cliente    VARCHAR(255) NOT NULL,
    cnpj_cpf        VARCHAR(255) NOT NULL,
    endereco        VARCHAR(255) NOT NULL
    
);

CREATE TABLE clientes_produtos(
    id_cliente      INTEGER NOT NULL,
    id_produto      INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
     
);

CREATE TABLE usuarios_produtos(
    id_usuario     INTEGER NOT NULL,
    id_produto     INTEGER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

INSERT INTO usuarios (nome_usuario, endereco, cargo_usuario) VALUES
    ('Agusto Benitze', 'Rua jose alfredo ribas, 1232', 'vendedor');

INSERT INTO cargos (cargo_usuario) VALUES
    ('vendedor');

INSERT INTO produtos (nome_produto, preco_compra, preco_venda, quantidade) VALUES
    ('chocolate', '1,50', '5,00', '121');

INSERT INTO empresa (empresa, nome_produto) VALUES
    ('Nestle', 'crunch');

INSERT INTO clientes (nome_cliente, cnpj_cpf, endereco) VALUES
    ('Luiz Pimentel', '212.343.445-54', 'Rua Waldemiro Ry 1011');
SELECT
    "tabela - usuarios"
AS
    "INFO"; 
SELECT * FROM usuarios;
SELECT
    "tabela - cargos"
AS
    "INFO"; 
SELECT * FROM cargos;
SELECT
    "tabela - produtos"
AS
    "INFO"; 
SELECT * FROM produtos;
SELECT
    "tabela - empresa"
AS
    "INFO"; 
SELECT * FROM empresa;
SELECT
    "tabela - clientes"
AS
    "INFO"; 
SELECT * FROM clientes;