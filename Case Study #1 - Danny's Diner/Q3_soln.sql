--3)What was the first item from the menu purchased by each customer?
with cte as
(select *,rank() over(partition by customer_id order by order_date) as rn from sales)

select distinct c.customer_id,m.product_name from cte c
inner join menu m
on c.product_id = m.product_id
where rn=1
