WITH Needed AS(
    SELECT TeacherID 
    FROM TEACHER T, TEACHER_CONNECTIONS TC 
    WHERE T.TeacherID = TC.TeacherID
    GROUP BY TeacherID, Course 
    HAVING AVG(Minutes) > (SELECT AVG(Minutes)
                          FROM TEACHER_CONNECTIONS TC2, TEACHER T2 
                          WHERE T2.TeacherID = TC2.TeacherID AND
                                T.Course = T2.Course);
)
SELECT Category, COUNT(DISTINCT Format), MAX(Size)
FROM DOCUMENTS_UPLOADED_BY_TEACHER D 
WHERE TeacherID IN Needed AND NumPages > (SELECT AVG(NumPages)
                                          FROM DOCUMENTS_UPLOADED_BY_TEACHER D2 
                                          WHERE D2.Category = D.Category)
GROUP BY Category;