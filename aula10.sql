DROP DATABASE IF EXISTS aula10;
CREATE DATABASE IF NOT EXISTS aula10 CHARACTER SET utf8mb4;

USE aula10;

CREATE TABLE  carros(
    id_carro INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    ano VARCHAR(4) NOT NULL
);

INSERT INTO carros (nome, modelo, ano) VALUES
    ('chevette', 'chevrolet', '1995'),
    ('gol', 'volkswagen', '2010'),
    ('onix', 'chevrolet', '2020');

CREATE TABLE  vendedores(
    id_vendedor INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    cpf VARCHAR(255) NOT NULL
);

INSERT INTO vendedores (nome, sobrenome, cpf) VALUES
    ('Jose', 'Silva', '125.254.578-87'),
    ('Fabio', 'Lima', '698.154.758-89');

CREATE TABLE  compradores(
    id_comprador INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    cpf VARCHAR(255) NOT NULL
);

INSERT INTO compradores (nome, sobrenome, cpf) VALUES
    ('Odair', 'silveira', '524.758.545-54');

CREATE TABLE  comp_vend_carro(
    id_compr_vend_carro INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_comprador INTEGER NOT NULL,
    FOREIGN KEY (id_comprador) REFERENCES compradores(id_comprador),
    id_vendedor INTEGER NOT NULL,
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor),
    id_carro INTEGER NOT NULL,
    FOREIGN KEY (id_carro) REFERENCES carros(id_carro)
);

INSERT INTO comp_vend_carro(id_comprador, id_vendedor, id_carro) VALUES(
    (SELECT id_comprador FROM compradores WHERE nome = 'Odair'),
    (SELECT id_vendedor FROM vendedores WHERE nome = 'Jose'),
    (SELECT id_carro FROM carros WHERE nome = 'Gol')
);

SELECT 
    compradores.nome as  nome_comprador,
    compradores.sobrenome as sobrenome_comprador,
    compradores.cpf as cpf_comprador,
    vendedores.nome as nome_vendedor,
    vendedores.sobrenome as sobrenome_vendedor,
    vendedores.cpf as cpf_vendedor,
    carros.nome as nome_carro,
    carros.modelo as modelo_carro,
    carros.ano as ano_carro

FROM
    comp_vend_carro
INNER JOIN
    compradores
    ON comp_vend_carro.id_comprador = compradores.id_comprador
INNER JOIN
    vendedores
    ON comp_vend_carro.id_vendedor = vendedores.id_vendedor
INNER JOIN
    carros
    ON comp_vend_carro.id_carro = carros.id_carro;