/*       */

SELECT 
    'specific  select on customer table'
AS  
    'INFO';

SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    customer.active
FROM
    customer
LIMIT 15;

/*       */

SELECT 
    'Select soma specific people with and'
AS  
    'INFO';

SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    customer.active
FROM
    customer
WHERE
    customer.first_name = 'MARY' OR
    customer.first_name = 'PATRICIA'
LIMIT 15;

/*       */

SELECT 
    'Select some specific people with and'
AS  
    'INFO';

SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    customer.active
FROM
    customer
WHERE
    customer.first_name = 'MARY' AND
    customer.first_name = 'PATRICIA'
LIMIT 15;

/*       */

SELECT 
    'Select some specific and that works'
AS  
    'INFO';

SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    customer.active
FROM
    customer
WHERE
    customer.first_name = 'WADE' AND
    customer.email = 'WADE.DELVALLE@sakilacustomer.org'
LIMIT 15;

/*       */

SELECT 
    'Specific selcts of films'
AS  
    'INFO';

SELECT
    film.title,
    film.description,
    film.length,
    film.release_year,
    film.length,
    film.language_id,
    film.rating
FROM
    film
WHERE
    (film.release_year > 2000 AND film.release_year < 2010) AND
    (film.length > 70 AND film.length < 80) AND
    (film.language_id = 1 OR film.language_id = 5) AND
    (film.rating = 'G' OR film.rating = 'R' OR film.rating = 'NC-17')
LIMIT 40;

/*       */

SELECT 
    'USE OF in'
AS  
    'INFO';

SELECT
    film.title,
    film.description,
    film.length,
    film.release_year,
    film.length,
    film.language_id,
    film.rating
FROM
    film
WHERE
    (film.release_year > 2000 AND film.release_year < 2010) AND
    (film.length > 70 AND film.length < 80) AND
    (film.language_id  IN (1,5)) AND
    (film.rating IN('G', 'R', 'NC-17'))
LIMIT 40;

/*       */

SELECT 
    'USE OF BETWEEN'
AS  
    'INFO';

SELECT
    film.title,
    film.description,
    film.length,
    film.release_year,
    film.length,
    film.language_id,
    film.rating
FROM
    film
WHERE
    (film.release_year BETWEEN 2000 AND 2010) AND
    (film.length BETWEEN 70 AND 80) AND
    (film.language_id  IN (1,5)) AND
    (film.rating IN('G', 'R', 'NC-17'))
LIMIT 40;

/*       */

SELECT 
    'Introduction to sub Query'
AS  
    'INFO';

SELECT
    film.title,
    film.description,
    film.length,
    film.release_year,
    film.length,
    film.language_id,
    film.rating
FROM
    film
WHERE
    (film.release_year BETWEEN 2000 AND 2010) AND
    (film.length BETWEEN 70 AND 80) AND
    (film.language_id IN(( SELECT language_id FROM language WHERE name = 'English' ), ( SELECT language_id FROM language WHERE name = 'French', ( SELECT language_id FROM language WHERE name = 'Italian' )) )) AND
    (film.rating IN('G', 'R', 'NC-17'))
    ORDER BY film. language_id

LIMIT 40;

/*       */

SELECT 
    'Introduction to sub Query with variable'
AS  
    'INFO';

SET @FRENCH_ID=(SELECT language_id
FROM
    language
WHERE
    name ='French');

SET @ENGLiSH_ID=(SELECT language_id
FROM
    language
WHERE
    name ='English');

SET @ITALIAN_ID=(SELECT language_id
FROM
    language
WHERE
    name ='Italian');

SELECT
        film.title,
    film.description,
    film.length,
    film.release_year,
    film.length,
    film.language_id,
    film.rating
FROM
    film
WHERE
    (film.release_year BETWEEN 2000 AND 2010) AND
    (film.length BETWEEN 70 AND 80) AND
    (film.language_id IN(( SELECT language_id FROM language WHERE name = 'English' ), ( SELECT language_id FROM language WHERE name = 'French', ( SELECT language_id FROM language WHERE name = 'Italian' )) )) AND
    (film.rating IN('G', 'R', 'NC-17'))
ORDER BY film. language_id
DESC
LIMIT 40;
