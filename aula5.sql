CREATE DATABASE IF NOT EXISTS aprender_join CHARACTER SET utf8mb4;

USE aprender_join;

DROP TABLE IF EXISTS restaurantes;
DROP TABLE IF EXISTS cidade;
DROP TABLE IF EXISTS estado;

CREATE TABLE IF NOT EXISTS estado(
    id_estado INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    regiao ENUM('sul', 'sudeste', 'norte', 'nordeste', 'centro-oeste')
);


CREATE TABLE IF NOT EXISTS cidade(
    id_cidade INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    id_estado INTEGER NOT NULL,
    FOREIGN KEY (id_estado) REFERENCES estado(id_estado)
);

INSERT INTO
    estado(nome, regiao)
VALUES
    ('Parana', 'sul'),
    ('Sao Paulo', 'sudeste'),
    ('Rio de janeiro', 'sudeste'),
    ('Bahia', 'nordeste'),
    ('Pernanbuco', 'nordeste'),
    ('Para', 'norte'),
    ('Mato Grosso', 'Centro-oeste');

SET @idParana:=(SELECT id_estado FROM estado WHERE estado.nome = "Parana");
SET @idSaoPaulo:=(SELECT id_estado FROM estado WHERE estado.nome = "Sao Paulo");
SET @idRiojaneiro:=(SELECT id_estado FROM estado WHERE estado.nome = "Rio de janeiro");
SET @idBahia:=(SELECT id_estado FROM estado WHERE estado.nome = "Bahia");
SET @idPernanbuco:=(SELECT id_estado FROM estado WHERE estado.nome = "Pernanbuco");
SET @idPara=(SELECT id_estado FROM estado WHERE estado.nome = "Para");
SET @idMatoGrosso:=(SELECT id_estado FROM estado WHERE estado.nome = "Mato Grosso");

INSERT INTO cidade (nome, id_estado) VALUES
    ('Curitiba', @idParana),
    ('Londrina', @idParana),
    ('Paranagua', @idParana),
    ('Sao Paulo', @idSaoPaulo),
    ('Sorocaba', @idSaoPaulo),
    ('Rio de Janeiro', @idRiojaneiro),
    ('Niteroi',@idRiojaneiro),
    ('Mage', @idRiojaneiro),
    ('Porto Real', @idRiojaneiro),
    ('Petropoles', @idRiojaneiro),
    ('Salvador', @idBahia),
    ('Feira de Santana', @idBahia),
    ('recife', @idPernanbuco),
    ('Olinda', @idPernanbuco),
    ('Petrolina', @idPernanbuco),
    ('Belem', @idPara),
    ('Cuiaba', @idMatoGrosso);

SELECT * FROM cidade;

SELECT
    estado.nome
FROM
    estado
WHERE
    estado.id_estado =(
        SELECT
            cidade.id_estado
        FROM
            cidade
        WHERE
            cidade.nome ='Petropoles');

SELECT
    *
FROM
    cidade
INNER JOIN/*join significa junção, junta duas tabelas, melhora a performace de pesquisa, elel forma duas tabelas e uma tabelona 
e pesquisa e tras o resultado*/
    estado ON cidade.id_estado = estado.id_estado
WHERE
    cidade.nome = 'Petropoles';

CREATE TABLE restaurantes(
    id_restaurante INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    descricao VARCHAR(255),
    id_cidade INTEGER NOT NULL,
    FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade)
);

SET @idCuritibaCidade:=(SELECT id_cidade FROM cidade WHERE nome = "Curitiba");
SET @idSaoPauloCidade:=(SELECT id_cidade FROM cidade WHERE nome = "Sao Paulo");
SET @idRiojaneiroCidade:=(SELECT id_cidade FROM cidade WHERE nome = "Rio de janeiro");
SET @idPetropolesCidade:=(SELECT id_cidade FROM cidade WHERE nome = "Petropoles");
SET @idFeiraDeSantanaCidade:=(SELECT id_cidade FROM cidade WHERE nome = "Feira de Santana");

select @idFeiraDeSantanaCidade as 'cidade';

INSERT INTO restaurantes (nome, descricao, id_cidade) VALUES
    ('Comida mineira', 'comida tipica de minas', @idCuritibaCidade),
    ('fogo de chao', 'costela de fogo de chao', @idSaoPauloCidade),
    ('frangao', 'variedades de comidas feitas de frango', @idRiojaneiroCidade),
    ('pizza maronba', 'so pode comer aqui se voce usa bomba', @idPetropolesCidade),
    ('Mc donalds', 'lanches felizes', @idFeiraDeSantanaCidade);

SELECT * FROM restaurantes;

SELECT
    *
FROM
    restaurantes
INNER JOIN
    cidade ON cidade.id_cidade = restaurantes.id_cidade
WHERE
    restaurantes.nome = 'Mc donalds';


SELECT
    *
FROM
    cidade
INNER JOIN
    restaurantes ON restaurantes.id_cidade = cidade.id_cidade
WHERE
    restaurantes.nome = 'Mc donalds';

/*controlando colunas */
    
SELECT
    cidade.nome   as nome_da_cidade,
    restaurantes.nome as nome_do_restaurante,
    restaurantes.descricao as descricao_do_restaurante
FROM
    cidade
INNER JOIN
    restaurantes ON restaurantes.id_cidade = cidade.id_cidade
WHERE
    restaurantes.nome = 'Mc donalds';

/**/
SELECT 
    t1.nome_da_cidade,
    t1.nome_do_restaurante
FROM
(
    SELECT
        cidade.nome   as nome_da_cidade,
        restaurantes.nome as nome_do_restaurante,
        restaurantes.descricao as descricao_do_restaurante
    FROM
        cidade
    INNER JOIN
        restaurantes ON restaurantes.id_cidade = cidade.id_cidade
    WHERE
        restaurantes.nome LIKE '%M%'
) as t1

WHERE
    t1.nome_da_cidade = 'Curitiba';

SELECT 'com mais de um inner join ------------------' as 'INFO';

SELECT
    cidade.nome   as nome_da_cidade,
    restaurantes.nome as nome_do_restaurante,
    restaurantes.descricao as descricao_do_restaurante
FROM
    restaurantes
INNER JOIN
    cidade ON restaurantes.id_cidade = cidade.id_cidade
INNER JOIN
    estado ON cidade.id_estado = estado.id_estado
WHERE
    restaurantes.nome LIKE "comida M%";
