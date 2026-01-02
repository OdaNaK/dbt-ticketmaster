with events as (
    select *
    from {{ ref('stg_events') }}
    where event_status = 'onsale' -- On filtre tôt pour la performance
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
),

final as (
    select 
        e.event_id,
        e.event_name,
        e.event_date,
        v.venue_id,
        v.venue_name,
        v.venue_city,
        v.venue_total_upcoming_events,
        v.venue_country_code,
        v.venue_state_code,
        c.segment_name,
        c.genre_name,
        a.attraction_id,
        a.attraction_name,
        a.attraction_total_upcoming_events,

        -- 1. NOM DU JOUR (Monday, Tuesday...)
        format_date('%A', e.event_date) as event_day_name,
        
        -- 2. DÉRIVÉS TEMPORELS
        extract(hour from e.event_date) as event_hour,
        extract(dayofweek from e.event_date) as event_day_of_week,

        -- 3. DENSITÉ (Combien d'événements dans cette ville)
        count(distinct e.event_id) over (partition by v.venue_city) as city_event_density,

        -- 4. RANKING CORRIGÉ (RANK)

        dense_rank() over (
            order by a.attraction_total_upcoming_events desc
        ) as attraction_rank_global,



    from events e
    left join venues v on e.event_venue_id = v.venue_id
    left join classifications c on e.event_segment_id = c.segment_id
    left join attractions a on e.event_attraction_id = a.attraction_id
)

select * from final