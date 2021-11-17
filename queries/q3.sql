select
    l.order_key, 
    sum(l.extended_price*(1-l.discount)) as revenue,
    o.order_date,
    o.ship_priority
from 
    customer c
        join orders o
        on c.customer_key = o.customer_key 
    join lineitem l
        on l.order_key = o.order_key
where 
    c.market_segment = 'BUILDING'
    and date(o.order_date) < date('1995-03-15')
    and date(l.ship_date) > date('1995-03-15')
group by 
    l.order_key, 
    o.order_date, 
    o.ship_priority
order by 
    revenue desc, 
    o.order_date;