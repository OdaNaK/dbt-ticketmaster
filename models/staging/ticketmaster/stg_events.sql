with 

source as (

    select * from {{ source('ticketmaster_data', 'raw_events') }}

),

renamed as (

    select
        name as event_name,
        id as event_id,
        start_date_local as event_date,
        start_time_local as event_starting_at,
        end_date_local,
        end_time_local,
        venue_id as event_venue_id,
        attraction_id as event_attraction_id,
        segment_id as event_segment_id,
        price_min as event_minimum_price,
        price_max as event_maximum_price,

    from source

)

select *
from renamed

