CREATE TABLE DataQualityLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    RawID INT,
    ColumnName NVARCHAR(100),
    ErrorType NVARCHAR(100),
    ErrorDetail NVARCHAR(500),
    LogDate DATETIME DEFAULT GETDATE()
);