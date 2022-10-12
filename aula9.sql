use sakila;

SELECT 'crating a view' as 'log';

CREATE 
    VIEW select_all_actors
as(
    SELECT actor.first_name FROM actor
);

SELECT 'usuing' as 'log';

SELECT * FROM select_all_actors;