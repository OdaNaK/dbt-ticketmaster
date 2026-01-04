with 

source as (

    select * from {{ source('ticketmaster_data', 'raw_events') }}

),

renamed as (

    select
        name as event_name,
        id as event_id,
        PARSE_DATETIME('%Y-%m-%d %H:%M:%S', CONCAT(start_date_local, ' ', start_time_local)) AS event_date,
        status_code as event_status,
        end_date_local,
        end_time_local,
        venue_id as event_venue_id,
        attraction_id as event_attraction_id,
        segment_id as event_segment_id,
        genre_id as event_genre_id,
        price_min as event_minimum_price,
        price_max as event_maximum_price,
        type_name as event_type,
        subtype_name as event_subtype,
        latitude as event_latitude,
        longitude as event_longitude

    from source

)

select *
from renamed