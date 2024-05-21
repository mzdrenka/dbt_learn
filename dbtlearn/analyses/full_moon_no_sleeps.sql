WITH MART_FULLMOON_REVIEWS AS (

    SELECT * FROM {{ ref("mart_fullmoon_reviews")}}

)

SELECT
    IS_FULL_MOON,
    REVIEW_SENTIMENT,
    COUNT(*)
FROM 
    MART_FULLMOON_REVIEWS
GROUP BY 
    IS_FULL_MOON,
    REVIEW_SENTIMENT
ORDER BY 
    IS_FULL_MOON,
    REVIEW_SENTIMENT