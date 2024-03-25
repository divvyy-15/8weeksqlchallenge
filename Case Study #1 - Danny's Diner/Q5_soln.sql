--5)Which item was the most popular for each customer?
with cte as
(select customer_id,product_id,count(product_id) as count_of_purchased_item,
rank() over(partition by customer_id order by count(product_id) desc) as rn from sales
group by customer_id,product_id)

select c.customer_id,m.product_name as popular_product,count_of_purchased_item from cte c
inner join menu m
on c.product_id = m.product_id
where rn=1
