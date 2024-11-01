SELECT Name, SUM(Quantity) 
FROM TOY_BUILDING_SET T, ORDER_INLCUDE OI
WHERE Category = 'Marvel'AND NumPieces >300 AND OI.SID = T.SID 
GROUP BY SID, Name 
HAVING COUNT(*) >= 50