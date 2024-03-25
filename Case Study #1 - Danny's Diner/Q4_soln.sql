--4)What is the most purchased item on the menu and how many times was it purchased by all customers?
select top 1 m.product_name,count(customer_id) as prod_count from sales s
inner join menu m
on m.product_id = s.product_id
group by m.product_name
order by 2 desc
