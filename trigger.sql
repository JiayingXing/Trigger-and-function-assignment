use synthea;
show tables;
SELECT * FROM clinical_data;
INSERT INTO clinical_data (patientUID, lastname, systolic,
diastolic) VALUES (76888, 'Jiaying', 115, 77);

##Trigger
delimiter $$
CREATE TRIGGER highsytolic BEFORE INSERT ON clinical_data FOR EACH ROW 
BEGIN 
 IF NEW.sytolic >= 110 THEN 
 SIGNAL SQLSTATE '45000' 
 SET MESSAGE_TEXT = 'ERROR: Sytolic BP MUST BE BELOW 110 mg';  
 END IF; 
END; $$

##Function 
CREATE FUNCTION totalCost(cost DECIMAL(10,2))
returns varchar(20)
DETERMINISTIC
BEGIN
DECLARE testCost VARCHAR(20);
IF cost > 300 THEN
SET testCost = ‘expensivecost’;

ELSEIF (cost >= 100 AND
credit <= 300) THEN
SET labCost = 'normal';

ELSEIF cost < 100 THEN
SET labCost = 'cheapcost';
END IF;

RETURN (labCost);
END$$
DELIMITER ;