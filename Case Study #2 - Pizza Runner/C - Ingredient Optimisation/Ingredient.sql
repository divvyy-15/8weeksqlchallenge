--Normalizing the pizza_recipes table into a new table:
alter table pizza_recipes
alter column toppings varchar(30)

alter table pizza_toppings
alter column topping_name varchar(30)

create table pizza_recipes1(pizza_id int,toppings varchar(40))

INSERT INTO pizza_recipes1 (pizza_id, toppings)
SELECT pizza_id, value AS topping
FROM pizza_recipes
CROSS APPLY STRING_SPLIT(toppings, ',');

--1. What are the standard ingredients for each pizza?
select pz.pizza_name,STRING_AGG(pt.topping_name,',') as standardToppings from pizza_recipes1 pr
inner join pizza_toppings pt
on pt.topping_id = pr.toppings
inner join pizza_names pz
on pz.pizza_id = pr.pizza_id
group by pz.pizza_name


