select
    s.account_balance,
    s.name,
    n.name,
    p.part_key,
    p.manufacturer,
    s.address,
    s.phone,
    s.comment
from
    part p
      JOIN partsupp ps
      ON p.part_key = ps.part_key
      JOIN supplier s
      ON s.supplier_key = ps.supplier_key
      JOIN nation n
      ON s.nation_key = n.nation_key
      JOIN region r
      ON n.region_key = r.region_key
where
    p.size = 15
    and p.type like '%BRASS'
    and r.name = 'EUROPE'
    and ps.supply_cost = (
        select
            min(psMin.supply_cost)
        from
            partsupp psMin
              JOIN supplier sMin
              ON sMin.supplier_key = psMin.supplier_key
              JOIN nation nMin
              ON sMin.nation_key = nMin.nation_key
              JOIN region rMin
              ON nMin.region_key = rMin.region_key
        where
          p.part_key = psMin.part_key
          and rMin.name = 'EUROPE'
    )
order by
    s.account_balance desc,
    n.name,
    s.name,
    p.part_key;
