select
    sum(l.extended_price * (1 - l.discount) ) as revenue
from 
    lineitem l
    join part p
        on p.part_key = l.part_key
where 
(
    p.brand = 'Brand#12'
    and p.container in ( 'SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') 
    and l.quantity >= 1 and l.quantity <= 1 + 10 
    and p.size between 1 and 5 
    and l.ship_mode in ('AIR', 'AIR REG')
    and l.ship_instructions = 'DELIVER IN PERSON'
)
or 
(
    p.brand = 'Brand#23'
    and p.container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
    and l.quantity >= 10 and l.quantity <= 10 + 10
    and p.size between 1 and 10
    and l.ship_mode in ('AIR', 'AIR REG')
    and l.ship_instructions = 'DELIVER IN PERSON'
)
or 
(
    p.brand = 'Brand#34'
    and p.container in ( 'LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
    and l.quantity >= 20 and l.quantity <= 20 + 10
    and p.size between 1 and 15
    and l.ship_mode in ('AIR', 'AIR REG')
    and l.ship_instructions = 'DELIVER IN PERSON'
)