WITH Needed AS(
    SELECT SSN 
    FROM VEHICLE V1
    WHERE RegistrationYear > 01/01/2010
    GROUP BY SSN 
    HAVING COUNT(*)>=2;
)
SELECT C.LastName,V.LicensePlate#, V.Maker, COUNT(*), AVG(I.Cost), COUNT(DISTINCT I.WID)
FROM CUSTOMER C, VEHICLE V, INSPECTION I 
WHERE C.SSN = V.SSN AND I.LicensePlate# = V.LicensePlate# AND BirthDate >01/01/1980 AND V.SSN IN Needed
GROUP BY C.SSN, C.LastName, v.LicensePlate#, V.Maker;