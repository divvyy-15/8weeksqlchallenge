--1. How many pizzas were ordered?
select count(order_id) as pizza_order_count from customer_orders

--2. How many unique customer orders were made?
select count(distinct order_id) as unique_order_count from customer_orders

--3. How many successful orders were delivered by each runner?
select runner_id,count(distinct order_id) as successful_orders from runner_orders
where cancellation is null or cancellation in ('null',' ')
group by runner_id

--4. How many of each type of pizza was delivered?
select pizza_id,count(distinct order_id) as pizza_delivered from customer_orders
group by pizza_id

--5. How many Vegetarian and Meatlovers were ordered by each customer?
select customer_id,pizza_id,count(distinct order_id) as pizza_ordered from customer_orders
group by customer_id,pizza_id


--6. What was the maximum number of pizzas delivered in a single order?
select top 1 order_id,count(pizza_id) as no_of_pizzas from customer_orders
group by order_id
order by 2 desc
