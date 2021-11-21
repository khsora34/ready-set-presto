select
    p.brand, 
    p.type, 
    p.size, 
    count(distinct ps.supplier_key) as supplier_cnt
from 
    partsupp ps
    join part p
        on p.part_key = ps.part_key
where 
    p.brand <> 'Brand#45'
    and p.type not like 'MEDIUM POLISHED'
    and p.size in (49, 14, 23, 45, 19, 3, 36, 9)
    and ps.supplier_key not in (
    select
        s.supplier_key
    from 
        supplier s
    where 
        s.comment like '%Customer%Complaints%'
)
group by 
    p.brand, 
    p.type, 
    p.size
order by 
    supplier_cnt desc, 
    p.brand,
    p.type, 
    p.size