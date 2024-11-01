SELECT Name, Surname, Date 
FROM PLAYER P, MATCH M, GOAL G 
WHERE P.CodP = G.CodP AND M.CodM = G.CodM AND Nation = 'Paraguay'
    AND Date = (SELECT MIN(Date)
                FROM GOAL G2, MATCH M2
                WHERE G2.CodM = M2.CodM AND G2.CodP = G.CodP);

SELECT Name, Surname, MIN(Date) 
FROM PLAYER P, MATCH M, GOAL G 
WHERE P.CodP = G.CodP AND M.CodM = G.CodM AND Nation = 'Paraguay'
GROUP BY CodP, Name, Surname;
