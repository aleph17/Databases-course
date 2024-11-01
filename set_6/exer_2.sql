WITH Needed AS(
    SELECT CID, Title, MAX(SizeKB) AS MaxAudio
    FROM MESSAGE M1, CHAT C1, USER U 
    WHERE M1.CID = C1.CID AND U.UID = C1.UIAdmin AND 
        C1.CreationDate >= 01/01/2023 AND C1.CreationDate < 01/01/2024 
        AND U.BirthDate < 01/01/1990 AND M.Type = 'Audio' 
    GROUP BY CID, Title;
)
SELECT Title, MaxAudio
FROM Needed
WHERE CID NOT IN (SELECT CID
                  FROM CHAT C, MESSAGE M 
                  WHERE C.CID = M.CID AND Type = 'Image');