WITH Needed AS (
    SELECT I.CID 
    FROM STUDENT S, INTERNSHIP I
    WHERE I.TaxID = S.TaxID AND S.Nationality <> 'Italian'
    GROUP BY I.CID 
    HAVING COUNT(DISTINCT ProjNo) > 9
)
SELECT P.Description, COUNT(*) AS NoActive,SUM(EndDate - StartDate), MAX(Age), MIN(Age), COUNT(DISTINCT Nationality)
FROM INTERNSHIP I, STUDENT S, PROJECT P
WHERE EndDate IS NOT NULL AND I.CID IN Needed AND I.TaxID = S.TaxID AND P.ProjNo = I.ProjNo AND P.CID = I.CID            
GROUP BY P.ProjNo, P.CID, P.Description  
        -------- Whatever in SELECT must appear in GROUP BY eventhough you don't need to group by it
        ---- Careful with dates