with venues as (
    select * 
    from {{ ref('stg_venues') }}
)

select 
venue_id,
venue_name,
venue_city,
case 
    when venue_country_code = 'US'
    then 'United States'
    else 'Canada'
end as venue_country_name,
count(*) over (
    partition by 
        venue_country_code,
        venue_state_code
) as state_venue_count,
venue_state_code,
venue_market_name
from venues