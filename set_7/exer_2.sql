WITH Needed AS(
    SELECT SID 
    FROM AUDIENCE A 
    WHERE Date >= 01/01/2020 AND Date < 01/01/2021
    GROUP BY SID 
    HAVING COUNT(NoAudience) > 90000;
)
SELECT Title, COUNT(DISTINCT WID), MAX(Date)
FROM SONG S, RADIO_PROGRAMMING P 
WHERE S.SID IN Needed AND S.SID = P.SID 
GROUP BY P.SID, Title;