CREATE OR REPLACE PACKAGE jobs_managment_pkg IS
FUNCTION f_find_by_name_and_last_name   (in_principal_name principals.first_name%TYPE,
                                        in_principal_last_name principals.last_name%TYPE) RETURN NUMBER;

END jobs_managment_pkg;
/
CREATE OR REPLACE PACKAGE BODY jobs_managment_pkg IS

FUNCTION f_find_by_name_and_last_name   (in_principal_name principals.first_name%TYPE,
                                        in_principal_last_name principals.last_name%TYPE) RETURN NUMBER  IS 
    v_table_name VARCHAR2(100):= 'principals';
    v_id NUMBER := NULL;
    BEGIN
    SELECT id_principal INTO v_id FROM principals WHERE LOWER(first_name) = 
                        LOWER(in_principal_name) AND LOWER(last_name) = LOWER(in_principal_last_name);
    RETURN v_id;
EXCEPTION  
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('There''s no principal whose suit to your data' );
                    general_search_programs.find_similar_names_and_last_names_with_table
                    (in_principal_name,in_principal_last_name,v_table_name);
                    RETURN NULL;
END f_find_by_name_and_last_name; 


PROCEDURE p_add_job   (in_principal_name principals.first_name%TYPE,
                    in_principal_last_name principals.last_name%TYPE,
                    in_predicted_amount jobs.predicted_amount%TYPE,
                    in_predicted_beginning jobs.predicted_beginning%TYPE,
                    in_predicted_ending jobs.predicted_ending%TYPE )
IS BEGIN  
    NULL;
END p_add_job; 

END;
