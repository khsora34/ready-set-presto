select
    100.00 * sum(case
        when p.type like 'PROMO%'
            then l.extended_price*(1-l.discount)
        else 0
    end) / sum(l.extended_price * (1 - l.discount)) as promo_revenue
from
    lineitem l
    join part p
        on l.part_key = p.part_key
and date(l.ship_date) >= date ('1995-09-01')
and date(l.ship_date) < date(date ('1995-09-01') + interval '1' month);