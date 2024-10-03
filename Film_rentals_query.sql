use film_rental;
-- 1
select sum(pa.amount) as total_revenue from payment as pa,
rental as re
where pa.rental_id=re.rental_id;

-- 2
select date_format(rental_date,'%M') as month_name ,count(*) as rental_count 
from rental
group by month_name;

-- 3
select rental_rate from film
where length(title)=(select max(length(title)) from film)
limit 1;

-- 4
select rental.rental_date,avg(film.rental_rate) as average_rental_rate from rental join inventory
on rental.inventory_id=inventory.inventory_id join film on inventory.film_id=film.film_id
group by rental.rental_date 
order by rental.rental_date desc
limit 30;

-- 5
select max(category.name) from rental 
join inventory on rental.inventory_id=inventory.inventory_id
join film on inventory.film_id=film.film_id
join film_category on film.film_id=film_category.film_id 
join category on film_category.category_id=category.category_id;

-- 6
select film.title,(film.length) from rental join inventory
on rental.inventory_id=inventory.inventory_id join film on inventory.film_id=film.film_id
join customer on rental.customer_id=customer.customer_id
order by film.length desc;

-- 7
select avg(film.rental_rate) as average_rental_rate from film join category
on film.film_id=category.category_id;

-- 8 
select concat(actor.first_name, '', actor.last_name) as actor_name, sum(payment.amount) as total_revenue
from payment payment, actor actor, rental rental, inventory inventory, film film, film_actor film_actor
where payment.rental_id = rental.rental_id and rental.inventory_id = inventory.inventory_id
and inventory.film_id = film.film_id and film.film_id = film_actor.film_id and film_actor.actor_id = actor.actor_id
group by actor_name;

-- 9
select actor.first_name,actor.last_name from actor join film_actor
on actor.actor_id=film_actor.actor_id join film on film_actor.film_id=film.film_id
where film.description like '%wrestler%';

-- 10
select film.title as film, customer.first_name From rental JOIN inventory
on rental.inventory_id = inventory.inventory_id join film on inventory.film_id= film.film_id  
join customer on customer.customer_id = rental.customer_id


-- 11
select film.rental_rate,count(film.film_id) from category join film_category
on film_category.category_id=category.category_id join film on film_category.film_id=film.film_id
where category.name like'%comedy%' 
group by film.rental_rate 
having film.rental_rate>=avg(film.rental_rate);

-- 12
select city.city, film.title From rental JOIN inventory
on rental.inventory_id = inventory.inventory_id join film on inventory.film_Id= film.film_id  
join customer on customer.customer_id = rental.customer_id join address on customer.address_id = address.address_id join city on address.city_id = city.city_id

-- 13
select sum(payment.amount) as total_amount from payment payment
join customer customer on payment.customer_id = customer.customer_id
where payment.amount > 200 group by customer.customer_id;

-- 14
select * from information_schema.key_column_usage 
where constraint_schema='film rental' and referenced_table_name='rental';

-- 15
create view staff_total_revenue as 
select p.staff_id,sum(p.amount) as total_revenue ,c.city,co.country from payment as p
join staff as s
on p.staff_id=s.staff_id
join store as st
on s.staff_id=st.manager_staff_id
join address as ad
on st.address_id=ad.address_id
join city as c
on ad.city_id=c.city_id
join country as co
on c.country_id=co.country_id
group by p.staff_id;



