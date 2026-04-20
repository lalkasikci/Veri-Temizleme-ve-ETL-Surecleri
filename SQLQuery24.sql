UPDATE StgCustomers
SET 
    IsValid = 0,
    ErrorMessage = COALESCE(ErrorMessage + '; ', '') + 'Geçersiz telefon'
WHERE LEN(Phone) < 10 OR LEN(Phone) > 15;