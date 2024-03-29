--1. How many runners signed up for each 1 week period?

select datepart(WEEK,registration_date) as week_of_year,count(runner_id) as count from runners
group by datepart(WEEK,registration_date)


--2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
with cte as
(select runner_id,datediff(minute,order_time,pickup_time) as time_diff from delivered_orders)
select runner_id,cast(round(avg(time_diff),2) as decimal(10,2)) as avg_time from cte
group by runner_id

--3. Is there any relationship between the number of pizzas and how long the order takes to prepare?
with cte_prep_time as
(select order_id,count(order_id) as pizza_count,DATEDIFF(minute,order_time,pickup_time) as prep_time from delivered_orders
group by order_id,order_time,pickup_time)
select pizza_count,avg(prep_time) as avg_prep_time_required from cte_prep_time
group by pizza_count

--4. What was the average distance travelled for each customer?
select customer_id,cast(avg(distance)as decimal(10,2)) as avg_distance_travelled from delivered_orders
group by customer_id
order by 2 desc

--5. What was the difference between the longest and shortest delivery times for all orders?
select max(duration)-min(duration) as diff_in_longest_shortest_del_time from delivered_orders

--6. What was the average speed for each runner for each delivery and do you notice any trend for these values?
SELECT order_id,runner_id,
CAST(AVG(distance / (duration * 1.00 / 60)) AS decimal(10, 2)) AS avg_speed_kmph
FROM delivered_orders
GROUP BY order_id,runner_id
ORDER BY runner_id;


