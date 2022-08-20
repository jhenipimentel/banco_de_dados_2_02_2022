CREATE DATABASE IF NOT EXISTS aprender_join CHARACTER SET utf8mb4;

USE aprender_join;


CREATE TABLE IF NOT EXISTS estado(
    id_estado INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    region ENUM('sul', 'sudeste', 'norte', 'nordeste')
);


CREATE TABLE IF NOT EXISTS cidade(
    id_cidade INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    id_estado INTEGER NOT NULL,
    FOREIGN KEY (id_estado) REFERENCES estado(id_estado)
);