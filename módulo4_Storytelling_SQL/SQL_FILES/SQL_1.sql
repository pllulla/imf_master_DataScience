SELECT * FROM film;

SELECT count(*) AS cuentapelis FROM film;

SELECT MAX(length) AS mas_larga FROM film;
SELECT MIN(length) AS mas_corta FROM film;
SELECT AVG(length) AS media_duracion FROM film;
SELECT MAX(length), MIN(length), AVG(length) FROM film;

SELECT * FROM actor;

SELECT COUNT(*) AS total_actores FROM actor;

SELECT first_name, last_name, COUNT(*) AS repeticiones
FROM actor
GROUP BY first_name, last_name
HAVING COUNT(*) > 1;

SELECT last_name, count(*)
FROM actor
GROUP BY last_name desc;

