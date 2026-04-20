CREATE TABLE DimCustomer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(200),
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    Email NVARCHAR(200) UNIQUE,
    Phone NVARCHAR(20),
    City NVARCHAR(100),
    BirthDate DATE,
    SourceSystem NVARCHAR(50),
    InsertDate DATETIME DEFAULT GETDATE(),
    UpdateDate DATETIME
);