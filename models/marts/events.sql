with events as (
    select *
    from {{ ref('stg_events') }}
),

venues as (
    select *
    from {{ ref('stg_venues') }}
),

attractions as (
    select *
    from {{ ref('stg_attractions') }}
),

classifications as (
    select *
    from {{ ref('stg_classifications') }}
)

select 
    e.event_id,
    v.venue_name,
    v.venue_city,
    v.venue_total_upcoming_events,
    c.segment_name,
    c.genre_name,
    a.attraction_name,

    -- dérivés temporels
    extract(hour from e.event_date) as event_hour,
    extract(dayofweek from e.event_date) as event_day_of_week

from events e
left join venues v 
    on e.event_venue_id = v.venue_id
left join classifications c
    on e.event_segment_id = c.segment_id
left join attractions a 
    on e.event_attraction_id = a.attraction_id

where e.event_status = 'onsale'
