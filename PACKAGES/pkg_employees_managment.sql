CREATE OR REPLACE PACKAGE pkg_employees_managment IS 
PROCEDURE p_add_employee(  in_first_name employees.first_name%TYPE
                        ,in_last_name employees.last_name%TYPE
                        ,in_driving_licence employees.driving_licence%TYPE
                        ,in_hire_dare employees.hire_date%TYPE
                        ,in_hour_wage employees.hour_wage%TYPE );

PROCEDURE p_fire_worker(in_first_name employees.first_name%TYPE, in_last_name employees.last_name%TYPE); 
END  pkg_employees_managment;

/

create or replace PACKAGE BODY  pkg_employees_managment IS 

PROCEDURE p_add_employee(  in_first_name employees.first_name%TYPE
                        ,in_last_name employees.last_name%TYPE
                        ,in_driving_licence employees.driving_licence%TYPE
                        ,in_hire_dare employees.hire_date%TYPE
                        ,in_hour_wage employees.hour_wage%TYPE )
    IS
BEGIN 
    INSERT INTO employees (first_name, last_name, driving_licence, hire_date, hour_wage) VALUES
                        (in_first_name, in_last_name, UPPER(in_driving_licence), in_hire_dare,in_hour_wage);
END p_add_employee;

PROCEDURE p_fire_worker(in_first_name employees.first_name%TYPE, in_last_name employees.last_name%TYPE) 
    IS
BEGIN 
    DELETE FROM employees WHERE UPPER(last_name) = UPPER(in_last_name) AND UPPER(first_name) = UPPER(in_first_name);
    IF SQL%ROWCOUNT = 0 THEN
    RAISE pkg_errors.err_no_rows_deleted;
    END IF;
EXCEPTION 
    WHEN pkg_errors.err_no_rows_deleted THEN    
    pkg_errors_managment.p_add_error(SQLCODE,SQLERRM, DBMS_UTILITY.format_call_stack);
    DBMS_OUTPUT.PUT_LINE('Wrong data, there'' no worker with those name or last name');
END p_fire_worker;

END pkg_employees_managment;