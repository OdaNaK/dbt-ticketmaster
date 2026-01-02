with 

source as (

    select * from {{ source('ticketmaster_data', 'raw_classifications') }}

),

renamed as (

    select *

    from source

)

select * from renamed