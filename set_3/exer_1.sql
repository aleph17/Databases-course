WITH NeededSize AS(
    SELECT TeacherID 
    FROM MATERIAL_UPLOADED_BY_TEACHER M 
    WHERE Size < 10;
)
NeededType AS(
    SELECT TeacherID 
    FROM MATERIAL_UPLOADED_BY_TEACHER M 
    WHERE Category <> 'Exercises'
)                                     ----------- you can use OR in WHERE too
SELECT Name, Surname 
FROM TEACHER T  
WHERE T.Course = 'Analysis I'AND T.TeacherID NOT IN Needed AND T.TeacherID NOT IN NeededType;