-- models/marts/fct_events_detailed.sql

WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
),

venues AS (
    SELECT * FROM {{ ref('stg_venues') }}
),

attractions AS (
    SELECT * FROM {{ ref('stg_attractions') }}
),

classifications AS (
    SELECT 
        segment_id,
        segment_name
    FROM {{ ref('stg_classifications') }}
),

final AS (
    SELECT
        -- Infos Événement
        e.event_id,
        e.event_name,
        e.event_status,
        e.event_type,
        
        -- Analyse Temporelle
        e.event_date,
        EXTRACT(HOUR FROM e.event_date) AS event_start_hour,
        CASE 
            WHEN EXTRACT(HOUR FROM e.event_date) BETWEEN 8 AND 11 THEN 'Matinée'
            WHEN EXTRACT(HOUR FROM e.event_date) BETWEEN 12 AND 16 THEN 'Après-midi'
            WHEN EXTRACT(HOUR FROM e.event_date) BETWEEN 17 AND 21 THEN 'Soirée'
            ELSE 'Nuit'
        END AS event_day_part,
        FORMAT_DATETIME('%A', e.event_date) AS event_day_of_week,

        -- Infos Lieu (Venue)
        v.venue_name,
        v.venue_city,
        v.venue_state_code,
        v.venue_total_upcoming_events,

        -- Infos Attractions (Artistes / Equipes)
        a.attraction_name,
        a.attraction_total_upcoming_events,

        -- Infos Catégorie
        c.segment_name,

        -- Prix & Métriques de santé
        e.event_minimum_price,
        e.event_maximum_price,
        CASE WHEN e.event_status = 'onsale' THEN 1 ELSE 0 END AS is_active,
        CASE WHEN e.event_status = 'canceled' THEN 1 ELSE 0 END AS is_canceled

    FROM events e
    LEFT JOIN venues v ON e.event_venue_id = v.venue_id
    LEFT JOIN attractions a ON e.event_attraction_id = a.attraction_id
    LEFT JOIN classifications c ON e.event_segment_id = c.segment_id
)

SELECT * FROM final