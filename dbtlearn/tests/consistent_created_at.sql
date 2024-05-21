

SELECT *
FROM {{ ref("fct_reviews") }} FR
INNER JOIN {{ ref("dim_listings_cleansed") }} DLC
ON FR.LISTING_ID = DLC.LISTING_ID
AND FR.REVIEW_DATE <= DLC.CREATED_AT
LIMIT 10
