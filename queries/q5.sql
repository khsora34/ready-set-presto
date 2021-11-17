select
    n.name, 
    sum(l.extended_price * (1 - l.discount)) as revenue
from 
    customer c
    join orders o
        on c.customer_key = o.customer_key
    join lineitem l
        on l.order_key = o.order_key
    join supplier s
        on s.supplier_key = l.supplier_key
        and c.nation_key = s.nation_key
    join nation n
        on n.nation_key = s.nation_key
    join region r
        on r.region_key = n.region_key
where
    r.name = 'ASIA'
    and date(o.order_date) >= date ('1994-01-01')
    and date(o.order_date) < date(date ('1994-01-01') + interval '1' year)
group by 
    n.name
order by 
    revenue desc;