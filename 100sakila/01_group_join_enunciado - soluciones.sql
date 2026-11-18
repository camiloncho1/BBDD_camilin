use sakila;





-- ==============================================
-- SECCIÓN A) 30 CONSULTAS CON JOIN DE 2 TABLAS
-- ==============================================


-- 1:  Para cada actor, muestra el número total de películas en las que aparece; es decir, cuenta cuántas filas de film_actor corresponden a cada actor.


select first_name as nombre, last_name as apellido, count(film_id) as num_peliculas
from actor
join film_actor using(actor_id)
group by actor_id
order by num_peliculas desc;



-- 2:  Lista solo los actores que participan en 20 o más películas (umbral alto) con su conteo.


select first_name as nombre, last_name as apellido, count(film_id) as num_peliculas
from actor
join film_actor using(actor_id)
group by actor_id
having count(film_id) >= 20
order by count(film_id) desc;



-- 3:  Para cada idioma, indica cuántas películas están catalogadas en ese idioma.

select *
from language
join film using(language_id);



select name, count(film_id) as peliculas
from language
join film using(language_id)
group by name
order by count(film_id) desc;



-- 4:  Muestra el promedio de duración (length) de las películas por idioma y filtra aquellos idiomas con duración media estrictamente mayor a 110 minutos.

select *
from film join language using(language_id);



select name as idioma, avg(length) as promedio_duracion
from film join language using(language_id)
group by idioma
having promedio_duracion > 110;


-- 5:  Para cada película, muestra cuántas copias hay en el inventario.


select *
from film
join inventory
	using(film_id);
    
select film_id as pelicula, count(inventory_id) as copias
from film
join inventory
	using(film_id)
group by pelicula;



-- 6:  Lista solo las películas que tienen al menos 5 copias en inventario.


select film_id as pelicula, count(inventory_id) as copias
from film
	join inventory
		using(film_id)
group by pelicula
having copias >= 5;



-- 7:  Para cada artículo de inventario, cuenta cuántos alquileres se han realizado.


select *
from inventory
	join rental
		using(inventory_id);
        
        
select inventory_id, count(rental_id)
from inventory
	join rental
		using(inventory_id)
group by inventory_id;



-- 8:  Para cada cliente, muestra cuántos alquileres ha realizado en total.

select *
from customer
	join rental
		using(customer_id);

select customer_id as cliente, count(rental_id) as alquileres
from customer
	join rental
		using(customer_id)
group by customer_id;



-- 9:  Lista los clientes con 30 o más alquileres acumulados.


select customer_id as cliente, count(rental_id) as alquileres
from customer
	join rental
		using(customer_id)
group by customer_id
having alquileres >= 30;



-- 10:  Para cada cliente, muestra el total de pagos (suma en euros/dólares) que ha realizado.


select * 
from customer
	join payment
		using(customer_id);
        
select customer_id as cliente, sum(amount) as total_pagado
from customer
	join payment
		using(customer_id)
group by cliente;



-- 11:  Muestra los clientes cuyo importe total pagado es al menos 200.


select customer_id as cliente, sum(amount) as total_pagado
from customer
	join payment
		using(customer_id)
group by cliente
having total_pagado >= 200;



-- 12:  Para cada empleado (staff), muestra el número de pagos que ha procesado.


select *
from staff
	join payment
		using(staff_id);
        
select concat(first_name, " ", last_name) as empleado, count(payment_id) as pagos_procesados
from staff
	join payment
		using(staff_id)
group by empleado;



-- 13:  Para cada empleado, muestra el importe total procesado.


select *
from staff
	join payment
		using(staff_id);
        
select concat(first_name, " ", last_name) as empleado, sum(amount) as importe_total
from staff
	join payment
		using(staff_id)
group by empleado;



-- 14:  Para cada tienda, cuenta cuántos artículos de inventario tiene.

select *
from store
	join inventory
		using(store_id);

select store_id as tienda, count(inventory_id) as articulos_inventario
from store
	join inventory
		using(store_id)
group by tienda;



-- 15:  Para cada tienda, cuenta cuántos clientes tiene asignados.


select *
from store
		join customer
			using(store_id);

select store_id as tienda, count(customer_id) as clientes_asignado
from store
		join customer
			using(store_id)
group by store_id;		



-- 16:  Para cada tienda, cuenta cuántos empleados (staff) tiene asignados.


select *
from store
		join staff
			using(store_id);

select store_id as tienda, count(staff_id) as num_empleados
from store
		join staff
			using(store_id)
group by tienda;

-- 17:  Para cada dirección (address), cuenta cuántas tiendas hay ubicadas ahí (debería ser 0/1 en datos estándar).

select*
from address
	join store
		using(address_id);


select address_id as Direccion, count(store_id) as Tienda
from address
	join store
		using(address_id)
group by address_id;


-- 18:  Para cada dirección, cuenta cuántos empleados residen en esa dirección.

select *
from address
	join staff
		using(address_id);
        

select address_id as direccion, count(staff_id) as num_empleados
from address
	join staff
		using(address_id)
group by direccion;
        
-- 19:  Para cada dirección, cuenta cuántos clientes residen ahí.

select *
from address
	join customer
		using(address_id);
 
select address_id as direccion, count(customer_id) as clientes
from address
	join customer
		using(address_id)
group by direccion;

-- 20:  Para cada ciudad, cuenta cuántas direcciones hay registradas.

select *
from city
	join address
		using(city_id);

select city_id as ciudad, count(address_id) as direcciones_registradas
from city
	join address
		using(city_id)
group by ciudad;

-- 21:  Para cada país, cuenta cuántas ciudades existen.

select *
from country
	join city
		using(country_id);

select country_id as pais, count(city_id) as num_ciudades
from country
	join city
		using(country_id)
group by pais;
        
-- 22:  Para cada idioma, calcula la duración media de películas y muestra solo los idiomas con media entre 90 y 120 inclusive.

select *
from language
	join film
		using(language_id);

select language_id as idioma, avg(length) as media_duracion
from language
	join film
		using(language_id)
group by idioma
having avg(length) >=90 and avg(length) <=120;


-- 23:  Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).

select *
from film
	join inventory
		using(film_id)
	join rental
		using(inventory_id);
        
select film_id as pelicula, count(rental_id)
from film
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
group by pelicula;

-- 24:  Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).

select*
from customer
	join payment
		using(customer_id);
        
select customer_id as cliente, count(payment_date) as pagosRealizados
from customer
	join payment
		using(customer_id)
where year(payment_date) = 2005
group by customer_id;

-- 25:  Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).

select *
from film
	join inventory
		using(film_id)
	join rental
		using(inventory_id);

select film_id as pelicula, avg(rental_rate) as promedioTarifaAlquiler
from film
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
group by pelicula;

-- 26:  Para cada actor, muestra la duración media (length) de sus películs.

select *
from actor
	join film_actor
		using(actor_id)
	join film
		using(film_id);
	
/* select actor_id as actor, avg(length) as promedioDuracionPeliculas
from actor
	join film_actor
		using(actor_id)
	join film
		using(film_id)
 group by actor; 
*/
select concat(first_name, " ", last_name) as actor, avg(length) as promedioDuracionPeliculas
from actor
	join film_actor
		using(actor_id)
	join film
		using(film_id)
group by actor;
        
-- 27:  Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).

select *
from city
	join address
		using(city_id)
	join customer
		using(address_id);

select city as ciudad, count(customer_id) as numClientes
from city
	join address
		using(city_id)
	join customer
		using(address_id)
group by ciudad;


-- 28:  Para cada película, cuenta cuántos actores tiene asociados.

select *
from film
	join film_actor
		using(film_id)
	join actor
		using(actor_id);
        
select film_id as id_pelicula, title as pelicula, count(actor_id)
from film
	join film_actor
		using(film_id)
	join actor
		using(actor_id)
group by film_id;

/* 
select film_id as id_pelicula, title as pelicula, count(actor_id) as numActores
from film
	join film_actor
		using(film_id)
	join actor
		using(actor_id)
group by film_id
order by count(actor_id) desc;
*/

-- 29:  Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).

select *
from category
	join film_category
		using(category_id);

select category_id as id_categoria, count(film_id)
from category
	join film_category
		using(category_id)
group by category_id;


-- 30:  Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.

select *
from store
	join inventory
		using (store_id)
	join rental
		using(inventory_id);
        
select store_id as tienda, count(rental_id) as numAlquileres
from store
	join inventory
		using (store_id)
	join rental
		using(inventory_id)
group by tienda;
-- ==============================================
-- SECCIÓN B) 30 CONSULTAS CON JOIN DE 3 TABLAS
-- ==============================================
-- 31:  Para cada actor, cuenta cuántas películas tiene y muestra solo los que superan 15 películas.
    
select * 
from actor
	join film_actor
		using(actor_id)
	join film
		using(film_id);

select actor_id as id_actor, concat(first_name, " ", last_name) as actor, count(film_id) as num_peliculas
from actor
	join film_actor
		using(actor_id)
	join film
		using(film_id)
group by id_actor
having count(film_id) > 15
order by num_peliculas asc;

-- 32:  Para cada categoría (por nombre), cuenta cuántas películas hay en esa categoría.

select * 
from category
	join film_category
		using(category_id)
	join film
		using(film_id);

select name as categoria, count(category_id) as numero_peliculas
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
group by name;

-- 33:  Para cada película, cuenta cuántos alquileres se han hecho de sus copias.

select * 
from film
	join inventory
		using(film_id)
	join rental
		using(inventory_id);

select film_id as pelicula, count(rental_id) as num_alquileres
from film
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
group by pelicula;


/*select film_id as pelicula, count(rental_id) as num_alquileres
from film
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
group by pelicula
order by num_alquileres desc;
*/

-- 34:  Para cada cliente, suma el importe pagado en 2005 y filtra clientes con total >= 150.

select * 
from customer
	join payment
		using(customer_id);

select customer_id as cliente, sum(amount) as monto
from customer
	join payment
		using(customer_id)
where year(payment_date) = 2005
group by cliente
having monto >= 150;

-- 35:  Para cada tienda, suma el importe cobrado por todos sus empleados.

select * 
from store
	join staff
		using(store_id)
	join payment
		using(staff_id);

select store_id as tienda, sum(amount) as importe_total_cobrado
from store
	join staff
		using(store_id)
	join payment
		using(staff_id)
group by tienda;        

-- 36:  Para cada ciudad, cuenta cuántos empleados residen ahí (staff -> address -> city).

select * 
from city
	join address
		using(city_id)
	join staff
		using(address_id);

select city as ciudad, count(staff_id)
from city
	join address
		using(city_id)
	join staff
		using(address_id)
group by ciudad;

-- 37:  Para cada ciudad, cuenta cuántas tiendas existen (store -> address -> city).

select * 
from city
	join address
		using(city_id)
	join store
		using(address_id);
        
select city as ciudad, count(store_id)
from city
	join address
		using(city_id)
	join store
		using(address_id)
group by store_id;

-- 38:  Para cada actor, calcula la duración media de sus películas del año 2006.

select * 
from actor
	join film_actor
		using(actor_id)
	join film
		using(film_id);
        
select concat(first_name, " ", last_name) as actor_actriz, avg(length) as prom_duracionPeliculas
from actor
	join film_actor
		using(actor_id)
	join film
		using(film_id)
where release_year = 2006
group by actor_actriz;

-- 39:  Para cada categoría, calcula la duración media y muestra solo las que superan 120.

select *
from category
	join film_category
		using(category_id)
	join film
		using(film_id);

select name as categoria, avg(length) as prom_duracionPelicula
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
group by categoria
having avg(length) > 120;

-- 40:  Para cada idioma, suma las tarifas de alquiler (rental_rate) de todas sus películas.

select *
from language
	join film
		using(language_id);

select language_id as idioma, sum(rental_rate)
from language
	join film
		using(language_id)
group by idioma;


        
-- 41:  Para cada cliente, cuenta cuántos alquileres realizó en fines de semana (SÁB-DO) usando DAYOFWEEK (1=Domingo).
select *
from customer
    join rental
        using(customer_id);

select customer_id as cliente, count(rental_id) as alqu_fin_semana
from customer
    join rental
        using(customer_id)
where dayofweek(rental_date) in (1, 7)
group by cliente;

-- 42:  Para cada actor, muestra el total de títulos distintos en los que participa (equivale a COUNT DISTINCT, sin subconsulta).

select * 
from actor
    join film_actor
        using(actor_id);

select concat(first_name, ' ', last_name) as actor, count(distinct film_id) as peliculas_distintas
from actor
    join film_actor
        using(actor_id)
group by actor;

-- 43:  Para cada ciudad, cuenta cuántos clientes residen ahí (customer -> address -> city).

select *
from city
    join address
        using(city_id)
    join customer
        using(address_id);

select city as ciudad, count(customer_id) as total_clientes
from city
    join address
        using(city_id)
    join customer
        using(address_id)
group by ciudad;

-- 44:  Para cada categoría, muestra cuántos actores distintos participan en películas de esa categoría.

select *
from category
    join film_category
        using(category_id)
    join film_actor
        using(film_id);
        

select name as categoria, count(distinct actor_id) as actores_distintos
from category
    join film_category
        using(category_id)
    join film_actor
        using(film_id)
group by categoria;

-- 45:  Para cada tienda, cuenta cuántas copias totales (inventario) tiene de películas en 2006.

select *
from store
    join inventory
        using(store_id)
    join film
        using(film_id);

select store_id as tienda, count(inventory_id) as copiasTotales_2006
from store
    join inventory
        using(store_id)
    join film
        using(film_id)
where release_year = 2006
group by tienda;


-- 46:  Para cada cliente, suma el total pagado por alquileres cuyo empleado pertenece a la tienda 1.

select *
from customer
    join payment
        using(customer_id)
    join staff
        using(staff_id);

select customer_id as cliente, sum(amount) as total_tienda1
from customer
    join payment
        using(customer_id)
    join staff
        using(staff_id)
where store_id = 1
group by cliente;

-- 47:  Para cada película, cuenta cuántos actores tienen el apellido de longitud >= 5.

select *
from film
    join film_actor
        using(film_id)
    join actor
        using(actor_id);

select title as pelicula, count(actor_id) as actores_apellidos_largos
from film
    join film_actor
        using(film_id)
    join actor
        using(actor_id)
where length(last_name) >= 5
group by pelicula;

-- 48:  Para cada categoría, suma la duración total (length) de sus películas.

select *
from category
    join film_category
        using(category_id)
    join film
        using(film_id);

select name as categoria, sum(length) as duracion_total
from category
    join film_category
        using(category_id)
    join film
        using(film_id)
group by categoria;

-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.

select *
from city
    join address
        using(city_id)
    join customer
        using(address_id)
    join payment
        using(customer_id);

select city as ciudad, sum(amount) as importes_pagados
from city
    join address
        using(city_id)
    join customer
        using(address_id)
    join payment
        using(customer_id)
group by ciudad;

-- 50:  Para cada idioma, cuenta cuántos actores distintos participan en películas de ese idioma.

select *
from language
    join film
        using(language_id)
    join film_actor
        using(film_id);

select name as idioma, count(distinct actor_id) as actores_distintos
from language
    join film
        using(language_id)
    join film_actor
        using(film_id)
group by idioma;


-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.

select *
from store
    join customer
        using(store_id);

select store_id as tienda, count(customer_id) as clientes_activos
from store
    join customer
        using(store_id)
where active = 1
group by tienda;

-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).

select *
from customer
    join rental
        using(customer_id)
    join inventory
        using(inventory_id)
    join film_category
        using(film_id);

select customer_id as cliente, count(distinct category_id) as categorias_distintas
from customer
    join rental
        using(customer_id)
    join inventory
        using(inventory_id)
    join film_category
        using(film_id)
group by cliente;

-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.

select *
from staff
    join payment
        using(staff_id);

select staff_id as empleado, count(distinct customer_id) as clientes_distintos
from staff
    join payment
        using(staff_id)
group by empleado;

-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.

select *
from city
    join address
        using(city_id)
    join customer
        using(address_id)
    join rental
        using(customer_id)
    join inventory
        using(inventory_id)
    join film
        using(film_id);

select city as ciudad, count(film_id) as alquileres_2006
from city
    join address
        using(city_id)
    join customer
        using(address_id)
    join rental
        using(customer_id)
    join inventory
        using(inventory_id)
    join film
        using(film_id)
where release_year = 2006
group by ciudad;

-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas.

select *
from category
    join film_category
        using(category_id)
    join film
        using(film_id);

select name as categoria, avg(replacement_cost) as promedio_obtenido_cost
from category
    join film_category
        using(category_id)
    join film
        using(film_id)
group by categoria;


-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).

select *
from store
    join staff
        using(store_id)
    join payment
        using(staff_id);

select store_id as tienda, sum(amount) as total_2006
from store
    join staff
        using(store_id)
    join payment
        using(staff_id)
where year(payment_date) = 2006
group by tienda;

-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.

select *
from actor
    join film_actor
        using(actor_id)
    join film
        using(film_id);

select concat(first_name, ' ', last_name) as actor, count(film_id) as peliculas_titulos_largos
from actor
    join film_actor
        using(actor_id)
    join film
        using(film_id)
where char_length(title) > 12
group by actor;

-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.

select *
from city
    join address
        using(city_id)
    join customer
        using(address_id)
    join payment
        using(customer_id);


select city as ciudad, sum(amount) as total_2005
from city
    join address
        using(city_id)
    join customer
        using(address_id)
    join payment
        using(customer_id)
where year(payment_date) = 2005
group by ciudad
having total_2005 >= 300;

-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.

select *
from category
    join film_category
        using(category_id)
    join film
        using(film_id);

select name as categoria, count(film_id) as total_peliculas
from category
    join film_category
        using(category_id)
    join film
        using(film_id)
where rating in ('PG', 'PG-13')
group by categoria;

-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.

select *
from customer
    join payment
        using(customer_id);

select customer_id as cliente, sum(amount) as total_empleado2
from customer
    join payment
        using(customer_id)
where staff_id = 2
group by cliente;

-- ==============================================
-- SECCIÓN C) 20 CONSULTAS CON JOIN DE 4 TABLAS
-- ==============================================
-- 61:  Para cada ciudad, cuenta cuántos clientes hay y muestra solo ciudades con 10 o más clientes.

select *
from city
    join address
        using(city_id)
    join customer
        using(address_id);

select city as ciudad, count(customer_id) as total_clientes
from city
    join address
        using(city_id)
    join customer
        using(address_id)
group by ciudad
having total_clientes >= 10;


-- 62:  Para cada actor, cuenta cuántos alquileres totales suman todas sus películas.

select *
from actor
    join film_actor
        using(actor_id)
    join inventory
        using(film_id)
    join rental
        using(inventory_id);

select concat(first_name, ' ', last_name) as actor, count(rental_id) as total_alquileres
from actor
    join film_actor
        using(actor_id)
    join inventory
        using(film_id)
    join rental
        using(inventory_id)
group by actor;

-- 63:  Para cada categoría, suma los importes pagados derivados de películas de esa categoría.

select *
from category
    join film_category
        using(category_id)
    join inventory
        using(film_id)
    join rental
        using(inventory_id)
    join payment
        using(rental_id);

select name as categoria, sum(amount) as total_importes
from category
    join film_category
        using(category_id)
    join inventory
        using(film_id)
    join rental
        using(inventory_id)
    join payment
        using(rental_id)
group by categoria;

-- 64:  Para cada ciudad, suma los importes pagados por clientes residentes en esa ciudad en 2005.

select *
from city
    join address
        using(city_id)
    join customer
        using(address_id)
    join payment
        using(customer_id);

select city as ciudad, sum(amount) as total_2005
from city
    join address
        using(city_id)
    join customer
        using(address_id)
    join payment
        using(customer_id)
where year(payment_date) = 2005
group by ciudad;

-- 65:  Para cada tienda, cuenta cuántos actores distintos aparecen en las películas de su inventario.

select *
from store
    join inventory
        using(store_id)
    join film_actor
        using(film_id);


select store_id as tienda, count(distinct actor_id) as actores_distintos
from store
    join inventory
        using(store_id)
    join film_actor
        using(film_id)
group by tienda;

-- 66:  Para cada idioma, cuenta cuántos alquileres totales se han hecho de películas en ese idioma.

select *
from language
    join film
        using(language_id)
    join inventory
        using(film_id)
    join rental
        using(inventory_id);

select name as idioma, count(rental_id) as alquileres_totales
from language
    join film
        using(language_id)
    join inventory
        using(film_id)
    join rental
        using(inventory_id)
group by idioma;

-- 67:  Para cada cliente, cuenta en cuántos meses distintos de 2005 realizó pagos (meses distintos).

select *
from customer
    join payment
        using(customer_id);

select customer_id as cliente, count(distinct month(payment_date)) as meses_distintos
from customer
    join payment
        using(customer_id)
where year(payment_date) = 2005
group by cliente;

-- 68:  Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).

select *
from category
    join film_category
        using(category_id)
    join film
        using(film_id)
    join inventory
        using(film_id)
    join rental
        using(inventory_id);

select name as categoria, avg(length) as promedio_duracion
from category
    join film_category
        using(category_id)
    join film
        using(film_id)
    join inventory
        using(film_id)
    join rental
        using(inventory_id)
group by categoria;

-- 69:  Para cada país, cuenta cuántos clientes hay (country -> city -> address -> customer).

select *
from country
    join city
        using(country_id)
    join address
        using(city_id)
    join customer
        using(address_id);

select country as pais, count(customer_id) as total_clientes
from country
    join city
        using(country_id)
    join address
        using(city_id)
    join customer
        using(address_id)
group by pais;

-- 70:  Para cada país, suma los importes pagados por sus clientes.

select *
from country
    join city
        using(country_id)
    join address
        using(city_id)
    join customer
        using(address_id)
    join payment
        using(customer_id);

select country as pais, sum(amount) as total_importes
from country
    join city
        using(country_id)
    join address
        using(city_id)
    join customer
        using(address_id)
    join payment
        using(customer_id)
group by pais;

-- 71:  Para cada tienda, cuenta cuántas categorías distintas existen en su inventario.

select *
from store
    join inventory
        using(store_id)
    join film
        using(film_id)
    join film_category
        using(film_id);

select store_id as tienda, count(distinct category_id) as categorias_distintas
from store
    join inventory
        using(store_id)
    join film
        using(film_id)
    join film_category
        using(film_id)
group by tienda;

-- 72:  Para cada tienda, suma la recaudación por categoría (resultado agregado por tienda y categoría).

select *
from store
    join inventory
        using(store_id)
    join film
        using(film_id)
    join film_category
        using(film_id)
    join category
        using(category_id)
    join rental
        using(inventory_id)
    join payment
        using(rental_id);

select store_id as tienda, name as categoria, sum(amount) as total_recaudado
from store
    join inventory
        using(store_id)
    join film
        using(film_id)
    join film_category
        using(film_id)
    join category
        using(category_id)
    join rental
        using(inventory_id)
    join payment
        using(rental_id)
group by tienda, categoria;

-- 73:  Para cada actor, cuenta en cuántas tiendas distintas se han alquilado sus películas.

select *
from actor
	join film_actor
		using(actor_id)
	join film
		using(film_id)
    join inventory
		using(film_id)
    join store
		using(store_id);

select actor_id, concat(first_name," ",last_name) as nombre, count(distinct(store_id)) as tiendas_distintas
from actor
	join film_actor
		using(actor_id)
	join film
		using(film_id)
    join inventory
		using(film_id)
    join store
		using(store_id)
group by actor_id;
        
-- 74:  Para cada categoría, cuenta cuántos clientes distintos han alquilado películas de esa categoría.

select *
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
	join customer
		using(customer_id);
	
select category_id, name as categoria, count(distinct(customer_id)) as num_clientes_distintos
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
	join customer
		using(customer_id)
group by category_id;

-- 75:  Para cada idioma, cuenta cuántos actores distintos participan en películas alquiladas en ese idioma.

select *
from language
	join film
		using(language_id)
	join film_actor
		using(film_id)
	join actor
		using(actor_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id);

select language_id, name as idioma, count(distinct(actor_id)) as actores_distintos_por_idioma
from language
	join film
		using(language_id)
	join film_actor
		using(film_id)
	join actor
		using(actor_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
group by language_id;

-- 76:  Para cada país, cuenta cuántas tiendas hay (país->ciudad->address->store).

select *
from country
	join city
		using(country_id)
	join address
		using(city_id)
	join store
		using(address_id);
        
select country_id, country as pais, count(store_id) as num_tiendas
from country
	join city
		using(country_id)
	join address
		using(city_id)
	join store
		using(address_id)
group by country_id;

-- 77:  Para cada cliente, cuenta los alquileres en los que la devolución (return_date) fue el mismo día del alquiler.

select *
from customer
	join rental
		using(customer_id);
        
select customer_id, concat(first_name, " ", last_name) as cliente, count(rental_id) as numero_alquileres
from customer
	join rental
		using(customer_id)
where date(return_date) = date(rental_date)
group by customer_id;
        
-- 78:  Para cada tienda, cuenta cuántos clientes distintos realizaron pagos en 2005.

select * 
from store
	join customer
		using(store_id)
	join payment
		using(customer_id);
        
select store_id as tienda, count(distinct(customer_id)) as clientes_distintos
from store
	join customer
		using(store_id)
	join payment
		using(customer_id)
where year(payment_date) = 2005
group by store_id;

-- 79:  Para cada categoría, cuenta cuántas películas con título de longitud > 15 han sido alquiladas.

select *
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id);
        
select category_id, name as categoria, count(film_id) as num_de_peliculas
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
where length(title) > 15
group by category_id;

-- 80:  Para cada país, suma los pagos procesados por los empleados de las tiendas ubicadas en ese país.
select * 
from country
	join city
		using(country_id)
	join address
		using(city_id)
	join store
		using(address_id)
	join staff
		using(store_id)
	join payment
		using(staff_id)
group by country_id;

select country_id, country as pais, sum(amount)
from country
	join city
		using(country_id)
	join address
		using(city_id)
	join store
		using(address_id)
	join staff
		using(store_id)
	join payment
		using(staff_id)
group by country_id;

-- ==============================================
-- SECCIÓN D) 20 CONSULTAS EXTRA (DIFICULTAD +), <=4 JOINS
-- ==============================================
-- 81:  Para cada cliente, muestra el total pagado con IVA teórico del 21% aplicado (total*1.21), redondeado a 2 decimales.

select *
from customer
	join payment
		using(customer_id);
        
select customer_id, concat(first_name, " ", last_name) as cliente, round(sum(amount * 1.21), 2)
from customer
	join payment
		using(customer_id)
group by customer_id;
        
-- 82:  Para cada hora del día (0-23), cuenta cuántos alquileres se iniciaron en esa hora.

select *
from rental;

select hour(rental_date) as hora, count(rental_id) as alquileres
from rental
group by hour(rental_date)
order by hour(rental_date) asc;

-- 83:  Para cada tienda, muestra la media de length de las películas alquiladas en 2005 y filtra las tiendas con media >= 100.

select *
from store
	join inventory
		using(store_id)
	join film 
		using(film_id)
	join rental
		using(inventory_id);

select store_id as tienda, avg(length) as media_peliculas
from store
	join inventory
		using(store_id)
	join film 
		using(film_id)
	join rental
		using(inventory_id)
where year(rental_date) = 2005
group by store_id
having avg(length) >= 100;

-- 84:  Para cada categoría, muestra la media de replacement_cost de las películas alquiladas un domingo.

select *
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id);
        
select category_id, name as categoria, avg(replacement_cost) as media_replacementCost_domingo
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
where dayofweek(rental_date) = "1"
group by category_id;
        

-- 85:  Para cada empleado, muestra el importe total por pagos realizados entre las 00:00 y 06:00 (inclusive 00:00, exclusivo 06:00).

select *
from staff
	join payment
		using(staff_id);
        
select staff_id, concat(first_name, " ", last_name) as empleado, sum(amount) as importe_total
from staff
	join payment
		using(staff_id)
where hour(payment_date) >= 0 and hour(payment_date) < 6 
group by staff_id;

-- 86:  Para cada actor, cuenta cuántas de sus películas tienen un título que contiene la palabra 'LOVE' (mayúsculas).

select *
from actor
	join film_actor
		using(actor_id)
	join film
		using(film_id);

select actor_id, concat(first_name, " ", last_name) as actor, count(film_id) as numero_de_peliculas
from actor
	join film_actor
		using(actor_id)
	join film
		using(film_id)
where title like "%LOVE%"
group by actor_id;
        
-- 87:  Para cada idioma, muestra el total de pagos de alquileres de películas en ese idioma.

select *
from language
	join film
		using(language_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
	join payment
		using(rental_id);
        
select language_id, name as idioma, sum(amount) as total_pagos_alquileres
from language
	join film
		using(language_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
	join payment
		using(rental_id)
group by language_id;
        
-- 88:  Para cada cliente, cuenta en cuántos días distintos de 2005 realizó algún alquiler.

select *
from customer
	join rental
		using(customer_id);

select customer_id, concat(first_name, " ", last_name) as cliente, count(distinct date(rental_date)) as num_dias_distintos
from customer
	join rental
		using(customer_id)
where year(rental_date) = 2005
group by customer_id;

-- 89:  Para cada categoría, calcula la longitud media de títulos (número de caracteres) de sus películas alquiladas.

select *
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id);

select category_id, name as categoria, round(avg(length(title)), 1) as meida_longitud_titulos
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
group by category_id;
-- 90:  Para cada tienda, cuenta cuántos clientes distintos alquilaron en el primer trimestre de 2006 (enero-marzo).

select *
from store
	join customer
		using(store_id)
	join rental
		using(customer_id);
        
select store_id as tienda, count(distinct(customer_id)) as num_clientes_distintos
from store
	join customer
		using(store_id)
	join rental
		using(customer_id)
where year(rental_date) = 2006 and month(rental_date) between 1 and 3
group by store_id;

-- 91:  Para cada país, cuenta cuántas categorías diferentes han sido alquiladas por clientes residentes en ese país.

select country_id, country as pais, count(distinct(category_id)) as categorias_distintas
from country
	join city
		using(country_id)
	join address
		using(city_id)
	join customer
		using(address_id)
	join rental
		using(customer_id)
	join inventory
		using(inventory_id)
	join film
		using(film_id)
	join film_category
		using(film_id)
	join category
		using(category_id)
	group by country_id;


-- 92:  Para cada cliente, muestra el importe medio de sus pagos redondeado a 2 decimales, solo si ha hecho al menos 10 pagos.

select *
from customer
	join payment
		using(customer_id);

select customer_id, concat(first_name, " ", last_name) as cliente, round(avg(amount), 2) as media_pagos
from customer
	join payment
		using(customer_id)
group by customer_id
having count(payment_id) >= 10;

-- 93:  Para cada categoría, muestra el número de películas con replacement_cost > 20 que hayan sido alquiladas al menos una vez.

select *
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id);

select category_id, name as categoria, count(distinct film_id) as num_peliculas
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
where replacement_cost > 20
group by category_id;

-- 94:  Para cada tienda, suma los importes pagados en fines de semana.

select *
from store
	join inventory
		using(store_id)
	join rental
		using(inventory_id)
	join payment
		using(rental_id);

select store_id as tienda, sum(amount) as total_importes_fin_semana
from store
	join inventory
		using(store_id)
	join rental
		using(inventory_id)
	join payment
		using(rental_id)
where dayofweek(payment_date) in (1, 7)
group by store_id;

-- 95:  Para cada actor, cuenta cuántas películas suyas fueron alquiladas por al menos 5 clientes distintos (se cuenta alquileres y luego se filtra por HAVING).

select *
from actor
	join film_actor
		using(actor_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id);

select actor_id, concat(first_name, " ", last_name) as actor, count(film_id) as peliculas_propias_alquiladas
from actor
	join film_actor
		using(actor_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
group by actor_id, film_id
having count(distinct customer_id) >= 5;

-- 96:  Para cada idioma, muestra el número de películas cuyo título empieza por la letra 'A' y que han sido alquiladas.

select *
from language
	join film
		using(language_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id);

select language_id, name as idioma, count(distinct film_id) as peliculas_titulo_a
from language
	join film
		using(language_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
where title like 'A%'
group by language_id;

-- 97:  Para cada país, suma el importe total de pagos realizados por clientes residentes y filtra países con total >= 1000.

select *
from country
	join city
		using(country_id)
	join address
		using(city_id)
	join customer
		using(address_id)
	join payment
		using(customer_id);

select country_id, country as pais, sum(amount) as total_pagos
from country
	join city
		using(country_id)
	join address
		using(city_id)
	join customer
		using(address_id)
	join payment
		using(customer_id)
group by country_id
having sum(amount) >= 1000;

-- 98:  Para cada cliente, cuenta cuántos días han pasado entre su primer y su último alquiler en 2005 (diferencia de fechas), mostrando solo clientes con >= 5 alquileres en 2005.
--     (Se evita subconsulta calculando sobre el conjunto agrupado por cliente y usando MIN/MAX de rental_date en 2005).

select *
from customer
	join rental
		using(customer_id);

-- 99:  Para cada tienda, muestra la media de importes cobrados por transacción en el año 2006, con dos decimales.

select *
from store
	join inventory
		using(store_id)
	join rental
		using(inventory_id)
	join payment
		using(rental_id);

select store_id as tienda, round(avg(amount), 2) as media_importes_por_transaccion
from store
	join inventory
		using(store_id)
	join rental
		using(inventory_id)
	join payment
		using(rental_id)
where year(payment_date) = 2006
group by store_id;

-- 100:  Para cada categoría, calcula la media de duración (length) de películas alquiladas en 2006 y ordénalas descendentemente por dicha media.

select *
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id);

select category_id, name as categoria, round(avg(length), 2) as media_duracion
from category
	join film_category
		using(category_id)
	join film
		using(film_id)
	join inventory
		using(film_id)
	join rental
		using(inventory_id)
where year(rental_date) = 2006
group by category_id
order by media_duracion desc;

