with member_cte as (
    select s.customer_id, s.order_date, m.product_name, m.price,
    case when s.order_date >= mb.join_date then 'Y'
    else 'N'
    end as member
    from sales s
    left join menu m
    on s.product_id = m.product_id
    left join members mb
    on s.customer_id = mb.customer_id
),
rank_cte as (
    select customer_id, order_date, product_name, price, member,
    rank() over(partition by customer_id order by order_date) as ranking
    from member_cte
    where member = 'Y'
),
final_cte as (
    select mc.customer_id, mc.order_date, mc.product_name, mc.price, mc.member, rc.ranking
    from member_cte mc
    left join rank_cte rc
    on mc.customer_id = rc.customer_id
        and mc.order_date = rc.order_date
        and mc.member = rc.member
)
select * from final_cte;
