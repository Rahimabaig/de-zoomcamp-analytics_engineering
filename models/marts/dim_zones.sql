
with zones as (
    select
        locationid,
        borough,
        zone,
        service_zone
    from {{ ref('taxi_zone_lookup') }}
)

select * from zones

-- select
--     count(*) as total_rows
-- from {{ ref('taxi_zone_lookup') }}

-- select
--     count(distinct zone) as unique_zone_count
-- from zones