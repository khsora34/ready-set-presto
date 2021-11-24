select
    c.customer_key,
    c.name,
    sum(l.extended_price * (1 - l.discount)) as revenue, 
    c.account_balance,
    n.name,
    c.address,
    c.phone,
    c.comment
from
    customer c
    join orders o
        on c.customer_key = o.customer_key
    join lineitem l
        on l.order_key = o.order_key
    join nation n
        on c.nation_key = n.nation_key
where
    date(o.order_date) >= date '1993-10-01'
    and date(o.order_date) < date(date('1993-10-01') + interval '3' month)
    and l.return_flag = 'R'
group by 
    c.customer_key,
    c.name, 
    c.account_balance, 
    c.phone, 
    n.name, 
    c.address, 
    c.comment
order by
    revenue desc
