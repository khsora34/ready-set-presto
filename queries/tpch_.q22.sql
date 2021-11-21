select 
    cntrycode, 
    count(*) as numcust, 
    sum(balance) as totacctbal
from (
    select 
        substring(c.phone from 1 for 2) as cntrycode, 
        c.account_balance as balance
    from 
        customer c
    where 
        substring(c.phone from 1 for 2) in 
        ('13','31','23','29','30','18','17')
        and c.account_balance > (
            select 
            avg(c1.account_balance)
            from 
            customer c1
            where 
            c1.account_balance > 0.00
            and substring (c1.phone from 1 for 2) in
            ('13','31','23','29','30','18','17')
        )
        and not exists (
            select 
                *
            from 
                orders o
            where 
                o.customer_key = c.customer_key
        )
) as custsale
group by
    cntrycode 
order by 
    cntrycode