--10)In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

with cte as
(select s.*,dateadd(WEEK,1,m.join_date) as date_after_1_week
from sales s
inner join members m
on s.customer_id = m.customer_id
where s.order_date >= m.join_date
and s.order_date between m.join_date and dateadd(WEEK,1,m.join_date))

select c.customer_id,sum(mu.price*20) as points from cte c
inner join menu mu
on c.product_id = mu.product_id
group by c.customer_id
