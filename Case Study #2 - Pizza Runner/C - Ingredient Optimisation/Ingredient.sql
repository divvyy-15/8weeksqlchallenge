--DATA CLEANING:--
--changing datatype of below columns from text to varchar:
alter table pizza_recipes
alter column toppings varchar(30)

alter table pizza_toppings
alter column topping_name varchar(30)

--Normalizing the pizza_recipes table into a new table:
create table pizza_recipes1(pizza_id int,toppings varchar(40))

INSERT INTO pizza_recipes1 (pizza_id, toppings)
SELECT pizza_id, value AS topping
FROM pizza_recipes
CROSS APPLY STRING_SPLIT(toppings, ',');  --when we want to apply a function or operation to each row of a result set, in such situation we use CROSS APPLY that helps to perform a row-by-row operation efficiently.

--Creating a new table to separate comma separated extras column into multiple rows from customer_orders1 table:
ALTER TABLE customer_orders1
ADD ord_id INT IDENTITY(1,1);  --Adding an identity column record_id to the table to select each ordered pizza more easily

SELECT c.ord_id,TRIM(e.value) AS extra_id INTO extras 
FROM customer_orders1 c
CROSS APPLY STRING_SPLIT(extras, ',') AS e;
SELECT * FROM extras;

--Creating a new table to separate comma separated extras column into multiple rows from customer_orders1 table:
SELECT c.ord_id,TRIM(e.value) AS exclusion_id
INTO exclusions 
FROM customer_orders1 c
CROSS APPLY STRING_SPLIT(exclusions, ',') AS e;

--1. What are the standard ingredients for each pizza?
select pz.pizza_name,STRING_AGG(pt.topping_name,',') as standardToppings from pizza_recipes1 pr
inner join pizza_toppings pt
on pt.topping_id = pr.toppings
inner join pizza_names pz
on pz.pizza_id = pr.pizza_id
group by pz.pizza_name

--2. What was the most commonly added extra?
select pt.topping_name,count(extra_id) as extras_count from customer_orders1 co
inner join extras e
on e.ord_id = co.ord_id
inner join pizza_toppings pt
on pt.topping_id = e.extra_id
group by pt.topping_name

-->The most commonly added extra was Bacon.

--3. What was the most common exclusion?
select pt.topping_name,count(trim(e.exclusion_id)) as exclusions_count from customer_orders1 co
inner join exclusions e
on e.ord_id = co.ord_id
inner join pizza_toppings pt
on pt.topping_id = e.exclusion_id
group by pt.topping_name
order by 2 desc

-->The most common exclusion was Cheese.






