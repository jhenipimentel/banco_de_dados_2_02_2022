DROP DATABASE IF EXISTS aprendendoleft;
CREATE DATABASE aprendendoleft;

USE aprendendoleft;

DROP DATABASE IF EXISTS alunos;
DROP DATABASE IF EXISTS classe;
DROP DATABASE IF EXISTS professores;

CREATE TABLE  classe(
    id_classe INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_classe VARCHAR(100) NOT NULL,
    descricao TEXT,
    ano VARCHAR(4) NOT NULL
);

CREATE TABLE alunos(
    id_aluno INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    documento VARCHAR(20) NOT NULL,
    id_classe INTEGER,
    FOREIGN KEY (id_classe) REFERENCES classe(id_classe)

);

CREATE TABLE professores(
    id_professor INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    documento VARCHAR(20) NOT NULL,
    id_classe INTEGER,
    FOREIGN KEY (id_classe) REFERENCES classe(id_classe)
);

INSERT INTO classe (nome_classe, descricao, ano) VALUES
('A', 'turma que entrou no inicio do ano', 2021),
('B', 'turma que entrou no meio do ano', 2021);

INSERT INTO alunos (nome, sobrenome, documento, id_classe) VALUES
('Mariana', 'sobrenome do Mariana', 'XX.XXX.XXX.X', 1),
('Josiane', 'sobrenome do Josiane', 'XX.XXX.XXX.X', 1),
('Sophia', 'sobrenome do Sophia', 'XX.XXX.XXX.X', 1),
('Alice', 'sobrenome do Alice', 'XX.XXX.XXX.X', 1),
('Poliana', 'sobrenome do Poliana', 'XX.XXX.XXX.X', 2),
('Priscila', 'sobrenome do Priscila', 'XX.XXX.XXX.X',2),
('Deusita', 'sobrenome do Deusita', 'XX.XXX.XXX.X', 2),
('Vilma', 'sobrenome do Vilma', 'XX.XXX.XXX.X', 2),
('Maria', 'sobrenome do Maria', 'XX.XXX.XXX.X', 2),
('Bianca', 'sobrenome do Bianca', 'XX.XXX.XXX.X', 2);

INSERT INTO alunos (nome, sobrenome, documento) VALUES
('Ernani', 'sobrenome do ernani', 'XX.XXX.XXX.X')

SELECT 'Alunos - inner join ' AS 'log';

SELECT 
    alunos.nome
FROM
    alunos
INNER JOIN classe ON alunos.id_classe = classe.id_classe;

SELECT 'Alunos - left join ' AS 'log';

SELECT 
    alunos.nome
FROM
    alunos
LEFT JOIN classe ON alunos.id_classe = classe.id_classe;

SELECT 'Alunos - right join ' AS 'log';

SELECT 
    alunos.nome
FROM
    alunos
RIGHT JOIN classe ON alunos.id_classe = classe.id_classe;