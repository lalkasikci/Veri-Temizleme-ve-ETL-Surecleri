SELECT
    ErrorType,
    COUNT(*) AS ErrorCount
FROM DataQualityLog
GROUP BY ErrorType
ORDER BY ErrorCount DESC;