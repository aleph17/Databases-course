WITH Needed AS(
    SELECT I.WID, W.City, COUNT(*) AS NoInspections , COUNT(DISTINCT Model) AS NoModels, SUM(Cost) AS Total
    FROM INSPECTION I, VEHICLE V, CUSTOMER C, WORKSHOP W 
    WHERE C.BirthDate >= 01/01/1970 AND C.BirhtDate <01/01/1981 AND
        I.LicensePlate# = V.LicensePlate# AND C.SSN = V.SSN 
        W.WID = I.WID
    GROUP BY I.WID, W.City 
    HAVING COUNT(DISTINCT I.LicensePlate#) >=200;
)
SELECT Name, Address, NoInspections, NoModels, Total
FROM WORKSHOP W, Needed N1
WHERE W.WID = N1.WID AND N1.NoInspections =(SELECT MAX(NoInspections)
                                            FROM Needed N2
                                            WHERE N1.City = N2.City)