CREATE DATABASE PROCEDURES;

USE PROCEDURES;

CREATE TABLE Workers1 (
    Worker_Id INT ,
    FirstName CHAR(25),
    LastName CHAR(25),
    Salary INT(15),
    JoiningDate DATETIME,
    Department CHAR(25)
);


INSERT INTO WORKERS1 VALUES(1,'MIYAN','THUFAIL',45000,'2023-01-03','BDM'),
    (2,'FATHIMA','SHANA',28000,'2022-02-23','SALES'),
    (3,'SANA','FATHIMA',29500,'2023-12-27','HR'),
    (4,'NANDANA','RAJAN',45000,'2020-02-01','MANAGER'),
    (5,'AJAY','CHADRAN',45000,'2021-06-07','MARKETING');
INSERT INTO WORKERS1 VALUES(7,'MIYA','GEORGE',35000,'2021-01-03','BDM'),
    (8,'FATHIMA','SHANZA',38000,'2012-02-23','SALES'),
    (9,'SANA','NASAR',39500,'2023-12-27','SALES'),
    (10,'NANDAN','KRISHNA',55000,'2020-02-01','SALES'),
    (5,'VIJAY','BABU',25000,'2021-06-07','MARKETING');
## Create a stored procedure that takes in IN parameters for all the columns in the Worker table and adds a new record to the table and then invokes the procedure call.

DELIMITER $$
 
 CREATE PROCEDURE AddWorker2(
    IN p_Worker_Id INT,
    IN p_FirstName CHAR(25),
    IN p_LastName CHAR(25),
    IN p_Salary INT,
    IN p_JoiningDate DATETIME,
    IN p_Department CHAR(25)
)
BEGIN  
  INSERT INTO WORKERS1 (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
    VALUES (p_Worker_Id, p_FirstName, P_LastName , p_Salary, p_JoiningDate, p_Department);
END $$

DELIMITER ;

## PROCEDURE CALL
CALL  AddWorker2(6,'SIDHARTH','ABIMANYU',70000,'2020-01-03','SENIOR MANAGER');
SELECT *FROM WORKERS1;

## Write stored procedure takes in an IN parameter for WORKER_ID and an OUT parameter for SALARY. It should retrieve the salary of the worker with the given ID and returns it in the p_salary parameter. Then make the procedure call.

DELIMITER $$

CREATE PROCEDURE GETWORKERSALARY (
IN p_Worker_Id INT,
OUT p_Salary INT )
BEGIN
    SELECT SALARY INTO p_Salary FROM Workers1 WHERE Worker_Id= p_Worker_Id;
END $$

DELIMITER ;

## PROCEDURE CALL
CALL  GETWORKERSALARY(6,@p_Salary);
SELECT @p_Salary;


##  Create a stored procedure that takes in IN parameters for WORKER_ID and DEPARTMENT. It should update the department of the worker with the given ID. Then make a procedure call.

DELIMITER $$

CREATE PROCEDURE UpdateDepartment(
      IN p_Worker_Id INT ,
      IN p_Department CHAR(25) )
BEGIN 
      UPDATE Workers1
       SET DEPARTMENT = p_Department 
       WHERE   Worker_Id = p_Worker_Id ;
END $$

DELIMITER ;

# PROCEDURE CALL
CALL UpdateDepartment(1, 'IT');       
SELECT * FROM Workers1;

## Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_workerCount. It should retrieve the number of workers in the given department and returns it in the p_workerCount parameter. Make procedure call.

DELIMITER $$
CREATE PROCEDURE WORKERCOUNT (
 IN p_Department CHAR(25),
 OUT p_WorkerCount INT )
 BEGIN 
     SELECT COUNT(*) INTO  p_WorkerCount FROM workers1 WHERE DEPARTMENT = p_Department;
 END $$
 DELIMITER ;

# PROCEDURE CALL
CALL WORKERCOUNT('SALES', @p_WorkerCount);
SELECT @p_workerCount;


## Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_avgSalary. It should retrieve the average salary of all workers in the given department and returns it in the p_avgSalary parameter and call the procedure.

DELIMITER $$

CREATE PROCEDURE AverageSalary (
IN  p_Department CHAR(25),
OUT  p_avgSalary DECIMAL(10,2)
)

BEGIN
     SELECT AVG(SALARY) INTO p_avgSalary FROM WORKERS1
     WHERE DEPARTMENT =  p_Department;
END $$

DELIMITER ;

# PROCEDURE CALL
CALL AverageSalary('SALES',@p_avgSalary);
 SELECT  @p_avgSalary;
     
drop database procedures;