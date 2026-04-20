CREATE PROCEDURE sp_RunCustomerETL
AS
BEGIN
    SET NOCOUNT ON;

    -- İstersen her çalıştırmada staging temizlenebilir
    TRUNCATE TABLE StgCustomers;

    -- Extract
    INSERT INTO StgCustomers (
        RawID, FullName, FirstName, LastName, Email, Phone, City, BirthDate, SourceSystem
    )
    SELECT
        RawID,
        LTRIM(RTRIM(FullName)),
        CASE 
            WHEN CHARINDEX(' ', LTRIM(RTRIM(FullName))) > 0 
                THEN LEFT(LTRIM(RTRIM(FullName)), CHARINDEX(' ', LTRIM(RTRIM(FullName))) - 1)
            ELSE LTRIM(RTRIM(FullName))
        END,
        CASE 
            WHEN CHARINDEX(' ', LTRIM(RTRIM(FullName))) > 0 
                THEN SUBSTRING(
                        LTRIM(RTRIM(FullName)),
                        CHARINDEX(' ', LTRIM(RTRIM(FullName))) + 1,
                        LEN(LTRIM(RTRIM(FullName)))
                     )
            ELSE NULL
        END,
        LOWER(LTRIM(RTRIM(Email))),
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Phone, ' ', ''), '-', ''), '(', ''), ')', ''), '+', ''),
        UPPER(LTRIM(RTRIM(City))),
        TRY_CONVERT(DATE, BirthDate, 104),
        LTRIM(RTRIM(SourceSystem))
    FROM RawCustomers;

    -- Validation
    UPDATE StgCustomers
    SET IsValid = 0,
        ErrorMessage = COALESCE(ErrorMessage + '; ', '') + 'FullName boş veya eksik'
    WHERE FullName IS NULL OR FullName = '';

    UPDATE StgCustomers
    SET IsValid = 0,
        ErrorMessage = COALESCE(ErrorMessage + '; ', '') + 'Geçersiz email formatı'
    WHERE Email IS NULL OR Email NOT LIKE '%_@_%._%';

    UPDATE StgCustomers
    SET IsValid = 0,
        ErrorMessage = COALESCE(ErrorMessage + '; ', '') + 'Geçersiz doğum tarihi'
    WHERE BirthDate IS NULL;

    UPDATE StgCustomers
    SET IsValid = 0,
        ErrorMessage = COALESCE(ErrorMessage + '; ', '') + 'Geçersiz telefon'
    WHERE LEN(Phone) < 10 OR LEN(Phone) > 15;

    ;WITH CTE_Duplicate AS (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY Email ORDER BY StgID) AS rn
        FROM StgCustomers
        WHERE Email IS NOT NULL
    )
    UPDATE CTE_Duplicate
    SET IsValid = 0,
        ErrorMessage = COALESCE(ErrorMessage + '; ', '') + 'Duplicate email'
    WHERE rn > 1;

    -- Log
    INSERT INTO DataQualityLog (RawID, ColumnName, ErrorType, ErrorDetail)
    SELECT RawID, 'General', 'Validation Error', ErrorMessage
    FROM StgCustomers
    WHERE IsValid = 0;

    -- Insert
    INSERT INTO DimCustomer (
        FullName, FirstName, LastName, Email, Phone, City, BirthDate, SourceSystem
    )
    SELECT
        FullName, FirstName, LastName, Email, Phone, City, BirthDate, SourceSystem
    FROM StgCustomers s
    WHERE s.IsValid = 1
      AND NOT EXISTS (
            SELECT 1 FROM DimCustomer d WHERE d.Email = s.Email
      );

    -- Update
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
    INNER JOIN StgCustomers s ON d.Email = s.Email
    WHERE s.IsValid = 1;

END;