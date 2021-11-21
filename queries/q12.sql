select
    l.ship_mode,
    sum(case
            when o.order_priority ='1-URGENT'
                or o.order_priority ='2-HIGH' 
            then 1
            else 0
    end) as high_line_count,
    sum(case
            when o.order_priority <> '1-URGENT'
                and o.order_priority <> '2-HIGH' 
            then 1
            else 0
    end) as low_line_count
from
    orders o
    join lineitem l
        on o.order_key = l.order_key
where
    l.ship_mode in ('MAIL', 'SHIP') 
    and date(l.commit_date) < date(l.receipt_date)
    and date(l.ship_date) < date(l.commit_date)
    and date(l.receipt_date) >= date('1994-01-01')
    and date(l.receipt_date) < date(date('1994-01-01') + interval '1' year)
group by 
    l.ship_mode
order by 
    l.ship_mode;
