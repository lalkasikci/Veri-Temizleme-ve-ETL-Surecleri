CREATE TABLE StgCustomers (
    StgID INT IDENTITY(1,1) PRIMARY KEY,
    RawID INT,
    FullName NVARCHAR(200),
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    Email NVARCHAR(200),
    Phone NVARCHAR(20),
    City NVARCHAR(100),
    BirthDate DATE,
    SourceSystem NVARCHAR(50),
    IsValid BIT DEFAULT 1,
    ErrorMessage NVARCHAR(500),
    ProcessDate DATETIME DEFAULT GETDATE()
);