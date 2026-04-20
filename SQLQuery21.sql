UPDATE StgCustomers
SET 
    IsValid = 0,
    ErrorMessage = COALESCE(ErrorMessage + '; ', '') + 'FullName boş veya eksik'
WHERE FullName IS NULL OR FullName = '';