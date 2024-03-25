--7)Which item was purchased just before the customer became a member?
with cte as
(select s.customer_id as customer_id,s.product_id,m.join_date,s.order_date,
rank() over(partition by s.customer_id order by order_date desc) as rn from sales s
inner join members m
on s.customer_id = m.customer_id
where s.order_date < m.join_date)

select c.customer_id,mu.product_name from cte c
inner join menu mu
on c.product_id = mu.product_id
where rn = 1
