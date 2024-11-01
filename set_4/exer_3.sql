SELECT Name, Surname, Nation 
FROM PLAYER P, GOAL G 
WHERE G.CodP = P.CodP AND MinutesIntoTheMatch > 10
GROUP BY P.CodP, Name, Surname, Nation 
HAVING 5*COUNT(DISTINCT CodM)>= 
                  (SELECT COUNT(DISTINCT CodM)
                   FROM GOAL G2, MATCH M
                   WHERE G2.CodP = G.CodP
                        G2.CodM = M.CodM AND M.Date >= 01/01/2020 AND M.Date < 01/01/2021);