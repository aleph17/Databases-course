-- consider the case of not present in license_purchased and notification

CREATE TRIGGER Manage_purchases
AFTER INSERT ON SOFTWARE_PURCHASE_REQUEST
FOR EACH ROW 
DECLARE 
varComp VARCHAR(15);
varSoft VARCHAR(15);
cost NUMBER;
noPurchased NUMBER;
BEGIN
SELECT IdC, IdSW INTO varComp, varSoft
FROM LICENSES_PURCHASED
WHERE IdC = :NEW.IdC AND IdSW = :NEW.IdSW;

SELECT CostPerLicense INTO cost 
FROM SOFTWARE 
WHERE :NEW.IdSW = IdSW;

IF (varComp IS NULL and varSoft IS NULL)THEN --- not yet entered

INSERT INTO LICENSES_PURCHASED 
VALUES(varComp, varSoft, :NEW.NoRequestedLicenses);

INSERT INTO SOFTWARE_PURCHASE_NOTIFICATION 
VALUES(:NEW.IdR,varComp, varSoft, :NEW.NoRequestedLicenses, 
        cost*(:NEW.NoRequestedLicenses), :NEW.NoRequestedLicenses);

ELSE  --- exists entry
SELECT MAX(NoPurchasedLicenses) INTO noPurchased
FROM SOFTWARE_PURCHASE_NOTIFICATION
WHERE IdC = :NEW.IdC AND IdSW = :NEW.IdSW;

UPDATE LICENSE_PURCHASED
SET NoPurchasedLicenses = NoPurchasedLicenses + :NEW.NoRequestedLicenses
WHERE IdC = :NEW.IdC AND IdSW = :NEW.IdSW;
INSERT INTO SOFTWARE_PURCHASE_NOTIFICATION 
VALUES(:NEW.IdR,varComp, varSoft, :NEW.NoRequestedLicenses, 
        cost*(:NEW.NoRequestedLicenses), noPurchased + :NEW.NoRequestedLicenses);
END IF;
END;