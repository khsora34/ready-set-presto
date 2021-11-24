select
    nation,
    o_year,
    sum(amount) as sum_profit
from (
    select
        n.name as nation,
        extract(year from date(o.order_date)) as o_year,
        l.extended_price * (1 - l.discount) - ps.supply_cost * l.quantity as amount
    from
        lineitem l
        join supplier s
            on s.supplier_key = l.supplier_key
        join partsupp ps
            on ps.supplier_key = l.supplier_key
        join part p
            on p.part_key = l.part_key
        join orders o
            on o.order_key = l.order_key
        join nation n
            on s.nation_key = n.nation_key 
    where
        p.name like '%green%'
) as profit
group by
    nation,
    o_year
order by
    nation, 
    o_year desc
