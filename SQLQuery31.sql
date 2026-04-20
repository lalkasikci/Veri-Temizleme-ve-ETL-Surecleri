SELECT
    ColumnName,
    COUNT(*) AS ErrorCount
FROM DataQualityLog
GROUP BY ColumnName
ORDER BY ErrorCount DESC;