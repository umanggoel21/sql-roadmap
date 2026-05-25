-- ====================================================================
-- DAY 28: Phase 5 Case Analytics Projects (Chinook DB)
-- ====================================================================

-- 📊 CASE 1: Customer lifetime classifications.
-- Classify customers into tiers: Platinum (spend > $45), Gold ($30-$45), Silver (<$30).
SELECT c.CustomerId, c.Email,
       SUM(i.Total) AS CumulativeSpend,
       CASE 
           WHEN SUM(i.Total) >= 45.00 THEN 'Platinum'
           WHEN SUM(i.Total) BETWEEN 30.00 AND 45.00 THEN 'Gold'
           ELSE 'Silver'
       END AS CustomerCohortTier
FROM Customer c
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.Email
ORDER BY CumulativeSpend DESC;


-- 📊 CASE 2: Identify the second most expensive track in each genre.
-- Uses Window Functions and CTEs.
WITH TrackRankings AS (
    SELECT GenreId, Name AS TrackName, UnitPrice,
           ROW_NUMBER() OVER (PARTITION BY GenreId ORDER BY UnitPrice DESC) AS PositionIndex
    FROM Track
)
SELECT GenreId, TrackName, UnitPrice
FROM TrackRankings
WHERE PositionIndex = 2;
