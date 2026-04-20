SELECT
    COUNT(*) AS TotalRecord,
    SUM(CASE WHEN IsValid = 1 THEN 1 ELSE 0 END) AS ValidRecord,
    SUM(CASE WHEN IsValid = 0 THEN 1 ELSE 0 END) AS InvalidRecord
FROM StgCustomers;