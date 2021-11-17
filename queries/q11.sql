select
    ps.part_key,
    sum(ps.supply_cost * ps.available_quantity) as value
from
    partsupp ps
    join supplier s
        on ps.supplier_key = s.supplier_key
    join nation n
        on s.nation_key = n.nation_key
where
    n.name = 'GERMANY'
group by
    ps.part_key having
        sum(ps.supply_cost * ps.available_quantity) > (
            select
                sum(psSum.supply_cost * psSum.available_quantity) * 0.0001
            from
                partsupp psSum
                join supplier sSum
                    on psSum.supplier_key = sSum.supplier_key
                join nation nSum
                    on sSum.nation_key = nSum.nation_key
            where
                nSum.name = 'GERMANY'
        )
order by
    value desc;
