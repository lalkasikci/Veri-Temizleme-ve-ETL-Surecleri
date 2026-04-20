INSERT INTO DimCustomer (
    FullName, FirstName, LastName, Email, Phone, City, BirthDate, SourceSystem
)
SELECT
    FullName,
    FirstName,
    LastName,
    Email,
    Phone,
    City,
    BirthDate,
    SourceSystem
FROM StgCustomers s
WHERE s.IsValid = 1
  AND NOT EXISTS (
      SELECT 1
      FROM DimCustomer d
      WHERE d.Email = s.Email
  );