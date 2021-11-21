select 
    c.name,
    c.customer_key, 
    o.order_key,
    o.order_date,
    o.total_price,
    sum(l.quantity)
from 
    customer c
    join orders o
        on c.customer_key = o.customer_key
    join lineitem l
        on o.order_key = l.order_key
where 
    o.order_key in (
        select
        l1.order_key
        from
            lineitem l1
        group by 
            l1.order_key
        having 
            sum(l1.quantity) > 300
)
group by 
    c.name, 
    c.customer_key, 
    o.order_key, 
    o.order_date, 
    o.total_price
order by 
    o.total_price desc,
    o.order_date