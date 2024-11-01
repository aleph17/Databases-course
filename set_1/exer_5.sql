CREATE TRIGGER MANAGE_Booking
AFTER INSERT ON BOOKING
FOR EACH ROW 
DECLARE                                          ------------ DECLARE not DEFINE
plateNum VARCHAR(15);
cost NUMBER;                                          ----------------not INT  but NUMBER
BEGIN
WITH Available AS(
    SELECT LicensePlate, CostPerDay
    FROM VEHICLE V, VEHICLE_AVAILABILITY VA 
    WHERE V.LicensePlate = VA.LicensePlate AND :NEW.Category = V.Category AND :NEW.NoSeat = V.NoSeats AND Date>=:NEW.StartDate AND Date<=:NEW.EndDate
            AND Status = 1
    GROUP BY LicensePlate, CostPerDay
    HAVING COUNT(*)= :NEW.StartDate - :NEW.EndDate+1
)
SELECT LicensePlate, CostPerDay INTO plateNum, cost
FROM Available A1
WHERE CostPerDay = (SELECT MIN(CostPerDay)
                    FROM Available A2)
IF (plateNum IS NULL) THEN                          --------------------  IF (______) THEN
RAISE_APPLICATION_ERROR(-20500, 'not found');
ELSE
UPDATE VEHICLE_AVAILABILITY
SET Status = 0
WHERE Date>= :NEW.StarDate AND Date <= :NEW.EndDate AND LicensePlate = plateNum;

UPDATE VEHICLE
SET NumRentals = NumRentals + 1
WHERE LicensePlate = plateNum;                     ---------------------  after every complete action put    ;

INSERT INTO NOTIFICATION
VALUES(:NEW.TaxID, :NEW.StartDate, plateNum, (:New.EndDate - :NEW.StartDate+1)*cost);
END IF;
END;
   --------------- child attributes are merged as optional
