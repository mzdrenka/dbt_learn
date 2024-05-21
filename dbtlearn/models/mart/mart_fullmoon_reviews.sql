{{
    config(
        materialized='table'
    )
}}

WITH FCT_REVIEWS AS (

    SELECT * FROM {{ ref("fct_reviews")}}

), FULL_MOON_DATES AS (

    SELECT * FROM {{ ref("seed_full_moon_dates") }}

)

SELECT
 r.*,
 CASE
 WHEN fm.full_moon_date IS NULL THEN 'not full moon'
 ELSE 'full moon'
 END AS is_full_moon
FROM
 fct_reviews
 r
 LEFT JOIN full_moon_dates
 fm
 ON (TO_DATE(r.review_date) = DATEADD(DAY, 1, fm.full_moon_date))