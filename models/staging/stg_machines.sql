with source as (
    select * from {{ source('raw_mfg', 'machines') }}
)
select
    machine_id,
    trim(machine_type) as machine_type,
    capacity_per_day,
    cast(last_maintenance_date as timestamp) as last_maintenance_at,
    upper(trim(status)) as machine_status
from source