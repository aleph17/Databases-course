WITH Needed AS(  
    SELECT Province, City, SUM(NoAudience) CityNo
    FROM AUDIENCE A, SONG S, Location L1
    WHERE Date >= 01/01/2020 AND Date < 01/01/2021 AND S.MusicGenre = 'R&B'
        AND S.SID = A.SID AND L1.City = A.City
    GROUP BY Province, City;
)
SELECT Province, City 
FROM AUDIENCE A1, SONG S1, Location L
WHERE Date >= 01/01/2020 AND Date < 01/01/2021 AND S1.MusicGenre = 'R&B'
        AND S1.SID = A1.SID AND A1.City = L.City
GROUP BY Province,City
HAVING SUM(NoAudience) >= (SELECT AVG(CityNo)
                           FROM Needed N
                           WHERE N.Province = L.Province);