select
    s.name,
    count(*) as numwait
from
    supplier s,
    lineitem l1,
    orders o,
    nation n
where
    s.supplier_key = l1.supplier_key
    and o.order_key = l1.order_key
    and o.order_status = 'F'
    and l1.receipt_date > l1.commit_date
    and exists (
        select
            *
        from
            lineitem l2
        where
            l2.order_key = l1.order_key
            and l2.supplier_key <> l1.supplier_key
    )
    and not exists (
        select
            *
        from
            lineitem l3
        where
            l3.order_key = l1.order_key
            and l3.supplier_key <> l1.supplier_key
            and l3.receipt_date > l3.commit_date
    )
    and s.nation_key = n.nation_key
    and n.name = 'SAUDI ARABIA'
group by
    s.name
order by
    numwait desc,
    s.name;
    
    select
            *
        from
            supplier s,
            orders o,
            lineitem l1,
            lineitem l3
        where
            l3.order_key = l1.order_key
            and l3.supplier_key <> l1.supplier_key
            and l3.receipt_date > l3.commit_date
            and s.supplier_key = l1.supplier_key
            and o.order_key = l1.order_key
            and o.order_status = 'F'
            and l1.receipt_date > l1.commit_date
