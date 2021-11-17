select
    l.return_flag,
    l.status,
    sum(l.quantity) as sum_qty,
    sum(l.extended_price) as sum_base_price,
    sum(l.extended_price*(1-l.discount)) as sum_disc_price,
    sum(l.extended_price*(1-l.discount)*(1+l.tax)) as sum_charge,
    avg(l.quantity) as avg_qty, 
    avg(l.extended_price) as avg_price,
    avg(l.discount) as avg_disc, 
    count(*) as count_order
from
    lineitem l
where
    date(l.ship_date) <= date(date('1998-12-01') - INTERVAL '80' day)
group by
    l.return_flag, l.status
order by
    l.return_flag, l.status;