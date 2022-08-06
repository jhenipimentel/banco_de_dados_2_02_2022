SELECT 
    "USE MySql database" 
AS 
    "INFO";

USE mysql;

SELECT
    "Drop database aula 1 if exist"
AS
    "INFO";
     
DROP DATABASE IF EXISTS aula1;

SELECT 
    "The creation of database"
AS
    "INFO";

CREATE DATABASE aula1;

SELECT
    "Use of database"
AS
    "INFO"; 
USE aula1;

SELECT 
    "Create table alunos"
AS
    "INFO";

DROP TABLE IF EXISTS students;

CREATE TABLE students(
    id_ano              INTEGER PRIMARY KEY AUTO_INCREMENT,
    first_name          VARCHAR(255) NOT NULL,
    lat_name            VARCHAR(255) NOT NULL,
    gender              ENUM('MA','FE'),
    code_registration   INTEGER UNIQUE,
    status              BOOLEAN DEFAULT true,
    created_at          DATETIME DEFAULT NOW(),
    deleted_at          DATETIME

);

DESCRIBE students;


INSERT INTO students(
    first_name,
    lat_name,
    gender,
    code_registration
)

    VALUES
(
    'Bruno',
    'Oliveira',
    'MA',
    1
),
(
    'Douglas',
    'Aving',
    'MA',
    2
),
(
    'Mariana',
    'Egypto',
    'FE',
    3
);

SELECT * FROM students;


