/*Trigger*/

DROP DATABASE IF EXISTS learn_trigger;
CREATE DATABASE learn_trigger;

USE learn_trigger;

CREATE TABLE seller(
    id_seller INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name_seller VARCHAR(255),
    created_at DATETIME DEFAULT NOW()

);

INSERT INTO seller(name_seller) VALUES
    ('Roberto'),
    ('Fabio'),
    ('Tiago');

CREATE TABLE produto(
    id_produto INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name_produto VARCHAR(255) NOT NULL,
    company VARCHAR(255),
    created_at DATETIME DEFAULT NOW()
    
); 

INSERT INTO produto(name_produto, company ) VALUES
    ('refrigerante', 'coca-cola'),
    ('chocolate', 'garoto'),
    ('sabao em po', 'OMO'),
    ('achocolatado', 'nescau');

CREATE TABLE inventory(
    id_inventory INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_seller INTEGER,
    id_produto INTEGER NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    quantity INTEGER NOT NULL,
    FOREIGN KEY (id_seller) REFERENCES seller(id_seller),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)

);

INSERT INTO inventory (id_produto, quantity ) VALUES
    (1, 40),
    (2, 70),
    (3, 70);

CREATE TABLE balance(
    id_balance INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    quantity_input INTEGER NOT NULL,
    quantity_output INTEGER NOT NULL,
    id_inventory INTEGER NOT NULL,
    FOREIGN KEY (id_inventory) REFERENCES inventory(id_inventory)

);

DELIMITER //
    CREATE TRIGGER tgr_itensvenda_insert AFTER INSERT ON balance 
        FOR EACH ROW
            BEGIN 
                UPDATE
                    inventory
                SET
                    quantity = NEW.quantity_input - NEW.quantity_output
                WHERE
                    inventory.id_inventory = NEW.id_inventory;
            END //
DELIMITER ;

SELECT id_inventory, quantity FROM inventory ;

INSERT INTO
    balance (quantity_input, quantity_output, id_inventory)
VALUES
    (90,40,1),
    (30,20,2),
    (100,20,3);

SELECT id_inventory, quantity FROM inventory ;

/*DELIMITER de UPDATE*/

DELIMITER //
    CREATE TRIGGER tgr_itensvenda_update AFTER UPDATE ON balance 
        FOR EACH ROW
            BEGIN 
                UPDATE
                    inventory
                SET
                    quantity = NEW.quantity_input - NEW.quantity_output
                WHERE
                    inventory.id_inventory = NEW.id_inventory;
            END //
DELIMITER ;

SELECT * FROM inventory ;

UPDATE
    balance 
SET
    quantity_input = 80,
    quantity_output = 80
WHERE
    id_inventory = 1;

SELECT * FROM inventory ;