CREATE OR REPLACE PACKAGE pkg_additional_works_managment IS
PROCEDURE p_add_work  (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_work_describe additional_works.work_describe%TYPE
                     ,in_price additional_works.price%TYPE );
                     
PROCEDURE p_add_work  (in_work_id jobs.id_job%TYPE
                     ,in_work_describe additional_works.work_describe%TYPE
                     ,in_price additional_works.price%TYPE );

END pkg_additional_works_managment;
/
CREATE OR REPLACE PACKAGE BODY pkg_additional_works_managment IS

PROCEDURE p_add_work  (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_work_describe additional_works.work_describe%TYPE
                     ,in_price additional_works.price%TYPE )
                     IS
v_id_job principals.id_principal%TYPE; 
BEGIN 
    v_id_job := pkg_general_search_programs.f_find_job_id_by_name_and_last_name_of_principal
                (in_principal_name,in_principal_last_name);
    IF v_id_job IS NULL THEN RAISE NO_DATA_FOUND; END IF;
    
    INSERT INTO additional_works (id_job, work_describe, price )  
                                VALUES (v_id_job, in_work_describe, in_price );
EXCEPTION 
    WHEN NO_DATA_FOUND THEN pkg_errors_managment.p_add_error(SQLCODE,SQLERRM, DBMS_UTILITY.format_call_stack);
                        RAISE NO_DATA_FOUND;
END p_add_work;

PROCEDURE p_add_work  (in_work_id jobs.id_job%TYPE
                     ,in_work_describe additional_works.work_describe%TYPE
                     ,in_price additional_works.price%TYPE )
                     IS
BEGIN     
    INSERT INTO additional_works (id_job, work_describe, price )  
                                VALUES (in_work_id, in_work_describe, in_price );
EXCEPTION 
    WHEN NO_DATA_FOUND THEN pkg_errors_managment.p_add_error(SQLCODE,SQLERRM, DBMS_UTILITY.format_call_stack);
                      RAISE NO_DATA_FOUND;
END p_add_work;

END pkg_additional_works_managment;