WITH Needed AS(
    SELECT WID 
    FROM VEHICLE V, INSPECTION I 
    WHERE V.FuellingType = 'LPG-fueled' AND V.RegistrationYear <2015 AND 
        AND V.LicensePlate# = I.LicensePlate#; 
)
SELECT Name, Address 
FROM WORKSHOP W 
WHERE W.CIty = 'Turin' AND W.WID NOT IN Needed;