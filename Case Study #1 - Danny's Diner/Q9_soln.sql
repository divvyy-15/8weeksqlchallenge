--9)If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
with cte as
(select s.customer_id as customer_id, s.product_id,m.product_name as product_name,m.price as price from sales s
inner join menu m
on s.product_id = m.product_id)

select customer_id, 
sum(case when product_name = 'Sushi' then price*20
else price*10 
end) as points
from cte
group by customer_id
