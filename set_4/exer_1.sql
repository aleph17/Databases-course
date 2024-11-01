WITH Needed AS(
    SELECT CodM 
    FROM PLAYER P, YELLOW_CARDS Y
    WHERE P.CodP = Y.CodP AND P.Role = 'Striker' 
    GROUP BY CodM
    HAVING COUNT(*) > 3;
)
SELECT CodM, Date, COUNT(*)
FROM MATCH M, GOAL G 
WHERE M.CodM = G.CodM AND CodM NOT IN Needed
GROUP BY CodM, Date, CodP;