{{
    config(
        materialized='incremental',
        unique_key='production_order_id',
        
    )
}}

select 
    production_order_id,
    product_id,
    machine_id,
    target_production_qty,
    run_duration_days,
    calculated_capacity_efficiency_pct,
    order_status,
    production_started_at

from {{ ref('int_production_efficiency') }}

{% if is_incremental() %}
    where production_started_at >= (
        select max(production_started_at)
        from {{ this }}
    ) - interval '3 days'
{% endif %}