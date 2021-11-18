select
    o_year, 
    sum(case when nation = 'BRAZIL'
            then volume
            else 0
        end) / sum(volume) as mkt_share
from (
    select
        extract(year from date(o.order_date)) as o_year,
        l.extended_price * (1-l.discount) as volume, 
        n2.name as nation
    from 
        part p
        join lineitem l
            on p.part_key = l.part_key
        join supplier s
            on s.supplier_key = l.supplier_key
        join orders o
            on l.order_key = o.order_key
        join customer c
            on o.customer_key = c.customer_key
        join region r
            on 1 = 1
        join nation n1
            on n1.nation_key = c.nation_key
            and n1.region_key = r.region_key
        join nation n2
            on n2.nation_key = s.nation_key
        where
            r.name = 'AMERICA'
            and date(o.order_date) between date('1995-01-01') and date('1996-12-31')
            and p.type = 'ECONOMY ANODIZED STEEL' 
) as all_nations
group by 
    o_year
order by 
    o_year;