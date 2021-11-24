select
    supp_nation,
    cust_nation,
    l_year, sum(volume) as revenue 
from (
    select
        n1.name as supp_nation,
        n2.name as cust_nation,
        extract(year from date(l.ship_date)) as l_year, 
        l.extended_price * (1 - l.discount) as volume
    from
        supplier s
        join lineitem l
            on s.supplier_key = l.supplier_key
        join orders o
            on o.order_key = l.order_key
        join customer c
            on c.customer_key = o.customer_key
        join nation n1
            on s.nation_key = n1.nation_key
        join nation n2
            on c.nation_key = n2.nation_key 
    where
        (
            (
                n1.name = 'FRANCE' 
                and n2.name = 'GERMANY'
            ) 
            or (
                n1.name = 'GERMANY' 
                and n2.name = 'FRANCE'
            )
        )
        and date(l.ship_date) between date '1995-01-01' and date '1996-12-31'
    ) as shipping
group by 
    supp_nation,
    cust_nation,
    l_year
order by
    supp_nation, 
    cust_nation, 
    l_year;
