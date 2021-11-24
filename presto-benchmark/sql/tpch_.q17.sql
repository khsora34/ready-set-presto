select
    sum(l.extended_price) / 7.0 as avg_yearly
from
    lineitem l,
    part p
where
    p.part_key = l.part_key
    and p.brand = 'Brand#23'
    and p.container = 'MED BOX.'
    and l.quantity < (
        select
            0.2 * avg(lItem.quantity)
        from
            lineitem lItem
        where
            lItem.part_key = p.part_key
    )
