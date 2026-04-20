INSERT INTO StgCustomers (
    RawID, FullName, FirstName, LastName, Email, Phone, City, BirthDate, SourceSystem
)
SELECT
    RawID,
    LTRIM(RTRIM(FullName)) AS FullName,

    -- Ad
    CASE 
        WHEN CHARINDEX(' ', LTRIM(RTRIM(FullName))) > 0 
            THEN LEFT(LTRIM(RTRIM(FullName)), CHARINDEX(' ', LTRIM(RTRIM(FullName))) - 1)
        ELSE LTRIM(RTRIM(FullName))
    END AS FirstName,

    -- Soyad
    CASE 
        WHEN CHARINDEX(' ', LTRIM(RTRIM(FullName))) > 0 
            THEN SUBSTRING(
                    LTRIM(RTRIM(FullName)),
                    CHARINDEX(' ', LTRIM(RTRIM(FullName))) + 1,
                    LEN(LTRIM(RTRIM(FullName)))
                 )
        ELSE NULL
    END AS LastName,

    LOWER(LTRIM(RTRIM(Email))) AS Email,

    -- Telefonu sadeleştir
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Phone, ' ', ''), '-', ''), '(', ''), ')', ''), '+', '') AS Phone,

    UPPER(LTRIM(RTRIM(City))) AS City,

    TRY_CONVERT(DATE, BirthDate, 104) AS BirthDate,  -- örnek: dd.mm.yyyy
    LTRIM(RTRIM(SourceSystem))
FROM RawCustomers;