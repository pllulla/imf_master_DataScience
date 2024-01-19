SELECT * FROM film;
SELECT * FROM category;

-- Queremos saber cuántas películas hay de miedo y cuáles son sus datos
-- Utilizando las tablas film, film_category y category
SELECT f.title FROM film f
JOIN film_category fc ON f.film_id=fc.film_id
JOIN category c ON fc.category_id=c.category_id
WHERE c.name = 'horror';

SELECT count(*) FROM (SELECT f.title FROM film f
JOIN film_category fc ON f.film_id=fc.film_id
JOIN category c ON fc.category_id=c.category_id
WHERE c.name = 'horror') T1;

-- 2. Queremos saber cuál es el máximo, mínimo y media de duración de las películas por género y por rating.
-- Utilizando las tablas film, film_category y category
SELECT c.name AS genero,
		f.rating,
		MAX(f.length) AS max_duracion,
		MIN(f.length) AS min_duracion,
		AVG(f.length) AS avg_duracion
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name, f.rating;

-- 3. Queremos saber cuáles son los actores que han participado en más películas. Y de ellos, cuáles son los que han participado
-- en más comedias. Utilizando las tablas film, film_category, category, actor, film_actor
SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) AS total_films, SUM(CASE WHEN c.name = 'Comedy' THEN 1 ELSE 0 END) AS comedy_films
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY 5 DESC;


-- 4. Queremos saber quiénes son los clientes que han realizado más alquileres, en número de películas y en dinero gastado.
-- Utilizando las tablas rental, customer, inventory, film, payment



-- 5. Queremos saber cuál es el ratio por país de género de consumo de las películas.
-- Utilizando las tablas rental, customer, address, city, country, category, film_category.

