select 
    c_count, count(*) as custdist 
from (
    select 
        c.customer_key,
        count(o.order_key)
    from 
        customer c
        left outer join orders o
            on c.customer_key = o.customer_key
            and o.comment not like '%special%requests%'
    group by 
        c.customer_key
)as c_orders (c_custkey, c_count)
group by 
c_count
order by 
custdist desc, 
c_count desc
