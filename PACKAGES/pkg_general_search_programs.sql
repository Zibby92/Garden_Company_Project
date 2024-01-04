DROP PACKAGE GENEREAL_SEARCH_PROGRAMS;
/
CREATE OR REPLACE PACKAGE general_search_programs IS
PROCEDURE find_similar_names_and_last_names_by_table(first_name VARCHAR2, last_name VARCHAR2, table_name VARCHAR2); 
FUNCTION f_find_job_id_by_name_and_last_name_of_principal   
                                                (in_principal_name principals.first_name%TYPE,
                                                in_principal_last_name principals.last_name%TYPE
                                                ) RETURN NUMBER ;
FUNCTION check_if_id_job_is_right (in_id_job jobs.id_job%TYPE) RETURN jobs.id_job%TYPE;
END general_search_programs;
/
CREATE OR REPLACE PACKAGE BODY general_search_programs IS 

FUNCTION check_if_id_job_is_right (in_id_job jobs.id_job%TYPE) RETURN jobs.id_job%TYPE
    IS
    v_check NUMBER := 0; 
BEGIN
    SELECT COUNT(*) INTO v_check FROM jobs WHERE id_job = in_id_job;
    IF (v_check <= 0) THEN RAISE NO_DATA_FOUND; END IF;
    RETURN in_id_job;
END check_if_id_job_is_right;

PROCEDURE find_similar_names_and_last_names_by_table(first_name VARCHAR2, last_name VARCHAR2, table_name VARCHAR2) 
    IS  
    TYPE first_and_last IS RECORD (first_name VARCHAR2(100), last_name VARCHAR2(100) ) ;
    TYPE array_names IS TABLE OF first_and_last;
    v_array_names array_names;
    v_condition VARCHAR2(1000):=' WHERE LOWER(first_name) LIKE LOWER(SUBSTR('''||first_name||''',1,1)) || ''%''
                                OR
                                LOWER(last_name) LIKE LOWER(SUBSTR('''||last_name||''',1,1)) || ''%''';
    BEGIN 
        EXECUTE IMMEDIATE  'SELECT first_name, last_name FROM '
        || table_name ||v_condition BULK COLLECT INTO v_array_names;
        IF SQL%ROWCOUNT = 0 THEN RAISE NO_DATA_FOUND; END IF;
        DBMS_OUTPUT.PUT_LINE('No found person with these data, maybe were you looking for one of those? ');
        DBMS_OUTPUT.PUT_LINE('Persons with similar data: ');
        FOR i IN v_array_names.FIRST..v_array_names.LAST 
            LOOP
            DBMS_OUTPUT.PUT_LINE('Name: '|| v_array_names(i).first_name || ' Last Name: ' || v_array_names(i).last_name);
        END LOOP;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Nobody match to your data');
END find_similar_names_and_last_names_by_table;

FUNCTION f_find_job_id_by_name_and_last_name_of_principal   
                                                (in_principal_name principals.first_name%TYPE,
                                                in_principal_last_name principals.last_name%TYPE
                                                ) RETURN NUMBER  
    IS 
    v_id NUMBER := NULL;
    v_job_id NUMBER := NULL;
    BEGIN
    SELECT id_principal INTO v_id FROM principals WHERE LOWER(first_name) = 
                        LOWER(in_principal_name) AND LOWER(last_name) = LOWER(in_principal_last_name);
    SELECT id_job INTO v_job_id FROM jobs WHERE id_principal = v_id;
    RETURN v_job_id;
EXCEPTION  
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('There''s no principal whose match to your data' );
                    general_search_programs.find_similar_names_and_last_names_by_table
                    (in_principal_name,in_principal_last_name,'principals');
                    RETURN NULL;
END f_find_job_id_by_name_and_last_name_of_principal; 



END general_search_programs;