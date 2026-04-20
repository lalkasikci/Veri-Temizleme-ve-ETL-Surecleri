INSERT INTO DataQualityLog (RawID, ColumnName, ErrorType, ErrorDetail)
SELECT RawID, 'FullName', 'Missing Data', 'FullName boş veya eksik'
FROM StgCustomers
WHERE ErrorMessage LIKE '%FullName boş veya eksik%';

INSERT INTO DataQualityLog (RawID, ColumnName, ErrorType, ErrorDetail)
SELECT RawID, 'Email', 'Invalid Format', 'Geçersiz email formatı'
FROM StgCustomers
WHERE ErrorMessage LIKE '%Geçersiz email formatı%';

INSERT INTO DataQualityLog (RawID, ColumnName, ErrorType, ErrorDetail)
SELECT RawID, 'BirthDate', 'Invalid Format', 'Geçersiz doğum tarihi'
FROM StgCustomers
WHERE ErrorMessage LIKE '%Geçersiz doğum tarihi%';

INSERT INTO DataQualityLog (RawID, ColumnName, ErrorType, ErrorDetail)
SELECT RawID, 'Phone', 'Invalid Data', 'Geçersiz telefon'
FROM StgCustomers
WHERE ErrorMessage LIKE '%Geçersiz telefon%';

INSERT INTO DataQualityLog (RawID, ColumnName, ErrorType, ErrorDetail)
SELECT RawID, 'Email', 'Duplicate', 'Duplicate email'
FROM StgCustomers
WHERE ErrorMessage LIKE '%Duplicate email%';