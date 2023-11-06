CREATE OR REPLACE PACKAGE jobs_managment_pkg IS
FUNCTION find_by_name_and_last_name   (in_principal_name principals.first_name%TYPE,
                                        in_principal_last_name principals.last_name%TYPE) RETURN NUMBER;
PROCEDURE find_similar_principal(in_principal_name principals.first_name%TYPE,
                                        in_principal_last_name principals.last_name%TYPE);

END jobs_managment_pkg;
/
CREATE OR REPLACE PACKAGE BODY jobs_managment_pkg IS

-- it's need to rethink, works invalid, overwrite results which means forget eariel foundings
PROCEDURE find_similar_principal(in_principal_name principals.first_name%TYPE,
                                        in_principal_last_name principals.last_name%TYPE) IS
TYPE first_and_last_name IS RECORD(first_name principals.first_name%TYPE, last_name principals.last_name%TYPE);
TYPE arr_first_and_last_name IS TABLE OF first_and_last_name;
v_table arr_first_and_last_name := arr_first_and_last_name();
v_contemporary_first_name VARCHAR2(100);
v_counter number(10);
BEGIN
v_counter := LENGTH(in_principal_name) - 3;
DBMS_OUTPUT.PUT_LINE(v_counter);
FOR i IN 1..v_counter
    LOOP
    DBMS_OUTPUT.PUT_LINE('PETLA ' || i );
    DBMS_OUTPUT.PUT_LINE('LICZBA POL W TABELI' || v_table.COUNT );
        v_contemporary_first_name := SUBSTR(in_principal_name, i, v_counter );
        DBMS_OUTPUT.PUT_LINE(v_contemporary_first_name);
        SELECT first_name, last_name BULK COLLECT INTO v_table FROM principals 
        WHERE LOWER(first_name) LIKE '%'||v_contemporary_first_name||'%'
        OR LOWER(first_name) LIKE v_contemporary_first_name||'%'
        OR LOWER(first_name) LIKE '%' ||v_contemporary_first_name;
            IF SQL%ROWCOUNT > 0 THEN v_table.EXTEND;
            END IF;
        DBMS_OUTPUT.PUT_LINE('KONIEC PETLI' );
    END LOOP; 
    
    IF v_table.LAST > 0 THEN 
    FOR i IN v_table.FIRST..v_table.LAST
        LOOP
            DBMS_OUTPUT.PUT_LINE(v_table(i).first_name || '  -  ' || v_table(i).last_name);
        END LOOP;
    ELSE DBMS_OUTPUT.PUT_LINE('NIE ZNALEZIONO PODOBNYCH WYRAZEN');
    END IF;
END find_similar_principal;

FUNCTION find_by_name_and_last_name   (in_principal_name principals.first_name%TYPE,
                                        in_principal_last_name principals.last_name%TYPE) RETURN NUMBER  IS 
    v_id NUMBER;
    BEGIN
    SELECT id_principal INTO v_id FROM principals WHERE LOWER(first_name) = 
                        LOWER(in_principal_name) AND LOWER(last_name) = LOWER(in_principal_last_name);
    RETURN v_id;
END find_by_name_and_last_name; 


PROCEDURE add_job   (in_principal_name principals.first_name%TYPE,
                    in_principal_last_name principals.last_name%TYPE,
                    in_predicted_amount jobs.predicted_amount%TYPE,
                    in_predicted_beginning jobs.predicted_beginning%TYPE,
                    in_predicted_ending jobs.predicted_ending%TYPE )
IS BEGIN  
    NULL;
END add_job; 

END;
