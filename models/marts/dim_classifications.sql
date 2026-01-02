with classifications as 
(select *
from {{ ref('stg_classifications') }})

select *
from classifications