CREATE OR REPLACE PACKAGE pkg_jobs_managment IS
PROCEDURE p_add_job   (in_principal_name principals.first_name%TYPE
                    ,in_principal_last_name principals.last_name%TYPE
                    ,in_agreed_amount jobs.agreed_amount%TYPE
                    ,in_predicted_beginning jobs.predicted_beginning%TYPE
                    ,in_predicted_ending jobs.predicted_ending%TYPE
                    ,in_job_description jobs.job_description%TYPE);

PROCEDURE p_begin_job  (in_principal_name principals.first_name%TYPE
                        ,in_principal_last_name principals.last_name%TYPE
                        ,in_begin DATE);
PROCEDURE p_end_job (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_end DATE) ;
PROCEDURE p_set_job_as_done(in_principal_first_name principals.first_name%TYPE
                          , in_principal_last_name principals.last_name%TYPE, in_street jobs.street%TYPE);

                     

END pkg_jobs_managment;
/
create or replace PACKAGE BODY pkg_jobs_managment IS

err_wrong_principals_data EXCEPTION;
PRAGMA EXCEPTION_INIT (err_wrong_principals_data, -20100);

PROCEDURE p_set_job_as_done(in_principal_first_name principals.first_name%TYPE
                          , in_principal_last_name principals.last_name%TYPE, in_street jobs.street%TYPE)
    IS 
    v_status CONSTANT VARCHAR2(15) := 'Zakoñczone';
    v_table_name CONSTANT VARCHAR2(10) := 'principals';
BEGIN 
        UPDATE JOBS 
        SET status = v_status
        WHERE id_job = 
        (SELECT id_job FROM jobs j INNER JOIN principals p ON j.id_principal = p.id_principal 
        WHERE p.first_name = in_principal_first_name 
        AND p.last_name = in_principal_last_name 
        AND j.street = in_street);
       
       IF (SQL%ROWCOUNT = 0 ) THEN pkg_general_search_programs.p_find_similar_names_and_last_names_by_table( in_principal_first_name,
                                                           in_principal_last_name,v_table_name);
        ELSE DBMS_OUTPUT.PUT_LINE('You succesfully updated status');
        END IF;
       
END p_set_job_as_done; 

PROCEDURE p_add_job   (in_principal_name principals.first_name%TYPE
                    ,in_principal_last_name principals.last_name%TYPE
                    ,in_agreed_amount jobs.agreed_amount%TYPE
                    ,in_predicted_beginning jobs.predicted_beginning%TYPE
                    ,in_predicted_ending jobs.predicted_ending%TYPE
                    ,in_job_description jobs.job_description%TYPE)
    IS 
    v_principal_id NUMBER;
BEGIN  
    SELECT id_principal INTO v_principal_id  FROM principals WHERE first_name = in_principal_name AND last_name = in_principal_last_name;
    
    IF in_principal_last_name IS NULL OR 
    in_principal_name IS NULL 
    THEN RAISE_APPLICATION_ERROR(-20100,'There''s no principal whose suit to your data'); END IF;
    
    INSERT INTO jobs (id_principal, agreed_amount, predicted_beginning, predicted_ending, job_description)
            VALUES ((SELECT id_principal FROM principals WHERE first_name = in_principal_name AND last_name = in_principal_last_name),
                    in_agreed_amount, in_predicted_beginning, in_predicted_ending, in_job_description);
EXCEPTION 
    WHEN err_wrong_principals_data THEN pkg_errors_managment.p_add_error(SQLCODE,SQLERRM, DBMS_UTILITY.format_call_stack);
    DBMS_OUTPUT.PUT_LINE('Error occured. Check details in table');
    pkg_general_search_programs.p_find_similar_names_and_last_names_by_table(in_principal_name, in_principal_last_name, 'principals');
END p_add_job; 

PROCEDURE p_begin_job  (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_begin DATE) 
IS 
v_id_job principals.id_principal%TYPE; 
BEGIN 
    v_id_job := pkg_general_search_programs.f_find_job_id_by_name_and_last_name_of_principal
                (in_principal_name,in_principal_last_name);
    IF v_id_job IS NULL THEN RAISE_APPLICATION_ERROR(-20100,'There''s no principal whose suit to your data'); END IF;
    UPDATE jobs  SET job_begin = in_begin WHERE id_job = v_id_job;
EXCEPTION 
    WHEN err_wrong_principals_data THEN pkg_errors_managment.p_add_error(SQLCODE,SQLERRM, DBMS_UTILITY.format_call_stack);
    DBMS_OUTPUT.PUT_LINE('Error occured. Check details in table');
END p_begin_job;

PROCEDURE p_end_job (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_end DATE) 
IS 
v_id_job principals.id_principal%TYPE; 
BEGIN
     v_id_job := pkg_general_search_programs.f_find_job_id_by_name_and_last_name_of_principal
                (in_principal_name,in_principal_last_name);
    IF v_id_job IS NULL THEN RAISE_APPLICATION_ERROR(-20100,'There''s no principal whose suit to your data'); END IF;
    UPDATE jobs SET job_end = in_end WHERE id_job = v_id_job;
EXCEPTION 
    WHEN err_wrong_principals_data THEN pkg_errors_managment.p_add_error(SQLCODE,SQLERRM, DBMS_UTILITY.format_call_stack);
    DBMS_OUTPUT.PUT_LINE('Error occured. Check details in table');
END p_end_job;



END pkg_jobs_managment;