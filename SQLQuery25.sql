;WITH CTE_Duplicate AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Email ORDER BY StgID) AS rn
    FROM StgCustomers
    WHERE Email IS NOT NULL
)
UPDATE CTE_Duplicate
SET 
    IsValid = 0,
    ErrorMessage = COALESCE(ErrorMessage + '; ', '') + 'Duplicate email'
WHERE rn > 1;