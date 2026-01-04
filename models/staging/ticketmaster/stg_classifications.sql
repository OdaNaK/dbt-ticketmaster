with 

source as (

    select * from {{ source('ticketmaster_data', 'raw_classifications') }}

),

renamed as (

    select 
    segment_id,
    segment_name,

    from source

    where segment_id is not null

    group by all

)

select * from renamed