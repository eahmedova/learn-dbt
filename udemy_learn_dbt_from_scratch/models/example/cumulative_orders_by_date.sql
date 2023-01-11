{{ config(materialized='table') }}

with daily_order_sum as (
    select 
        o_orderdate,
        sum(o_totalprice) daily_sales
    from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
    group by o_orderdate
    order by o_orderdate
    )
select 
    o_orderdate,
    sum(daily_sales) over (order by o_orderdate rows unbounded preceding) as cumulative_sales
from daily_order_sum
