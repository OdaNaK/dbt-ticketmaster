with attractions as (
select *
from {{ ref('stg_attractions') }} 
),
classifications as (
select *
from {{ ref('stg_classifications') }}  
)

select 
a.attraction_id,
a.attraction_name,
a.attraction_total_upcoming_events,
c.segment_name

from attractions a
left join classifications c
on c.segment_id = attraction_segment_id