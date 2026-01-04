select
  segment_id,
  genre_id,
  segment_name,
  genre_name
from {{ ref('stg_classifications') }}
group by all
