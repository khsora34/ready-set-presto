
select
    s.acctbal,
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
      ON p.part_key = ps.partkey
      JOIN supplier s
      ON s.suppkey = ps.suppkey
      JOIN nation n
      ON s.nationkey = n.nationkey
      JOIN region r
      ON n.regionkey = r.regionkey
where
    p.size = 15
    and p.type like 'BRASS'
    and r.name = 'EUROPE'
    and ps.supplycost = (
        select
            min(ps.supplycost)
        from
            partsupp psMin
              JOIN supplier sMin
              ON sMin.suppkey = psMin.suppkey
              JOIN nation nMin
              ON sMin.nationkey = nMin.nationkey
              JOIN region rMin
              ON nMin.regionkey = rMin.regionkey
        where
          p.part_key = psMin.partkey
          and r.name = 'EUROPE'
    )
order by
    s.acctbal desc,
    n.name,
    s.name,
    p.part_key;
