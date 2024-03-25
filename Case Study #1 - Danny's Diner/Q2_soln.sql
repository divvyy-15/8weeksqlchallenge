--2)How many days has each customer visited the restaurant?
select customer_id,count(distinct order_date) as days_visited from sales
group by customer_id
