with 

source as (

    select * from {{ source('ticketmaster_data', 'raw_attractions') }}

),

renamed as (

    select
        id as attraction_id,
        name as attraction_name,
        segment_id as attraction_segment_id,
        genre_id as attraction_genre_id,
        total_upcoming_events as attraction_total_upcoming_events

    from source

)

select * from renamed