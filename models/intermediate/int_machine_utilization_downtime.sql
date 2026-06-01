with machine_base as (
    select * from {{ ref('stg_machines') }}
),
production_aggregates as (
    select 
        machine_id,
        count(production_order_id) as total_jobs_assigned,
        sum(target_production_qty) as total_units_requested,
        avg(calculated_capacity_efficiency_pct) as avg_running_efficiency
    from {{ ref('int_production_efficiency') }}
    group by machine_id
)
select 
    m.machine_id,
    m.machine_type,
    m.machine_status,
    m.last_maintenance_at,
    coalesce(p.total_jobs_assigned, 0) as total_jobs_assigned,
    coalesce(p.total_units_requested, 0) as total_units_processed,
    coalesce(p.avg_running_efficiency, 0.0) as running_efficiency_score,
    case 
        when m.machine_status = 'MAINTENANCE' then 'CRITICAL DOWNTIME'
        when m.machine_status = 'IDLE' then 'UNDERUTILIZED'
        else 'OPTIMALLY ACTIVE'
    end as operational_utilization_tier
from machine_base m
left join production_aggregates p on m.machine_id = p.machine_id