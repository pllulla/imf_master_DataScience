-- Ejercicios Sakila
-- Cuántas películas hay
select count(*) as cuentapeliculas from film;

-- Duración máxima, mínima y media de las películas
select max(length) as maximo, min(length) as minimo, avg(length) as media from film;

-- Actores repetidos
select count(*) from actor;
select distinct first_name, last_name from actor;

select last_name, count(*)
from actor
group by last_name
having count(*)>2
order by 2 desc
limit 5
;

select first_name, count(*)
from actor
group by first_name
having count(*)>2
order by 2 desc
limit 5
;

select first_name, last_name, count(*)
from actor
group by first_name, last_name
having count(*)>1
order by 2 desc
limit 5
;

-- Pelis de miedo
select count(*) from (
select f.title, f.description, f.rental_rate from film f 
join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id
where c.name='Horror') t1
;

-- Datos de duración por género y rating

select f.rating, c.name, max(f.length) as maxduracion from film f 
join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id
group by f.rating, c.name
order by f.rating, c.name
;

-- Actores con más pelis + comedias
select first_name, last_name, count(f.film_id) from film f
join film_actor fa on f.film_id=fa.film_id
join actor a on fa.actor_id=a.actor_id
join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id
group by first_name, last_name
order by 3 desc
;

select first_name, last_name, count(f.film_id) from film f
join film_actor fa on f.film_id=fa.film_id
join actor a on fa.actor_id=a.actor_id
join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id
where c.name='Comedy'
group by first_name, last_name
order by 3 desc
;

-- Ránking por pelis y dinero gastado en alquileres
select c.first_name, c.last_name, count(*) as alquileres, sum(amount) as dineros from rental r
join customer c on r.customer_id=c.customer_id
join payment p on r.rental_id=p.rental_id
group by c.first_name, c.last_name
order by 3 desc
;

-- Ratio por país de género de las películas
select country, count(*) as alquileres from rental r
join customer c on r.customer_id=c.customer_id
join address a on c.address_id=a.address_id
join city ci on a.city_id=ci.city_id
join country co on ci.country_id=co.country_id
group by country;

select co.country, ca.name, count(*) as alquileres, t.alq,
100*count(*)/t.alq as marketshare
from rental r
join customer c on r.customer_id=c.customer_id
join address a on c.address_id=a.address_id
join city ci on a.city_id=ci.city_id
join country co on ci.country_id=co.country_id
join inventory i on r.inventory_id=i.inventory_id
join film f on i.film_id=f.film_id
join film_category fc on f.film_id=fc.film_id
join category ca on fc.category_id=ca.category_id
join (select country, count(*) as alq from rental r
join customer c on r.customer_id=c.customer_id
join address a on c.address_id=a.address_id
join city ci on a.city_id=ci.city_id
join country co on ci.country_id=co.country_id
group by country) t on t.country=co.country
group by country, ca.name