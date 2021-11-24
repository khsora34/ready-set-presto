select
    s.name,
    s.address
from
    supplier s,
    nation n
where
    s.supplier_key in (
        select
            ps.supplier_key
        from
            partsupp ps
        where
            ps.part_key in (
                select
                    p.part_key
                from
                    part p
                where
                    p.name like 'forest%'
            )
            and ps.available_quantity > (
                select
                    0.5 * sum(l.quantity)
                from
                    lineitem l
                where
                    l.part_key = ps.part_key
                    and l.supplier_key = ps.supplier_key
                    and date(l.ship_date) >= date('1994-01-01')
                    and date(l.ship_date) < date('1994-01-01') + interval '1' year
            )
    )
    and s.nation_key = n.nation_key
    and n.name = 'CANADA'
order by
    s.name;
