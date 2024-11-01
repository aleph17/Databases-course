WITH Needed AS(
    SELECT SID
    FROM ORDER_INCLUDE OI1, ORDER O1 
    WHERE O1.OID = OI1.OID AND Date>= 01/05/2023 AND Date <= 31/05/2023 
    GROUP BY SID 
    HAVING SUM(Quantity*UnitCost) >= (SELECT 2*SUM(Quantity*UnitCost)
                                      FROM ORDER_INCLUDE OI2, ORDER O2 
                                      WHERE O1.OID = OI1.OID AND 
                                         Date>= 01/04/2023 AND Date <= 31/04/2023
                                         AND  O2.SID = O1.SID)
)
SELECT Category, COUNT(DISTINCT SID) 
FROM TOY_BUILDING_SET T, ORDER_INCLUDE OI, ORDER O 
WHERE T.SID = OI.SID AND O.OID = OI.OID AND 
        SID IN Needed AND Date>= 01/05/2023 AND Date <= 31/05/2023 
GROUP BY Category;