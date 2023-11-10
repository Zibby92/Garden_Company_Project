CREATE OR REPLACE PACKAGE additional_works_managment_pkg IS
PROCEDURE add_work  (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_work_describe additional_works.work_describe%TYPE
                     ,in_price additional_works.price%TYPE );
                     
PROCEDURE add_work  (in_work_id jobs.id_job%TYPE
                     ,in_work_describe additional_works.work_describe%TYPE
                     ,in_price additional_works.price%TYPE );

END additional_works_managment_pkg;
/
CREATE OR REPLACE PACKAGE BODY additional_works_managment_pkg IS

PROCEDURE add_work  (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_work_describe additional_works.work_describe%TYPE
                     ,in_price additional_works.price%TYPE )
                     IS
v_id_job principals.id_principal%TYPE; 
BEGIN 
    v_id_job := general_search_programs.f_find_job_id_by_name_and_last_name_of_principal
                (in_principal_name,in_principal_last_name);
    IF v_id_job IS NULL THEN RAISE pkg_errors.err_wrong_principals_data; END IF;
    
    INSERT INTO additional_works (id_job, work_describe, price )  
                                VALUES (v_id_job, in_work_describe, in_price );
EXCEPTION 
    WHEN pkg_errors.err_wrong_principals_data THEN DBMS_OUTPUT.PUT_LINE(pkg_errors.mss_err_wrong_principals_data);
END add_work;

PROCEDURE add_work  (in_work_id jobs.id_job%TYPE
                     ,in_work_describe additional_works.work_describe%TYPE
                     ,in_price additional_works.price%TYPE )
                     IS
BEGIN     
    INSERT INTO additional_works (id_job, work_describe, price )  
                                VALUES (in_work_id, in_work_describe, in_price );
EXCEPTION 
    WHEN pkg_errors.err_wrong_id THEN DBMS_OUTPUT.PUT_LINE(pkg_errors.mss_err_wrong_id);
END add_work;


END additional_works_managment_pkg;