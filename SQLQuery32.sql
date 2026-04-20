SELECT
    s.RawID,
    s.FullName,
    s.Email,
    s.Phone,
    s.City,
    s.ErrorMessage
FROM StgCustomers s
WHERE s.IsValid = 0;