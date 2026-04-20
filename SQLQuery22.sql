UPDATE StgCustomers
SET 
    IsValid = 0,
    ErrorMessage = COALESCE(ErrorMessage + '; ', '') + 'Geçersiz email formatı'
WHERE Email IS NULL
   OR Email NOT LIKE '%_@_%._%';