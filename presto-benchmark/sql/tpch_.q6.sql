select
    sum(l.extended_price*l.discount) as revenue
from 
    lineitem l
where 
    date(l.ship_date) >= date('1994-01-01')
    and date(l.ship_date) < date(date('1994-01-01') + interval '1' year)
    and l.discount between 0.06 - 0.01 and 0.06 + 0.01
    and l.quantity < 24