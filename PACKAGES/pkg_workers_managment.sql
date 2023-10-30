CREATE OR REPLACE PACKAGE employees_managment IS 
PROCEDURE add_employee(  in_first_name employees.first_name%TYPE
                        ,in_last_name employees.last_name%TYPE
                        ,in_driving_licence employees.driving_licence%TYPE
                        ,in_hire_dare employees.hire_date%TYPE
                        ,in_hour_wage employees.hour_wage%TYPE );
                        
PROCEDURE fire_worker(in_first_name employees.first_name%TYPE, in_last_name employees.last_name%TYPE); 
END employees_managment;
/
CREATE OR REPLACE PACKAGE BODY employees_managment IS 

PROCEDURE add_employee(  in_first_name employees.first_name%TYPE
                        ,in_last_name employees.last_name%TYPE
                        ,in_driving_licence employees.driving_licence%TYPE
                        ,in_hire_dare employees.hire_date%TYPE
                        ,in_hour_wage employees.hour_wage%TYPE )
    IS
    BEGIN 
    INSERT INTO employees (first_name, last_name, driving_licence, hire_date, hour_wage) VALUES
                        (in_first_name, in_last_name, UPPER(in_driving_licence), in_hire_dare,in_hour_wage);
    EXCEPTION 
        WHEN pkg_errors.err_wrong_driving_licence THEN DBMS_OUTPUT.PUT_LINE('Wrong driving licence information, only values "Y" and 
                                            "N" are accepted');
        WHEN pkg_errors.err_wrong_driving_licence_value THEN DBMS_OUTPUT.PUT_LINE('Driver licence value can get only "y" or "n" values');
END add_employee;

PROCEDURE fire_worker(in_first_name employees.first_name%TYPE, in_last_name employees.last_name%TYPE) 
IS
BEGIN 
DELETE FROM employees WHERE UPPER(last_name) = UPPER(in_last_name) AND UPPER(first_name) = UPPER(in_first_name);
IF SQL%ROWCOUNT = 0 THEN
   RAISE pkg_errors.err_no_rows_deleted;
END IF;
EXCEPTION 
    WHEN pkg_errors.err_no_rows_deleted THEN DBMS_OUTPUT.PUT_LINE('Wrong data, there'' no worker with those name or last name');
END fire_worker;
        


END employees_managment;