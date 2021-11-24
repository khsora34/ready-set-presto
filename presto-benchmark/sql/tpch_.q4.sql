select
    o.order_priority, 
    count(*) as order_count
from 
    orders o
where 
    date(o.order_date) >= date ('1993-07-01')
    and date(o.order_date) < date(date ('1993-07-01') + interval '3' month)
and exists (
    select 
        *
    from 
        lineitem l
    where 
        l.order_key = o.order_key
        and l.commit_date < l.receipt_date
)
group by 
    o.order_priority
order by 
    o.order_priority