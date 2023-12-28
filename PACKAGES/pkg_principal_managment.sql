create or replace PACKAGE BODY jobs_managment_pkg IS


PROCEDURE p_add_job   (in_principal_name principals.first_name%TYPE,
                    in_principal_last_name principals.last_name%TYPE,
                    in_agreed_amount jobs.agreed_amount%TYPE,
                    in_predicted_beginning jobs.predicted_beginning%TYPE,
                    in_predicted_ending jobs.predicted_ending%TYPE )
IS 
v_principal_id NUMBER;
BEGIN  
    SELECT id_principal INTO v_principal_id  FROM principals WHERE first_name = in_principal_name AND last_name = in_principal_last_name;
    
    IF in_principal_last_name IS NULL OR 
    in_principal_name IS NULL 
    THEN RAISE pkg_errors.err_wrong_principals_data; END IF;
    
    INSERT INTO jobs (id_principal, agreed_amount, predicted_beginning, predicted_ending)
            VALUES ((SELECT id_principal FROM principals WHERE first_name = in_principal_name AND last_name = in_principal_last_name),
                    in_agreed_amount, in_predicted_beginning, in_predicted_ending);
EXCEPTION 
    WHEN NO_DATA_FOUND OR pkg_errors.err_wrong_principals_data 
        THEN DBMS_OUTPUT.PUT_LINE (pkg_errors.mss_err_wrong_principals_data);
        general_search_programs.find_similar_names_and_last_names_by_table(in_principal_name, in_principal_last_name, 'principals');
END p_add_job; 

PROCEDURE p_begin_job  (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_begin DATE) 
IS 
v_id_job principals.id_principal%TYPE; 
BEGIN 
    v_id_job := general_search_programs.f_find_job_id_by_name_and_last_name_of_principal
                (in_principal_name,in_principal_last_name);
    IF v_id_job IS NULL THEN RAISE pkg_errors.err_wrong_principals_data; END IF;
    UPDATE jobs  SET job_begin = in_begin WHERE id_job = v_id_job;
EXCEPTION 
    WHEN pkg_errors.err_wrong_principals_data THEN DBMS_OUTPUT.PUT_LINE(pkg_errors.mss_err_wrong_principals_data);
END p_begin_job;

PROCEDURE p_end_job (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_end DATE) 
IS 
v_id_job principals.id_principal%TYPE; 
BEGIN
     v_id_job := general_search_programs.f_find_job_id_by_name_and_last_name_of_principal
                (in_principal_name,in_principal_last_name);
    IF v_id_job IS NULL THEN RAISE pkg_errors.err_wrong_principals_data; END IF;
    UPDATE jobs SET job_end = in_end WHERE id_job = v_id_job;
EXCEPTION 
    WHEN pkg_errors.err_wrong_principals_data THEN DBMS_OUTPUT.PUT_LINE(pkg_errors.mss_err_wrong_principals_data);
END p_end_job;



END jobs_managment_pkg;