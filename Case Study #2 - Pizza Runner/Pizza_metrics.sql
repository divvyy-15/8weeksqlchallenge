--1. How many pizzas were ordered?
select count(pizza_id) as pizza_order_count from customer_orders1

--2. How many unique customer orders were made?
select count(distinct order_id) as unique_order_count from customer_orders1

--3. How many successful orders were delivered by each runner?
select runner_id,count(distinct order_id) as successful_orders from runner_orders_1
where cancellation is null or cancellation in ('null',' ')
group by runner_id

--4. How many of each type of pizza was delivered?
select pn.pizza_name,count(co.pizza_id) as pizza_delivered from runner_orders_1 ro
inner join customer_orders1 co
on ro.order_id = co.order_id
inner join pizza_names pn
on pn.pizza_id = co.pizza_id
where ro.distance is not null
group by pn.pizza_name


--5. How many Vegetarian and Meatlovers were ordered by each customer?
select co.customer_id,pn.pizza_name,count(co.pizza_id) as pizza_count
from customer_orders1 co
inner join pizza_names pn
on pn.pizza_id = co.pizza_id
group by co.customer_id,pn.pizza_name
order by co.customer_id

--6. What was the maximum number of pizzas delivered in a single order?
with pizza_count_rn as
(select co.order_id,count(co.pizza_id) as pizza_count,
rank() over(order by count(co.pizza_id) desc) as rnk
from customer_orders1 co
inner join runner_orders_1 ro
on co.order_id = ro.order_id
where ro.duration is not null
group by co.order_id)

select order_id,pizza_count from pizza_count_rn
where rnk = 1

--As we constantly need to use the join between the tables customer_orders1 and runner_orders_1,create a view out of it to avoid joining them again
create view delivered_orders as
select co.order_id,co.customer_id,co.pizza_id,co.exclusions,co.extras,co.order_time,
ro.order_id as runners_order_id,ro.runner_id,ro.pickup_time,ro.distance,ro.duration,ro.cancellation from customer_orders1 co
inner join runner_orders_1 ro
on co.order_id = ro.order_id
where ro.distance is not null

--7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
select customer_id,
count(case when exclusions='' and extras='' then 1 end) as no_changes,
count(case when exclusions!='' or extras!='' then 1 end) as changes
from delivered_orders
group by customer_id

--8. How many pizzas were delivered that had both exclusions and extras?
select count(case when exclusions!='' and extras!='' then 1 end) as pizza_having_exclusions_and_extras
from delivered_orders

--9. What was the total volume of pizzas ordered for each hour of the day?
select datepart(hour,order_time) as hour_of_day,count(pizza_id) as pizza_count from customer_orders1
group by datepart(hour,order_time)

--10. What was the volume of orders for each day of the week?
select datename(weekday,order_time) as day_of_week,count(pizza_id) as pizza_count from customer_orders1
group by datename(weekday,order_time)
