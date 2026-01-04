with 

source as (

    select * from {{ source('ticketmaster_data', 'raw_venues') }}

),

renamed as (

    select
        id as venue_id,
        name as venue_name,
        city_name as venue_city,
        state_statecode as venue_state_code,
        country_countrycode as venue_country_code,
        market_id as venue_market_id,
        market_name as venue_market_name,
        total_upcoming_events as venue_total_upcoming_events

    from source

)

select * from renamed
