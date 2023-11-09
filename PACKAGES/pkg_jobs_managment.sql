create or replace PACKAGE jobs_managment_pkg IS
PROCEDURE p_add_job   (in_principal_name principals.first_name%TYPE,
                    in_principal_last_name principals.last_name%TYPE,
                    in_predicted_amount jobs.predicted_amount%TYPE,
                    in_predicted_beginning jobs.predicted_beginning%TYPE,
                    in_predicted_ending jobs.predicted_ending%TYPE );

PROCEDURE begin_job  (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_begin DATE);

END jobs_managment_pkg; 
/
create or replace PACKAGE BODY jobs_managment_pkg IS

FUNCTION f_find_job_id_by_name_and_last_name   (in_principal_name principals.first_name%TYPE,
                                        in_principal_last_name principals.last_name%TYPE) RETURN NUMBER  IS 
    v_table_name VARCHAR2(100):= 'principals';
    v_id NUMBER := NULL;
    v_job_id NUMBER := NULL;
    BEGIN
    SELECT id_principal INTO v_id FROM principals WHERE LOWER(first_name) = 
                        LOWER(in_principal_name) AND LOWER(last_name) = LOWER(in_principal_last_name);
    SELECT id_job INTO v_job_id FROM jobs WHERE id_principal = v_id;
    RETURN v_job_id;
EXCEPTION  
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('There''s no principal whose suit to your data' );
                    general_search_programs.find_similar_names_and_last_names_with_table
                    (in_principal_name,in_principal_last_name,v_table_name);
                    RETURN NULL;
END f_find_job_id_by_name_and_last_name; 


PROCEDURE p_add_job   (in_principal_name principals.first_name%TYPE,
                    in_principal_last_name principals.last_name%TYPE,
                    in_predicted_amount jobs.predicted_amount%TYPE,
                    in_predicted_beginning jobs.predicted_beginning%TYPE,
                    in_predicted_ending jobs.predicted_ending%TYPE )
IS 
v_id_job jobs.id_job%TYPE; 
BEGIN  
    v_id_job := f_find_job_id_by_name_and_last_name(in_principal_name,in_principal_last_name);
    IF in_principal_last_name IS NULL THEN RAISE pkg_errors.err_wrong_principals_data; END IF;
    UPDATE jobs SET predicted_amount = in_predicted_amount
                    ,predicted_beginning = in_predicted_beginning
                    ,predicted_ending = in_predicted_ending
                WHERE id_job = v_id_job ;
EXCEPTION 
    WHEN pkg_errors.err_wrong_principals_data THEN DBMS_OUTPUT.PUT_LINE (pkg_errors.mss_err_wrong_principals_data);
END p_add_job; 

PROCEDURE begin_job  (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_begin DATE) 
IS 
v_id_job principals.id_principal%TYPE; 
BEGIN 
    v_id_job := f_find_job_id_by_name_and_last_name(in_principal_name,in_principal_last_name);
    IF v_id_job IS NULL THEN RAISE pkg_errors.err_wrong_principals_data; END IF;
    UPDATE jobs  SET job_begin = in_begin WHERE id_job = v_id_job;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
EXCEPTION 
    WHEN pkg_errors.err_wrong_principals_data THEN DBMS_OUTPUT.PUT_LINE(pkg_errors.mss_err_wrong_principals_data);
END begin_job;
END jobs_managment_pkg;