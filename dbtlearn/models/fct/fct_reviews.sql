WITH SRC_REVIEWS AS (

    SELECT 
        *
    FROM 
        {{ ref("src_reviews") }}

)

SELECT 
    {{ dbt_utils.generate_surrogate_key([ 'LISTING_ID', 'REVIEW_DATE', 'REVIEWER_NAME']) }} AS REVIEW_ID,
    LISTING_ID,
    REVIEW_DATE,
    REVIEWER_NAME,
    REVIEW_TEXT,
    REVIEW_SENTIMENT
FROM 
    SRC_REVIEWS
WHERE
    REVIEW_TEXT IS NOT NULL

{% if is_incremental() %}
  {% if var("start_date", False) and var("end_date", False) %}
    {{ log('Loading ' ~ this ~ ' incrementaly (start_date: ' ~ var("start_date") ~ ', end_date: ' ~ var("end_date") ~ ')', info=True) }}
    AND REVIEW_DATE >= '{{ var("start_date") }}'
    AND REVIEW_DATE < '{{ var("end_date") }}'
    {% else %}
    AND REVIEW_DATE >= COALESCE((SELECT MAX(REVIEW_DATE) FROM {{ this }}), '1900-01-01')
    {{ log('Loading ' ~ this ~ ' incrementaly (all missing dates)', info=True) }}
  {% endif %}
{% endif %}
