--BONUS QUESTIONS - Join All The Things:
select s.customer_id,s.order_date,m.product_name,m.price,
case when s.order_date >= mb.join_date then 'Y'
else 'N'
end as member
from sales s
left join menu m
on s.product_id = m.product_id
left join members mb
on s.customer_id = mb.customer_id
