WITH Needed AS(
    SELECT SubmitDate AS Date, CID, COUNT(*) AS NoMessages 
    FROM MESSAGE
    GROUP BY SubmitDate, CID;
)
SELECT SubmitDate, Name, Surname, Title 
FROM USER U, CHAT C, MESSAGE M 
WHERE U.UID = C.UIAdmin AND M.CID = C.CID 
GROUP BY M.SubmitDate, CID, Name, Surname, Title
HAVING COUNT(*) >= (SELECT AVG(NoMessages)
                    FROM Needed
                    WHERE Needed.Date = M.SubmitDate);