--8)What is the total items and amount spent for each member before they became a member?
with before_membership_details as
(select s.customer_id as customer_id,s.product_id from sales s 
inner join members mb
on s.customer_id = mb.customer_id
where s.order_date<mb.join_date)

select bmd.customer_id,count(1) as total_items_ordered,sum(m.price) as amount_spent from before_membership_details bmd
inner join menu m
on bmd.product_id =m.product_id
group by bmd.customer_id
