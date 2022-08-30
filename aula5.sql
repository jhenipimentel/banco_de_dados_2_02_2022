CREATE DATABASE IF NOT EXISTS aprender_join CHARACTER SET utf8mb4;

USE aprender_join;

DROP TABLE IF EXISTS garcom_restaurantes;
DROP TABLE IF EXISTS garcom;
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
    id_cidade INTEGER ,
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


INSERT INTO restaurantes (nome, descricao) VALUES
    ('Restaurante que nao esta em cidade alguma', 'Descricao');

SELECT "Fazemdo busca com restaurantes na esquerda em registro sem relacao entre ambas tabelas"
AS 
    "LOG";
SELECT 
    *
FROM
    cidade
INNER JOIN
    restaurantes
    ON
        cidade.id_cidade = restaurantes.id_cidade
WHERE
    restaurantes.nome = 'Restaurante que nao esta em cidade alguma';

SELECT "Fazemdo busca com restaurantes na esquerda em registro sem relacao entre ambas tabelas"
AS 
    "LOG";
SELECT 
    *
FROM
    restaurantes
INNER JOIN
    cidade
    ON
        cidade.id_cidade = restaurantes.id_cidade
WHERE
    restaurantes.nome = 'Restaurante que nao esta em cidade alguma';

SELECT "Traga tudo"
AS 
    "LOG";
SELECT 
    cidade.nome,
    restaurantes.nome
FROM
    restaurantes
INNER JOIN
    cidade
    ON
        cidade.id_cidade = restaurantes.id_cidade;


INSERT INTO restaurantes (nome, descricao, id_cidade) VALUES
    ('MC Donalds', '3 bigmacs ', @idCuritibaCidade),
    ('Habbis', 'Homem bomba ', @idCuritibaCidade),
    ('Terrazo', 'retaurante de rico ', @idCuritibaCidade),
    ('Calabouso', ' restaurante de rico', @idCuritibaCidade);


SELECT
    *
FROM
    restaurantes
INNER JOIN
    cidade ON restaurantes.id_cidade = cidade.id_cidade
WHERE
cidade.nome = 'Curitiba';

INSERT INTO restaurantes (nome, descricao, id_cidade)VALUES
    ('Comida mineira', 'Comda tipica de minas', @idSaoPauloCidade);

SELECT 
    *
FROM
    restaurantes
INNER JOIN
    cidade ON restaurantes.id_cidade = cidade.id_cidade
WHERE
    cidade.nome IN('Curitiba', 'Sao Paulo');



CREATE TABLE garcom(
    id_garcom INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    experiencia ENUM('junior', 'pleno', 'senior'),
    tipo_documento ENUM('cpf', 'rg'),
    documento VARCHAR(255)
);

INSERT INTO 
    garcom (nome, experiencia, tipo_documento, documento)
VALUES
    ('Jorge','junior','cpf',949494),
    ('Alexandre','pleno','cpf',25949494),
    ('Odair','pleno','cpf',949949494),
    ('Pedro','pleno','cpf',49949494),
    ('Gerson','pleno','cpf',49949494),
    ('Junior','senior','cpf',49949494),
    ('Jonathan','senior','cpf',49949494),
    ('Augusto','senior','cpf',49949494);

SELECT * FROM garcom;


CREATE TABLE garcom_restaurantes (
    id_restaurante INTEGER ,
    id_garcom INTEGER ,
    dia_semana ENUM('segunda', 'terca', 'quarta', 'quinta', 'sexta', 'sabado', 'domingo'),
    FOREIGN KEY (id_restaurante) REFERENCES restaurantes(id_restaurante),
    FOREIGN KEY (id_garcom) REFERENCES garcom(id_garcom)        
);

INSERT INTO 
    garcom_restaurantes (id_restaurante, id_garcom, dia_semana)
VALUES
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pizza Maromba'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
        'segunda'         
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pertuti'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
        'terca'
    ),

    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Restaurante que nao esta em cidade alguma'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
        'quarta'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Mc Donalds' LIMIT 1),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
        'quinta'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Calabouco'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
        'sexta'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pizza Maromba'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
        'segunda'         
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pertuti'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Gerson'),
        'terca'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Mc Donalds' LIMIT 1),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Gerson'),
        'quinta'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Calabouco'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Gerson'),
        'sexta'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pizza Maromba'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Odair'),
        'segunda'         
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pertuti'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Odair'),
        'terca'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Restaurante que nao esta em cidade alguma'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Odair'),
        'quarta'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Mc Donalds' LIMIT 1),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Odair'),
        'quinta'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Calabouco'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Odair'),
        'sexta'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pizza Maromba'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Alexandre'),
        'segunda'         
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pertuti'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Alexandre'),
        'terca'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Restaurante que nao esta em cidade alguma'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Alexandre'),
        'quarta'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Mc Donalds' LIMIT 1),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Alexandre'),
        'quinta'
    ); 

SELECT
    * 
FROM 
    garcom
INNER JOIN
    garcom_restaurantes ON garcom.id_garcom = garcom_restaurantes.id_garcom
INNER JOIN
    restaurantes ON garcom_restaurantes.id_restaurante = restaurantes.id_restaurante
WHERE
    garcom.nome IN ('jorge', 'Odair', 'Gerson');

