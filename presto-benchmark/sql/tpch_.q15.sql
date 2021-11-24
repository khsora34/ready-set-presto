with revenue as (
select 
    l.supplier_key as supplier_no, 
    sum(l.extended_price * (1 - l.discount)) as total_revenue
from 
    lineitem l
where 
    date(l.ship_date) >= date '1996-01-01'
    and date(l.ship_date) < date(date('1996-01-01') + interval '3' month)
group by 
    l.supplier_key)
select
    s.supplier_key,
    s.name, 
    s.address, 
    s.phone, 
    total_revenue
from 
    supplier s
    join revenue r
        on s.supplier_key = r.supplier_no    
where 
    total_revenue = (
        select 
            max(total_revenue)
        from 
            revenue
        )
order by 
    s.supplier_key