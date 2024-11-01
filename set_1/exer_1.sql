WITH Needed AS(
    SELECT CID 
    FROM INTERNSHIP I1
    WHERE StartDate >= 01/01/2020 AND EndDate <= 31/12/2024 AND EndDate IS NOT NULL
    GROUP BY CID 
    HAVING SUM((EndDate-StartDate)*DailyWage) >
                                            (SELECT SUM((EndDate-StarDate)*DailyWage) 
                                            FROM INTERNSHIP I2
                                            WHERE StartDate >= 01/01/2016 AND EndDate <= 31/12/2019 AND EndDate IS NOT NULL 
                                                  AND I2.CID = I.CID
                                            GROUP BY CID)
)
SELECT Description, Sector, Budget 
FROM PROJECT P, INTERNSHIP I 
WHERE P.ProjNo = I.ProjNo AND P.CID = I.CID AND CID IN Needed AND ((StartDate >= 01/01/2020 AND EndDate <= 31/12/2024) OR 
        (StartDate >= 01/01/2016 AND EndDate <= 31/12/2019)) AND EndDate IS NOT NULL
GROUP BY P.ProjNo, P.CID, Description, Sector, Budget;