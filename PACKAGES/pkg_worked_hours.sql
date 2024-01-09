CREATE OR REPLACE PACKAGE pkg_worked_hours IS
PROCEDURE all_at_one_job( in_day_of_work DATE
                         ,in_hours_per_day worked_hours.hours_per_day%TYPE
                         ,in_id_job jobs.id_job%TYPE);

END pkg_worked_hours;
/
create or replace PACKAGE BODY pkg_worked_hours IS

TYPE ntt_all_employees IS TABLE OF employees.id_employee%TYPE;

FUNCTION get_all_employees_id RETURN ntt_all_employees IS
    v_all_employees ntt_all_employees;
    CURSOR all_id IS SELECT id_employee FROM employees;
    BEGIN 
        OPEN all_id;
        FETCH all_id BULK COLLECT INTO v_all_employees;
        CLOSE all_id;
    RETURN v_all_employees;
END get_all_employees_id;
 
 
PROCEDURE all_at_one_job( in_day_of_work DATE
                         ,in_hours_per_day worked_hours.hours_per_day%TYPE
                         ,in_id_job jobs.id_job%TYPE)
    IS 
    v_all_employees ntt_all_employees;
    BEGIN 
     v_all_employees:= get_all_employees_id();
    FOR i in v_all_employees.FIRST..v_all_employees.LAST
        LOOP 
           INSERT INTO worked_hours(day_of_work, hours_per_day, id_job, id_employee)
                            VALUES (in_day_of_work, in_hours_per_day, in_id_job, v_all_employees(i) );
        END LOOP;

END all_at_one_job;

END pkg_worked_hours;