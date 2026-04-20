UPDATE d
SET
    d.FullName = s.FullName,
    d.FirstName = s.FirstName,
    d.LastName = s.LastName,
    d.Phone = s.Phone,
    d.City = s.City,
    d.BirthDate = s.BirthDate,
    d.SourceSystem = s.SourceSystem,
    d.UpdateDate = GETDATE()
FROM DimCustomer d
INNER JOIN StgCustomers s
    ON d.Email = s.Email
WHERE s.IsValid = 1;