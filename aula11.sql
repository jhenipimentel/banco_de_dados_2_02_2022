
DROP DATABASE IF EXISTS aula8;
CREATE DATABASE aula8;

Use aula8;

DROP TABLE IF EXISTS editora;

CREATE TABLE editora(
    editora_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome  VARCHAR(20) NOT NULL,
    endereco VARCHAR(255) NOT NULL
);

INSERT INTO 
        editora (nome,endereco)
VALUES
        ('Abril', "rua abcd 111"),
        ('Madras', "rua dcb 222"),
        ('Globo', "rua xsg 222");

SELECT * FROM editora;

EXPLAIN SELECT * FROM editora WHERE nome = 'Globo';

CREATE INDEX idx_editora ON editora(nome);

SHOW INDEX FROM editora;

EXPLAIN SELECT * FROM editora WHERE nome = 'Globo';