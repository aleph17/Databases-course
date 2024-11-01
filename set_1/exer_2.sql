WITH Needed AS(
    SELECT CID 
    FROM Internship
    WHERE EndDate IS NULL
    GROUP BY CID 
    HAVING COUNT(*) >9
)
SELECT Description, COUNT(*), AVG(Age), COUNT(DISTINCT Nationality)
FROM PROJECT P, INTERNSHIP I, STUDENT S 
WHERE P.ProjNo = I.ProjNo AND I.CID = P.CID AND S.TaxID = I.TaxID AND P.Budget < 5000 AND CID IN Needed 
GROUP BY P.ProjNo, P.CID, Description 