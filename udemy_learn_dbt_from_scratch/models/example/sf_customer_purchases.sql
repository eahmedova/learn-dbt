{{ config(materialized='table') }}

select 
    c.C_CUSTKEY,
    c.c_name,
    c.c_nationkey as nation,
    sum(o.o_totalprice) as total_order_price
from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER c
left join SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS o
on c.c_custkey = o.o_custkey
group by c.c_custkey, c.c_name, c.c_nationkey
having total_order_price > 0
order by total_order_price DESC
