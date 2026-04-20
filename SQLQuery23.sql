UPDATE StgCustomers
SET 
    IsValid = 0,
    ErrorMessage = COALESCE(ErrorMessage + '; ', '') + 'Geçersiz doğum tarihi'
WHERE BirthDate IS NULL;