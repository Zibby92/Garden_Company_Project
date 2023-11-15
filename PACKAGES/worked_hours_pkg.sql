CREATE OR REPLACE PACKAGE worked_hours_pkg IS
PROCEDURE all_at_one_job( in_worked_hours worked_hours.hours_per_day%TYPE
                         ,in_worked_day DATE
                         ,in_job_id jobs.id_job%TYPE);

END worked_hours_pkg;
/
CREATE OR REPLACE PACKAGE BODY worked_hours_pkg IS

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


PROCEDURE all_at_one_job( in_worked_hours worked_hours.hours_per_day%TYPE
                         ,in_worked_day DATE
                         ,in_job_id jobs.id_job%TYPE)
    IS 
    v_all_employees ntt_all_employees;
    BEGIN 
     v_all_employees:= get_all_employees_id();
    FOR i in v_all_employees.FIRST..v_all_employees.LAST
        LOOP 
           INSERT INTO worked_hours(worked_day, hours_per_day, job_id, id_employee)
                            VALUES (in_worked_day, in_worked_hours, in_job_id, v_all_employees(i) );
        END LOOP;
    
END all_at_one_job;

END;