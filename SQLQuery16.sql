CREATE TABLE RawCustomers (
    RawID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(200),
    Email NVARCHAR(200),
    Phone NVARCHAR(50),
    City NVARCHAR(100),
    BirthDate NVARCHAR(50),   -- ham veri, string geliyor
    SourceSystem NVARCHAR(50),
    LoadDate DATETIME DEFAULT GETDATE()
);