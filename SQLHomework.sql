#1a
select first_name, last_name
from actor;

#1b
select concat(upper(first_name), " ", upper(last_name)) as "Actor Name"
from actor;

#2a
select actor_id, first_name, last_name
from actor
where first_name = "Joe";

#2b
select actor_id, first_name, last_name
from actor
where last_name like "%GEN%";

#2c
select actor_id, first_name, last_name
from actor
where last_name like "%LI%"
order by last_name asc, first_name asc;

#2d
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

#3a
alter table actor
add column description blob default null;

#3b
alter table actor
drop column description;

#4a
select last_name, count(last_name) as "Number of Actors with Last Name"
from actor
group by last_name
order by count(last_name) desc;

#4b
select last_name, count(last_name) as "Number of Actors with Last Name"
from actor
group by last_name
having count(last_name) > 1
order by count(last_name) desc;

#4c
update actor 
set first_name = "HARPO"
where first_name = "GROUCHO" and last_name = "WILLIAMS";

#4d
update actor 
set first_name = "GROUCHO"
where first_name = "HARPO" and last_name = "WILLIAMS";

#5a
show create table address;

#6a
select first_name, last_name, address
from address as a, staff as s
where a.address_id = s.address_id;

#6b
select s.staff_id, first_name, last_name, sum(amount)
from staff as s inner join payment as p
where s.staff_id = p.staff_id
group by s.staff_id;

#6c
select title, count(actor_id) as "Number of Actors"
from film_actor as fa, film as f
where f.film_id = fa.film_id
group by f.film_id
order by count(actor_id) desc;

#6d
select title, count(inventory_id) as "Inventory Count"
from film as f, inventory as i
where f.film_id = i.film_id and title = "Hunchback Impossible";

#6e
select first_name, last_name, sum(amount) as "Total Paid ($)"
from customer as c, payment as p
where c.customer_id = p.customer_id
group by c.customer_id
order by last_name asc;

#7a
select title
from film as f, language as l
where f.language_id = l.language_id
and name = "English" and (title like "K%" or title like "Q%");

#7b
select first_name, last_name
from actor as a, film as f, film_actor as fa
where a.actor_id = fa.actor_id and f.film_id = fa.film_id
and title = "Alone Trip";

#7c
select first_name, last_name, email
from customer as cu, address as ad, city as ci, country as co
where cu.address_id = ad.address_id and ad.city_id = ci.city_id
and ci.country_id = co.country_id and country = "Canada";

#7d
select title, name
from film as f, film_category as fc, category as c
where f.film_id = fc.film_id and fc.category_id = c.category_id
and name = "Family";

#7e
select title, count(rental_id) as "Times Rented"
from film as f, inventory as i, rental as r
where f.film_id = i.film_id and i.inventory_id =r.inventory_id
group by title
order by count(rental_id) desc;

#7f
select s.store_id, sum(amount)
from store as s, inventory as i, payment as p, rental as r
where s.store_id = i.store_id and i.inventory_id = r.inventory_id
and p.rental_id = r.rental_id
group by s.store_id;

#7g
select store_id, city, country
from store as s, city as ci, country as co, address as a
where s.address_id = a.address_id and ci.city_id = a.city_id
and ci.country_id = co.country_id;

#7h
select c.name, sum(amount) as "Amount"
from film as f, category as c, film_category as fc, inventory as i, payment as p, rental as r
where c.category_id = fc.category_id and fc.film_id = f.film_id and i.film_id = f.film_id
and r.inventory_id = i.inventory_id and r.rental_id = p.rental_id
group by c.category_id
order by sum(amount) desc
limit 5;

#8a
create view top_five_genres
as select c.name, sum(amount) as "Amount"
from film as f, category as c, film_category as fc, inventory as i, payment as p, rental as r
where c.category_id = fc.category_id and fc.film_id = f.film_id and i.film_id = f.film_id
and r.inventory_id = i.inventory_id and r.rental_id = p.rental_id
group by c.category_id
order by sum(amount) desc
limit 5;

#8b
select * from top_five_genres;

#8c
drop view top_five_genres;

