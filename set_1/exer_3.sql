WITH Needed AS(
    SELECT CID 
    FROM INTERNSHIP I
    WHERE I.StarDate > 01/01/2022 AND I.EndDate < 31/12/2024 AND I.EndDate IS NOT NULL
    AND I.EndDate IS NOT NULL
    GROUP BY CID 
    HAVING AVG(I.EndDate - I.StartDate) > ( SELECT AVG(I.EndDate - I.StartDate)
                                            FROM INTERNSHIP I2
                                            WHERE I.CID = I2.CID AND I.StartDate >= 01/01/2018 AND I.EndDate <= 31/12/2020 AND I.EndDate IS NOT NULL   ---- careful with date >=
                                            GROUP BY I2.CID)
)
SELECT Description, Sector, Budget
FROM PROJECT P, INTERNSHIP I 
WHERE P.ProjNo = I.ProjNo AND P.CID = I.CID AND I.StartDate > 01/01/2018 AND I.EndDate < 31/12/2020 AND I.StarDate > 01/01/2022 AND I.EndDate < 31/12/2024
    AND I.EndDate IS NOT NULL AND P.CID IN Needed
GROUP BY P.ProjectNo, P.CID, Description, Sector, Budget;