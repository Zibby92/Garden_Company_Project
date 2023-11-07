DROP PACKAGE GENEREAL_SEARCH_PROGRAMS;
/
CREATE OR REPLACE PACKAGE general_search_programs IS
PROCEDURE find_similar_names_and_last_names_with_table(first_name VARCHAR2, last_name VARCHAR2, table_name VARCHAR2); 
END general_search_programs;
/
CREATE OR REPLACE PACKAGE BODY general_search_programs IS 

PROCEDURE find_similar_names_and_last_names_with_table(first_name VARCHAR2, last_name VARCHAR2, table_name VARCHAR2) 
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
        DBMS_OUTPUT.PUT_LINE('No found person with these data, maybe you were looking for one of those? ');
        DBMS_OUTPUT.PUT_LINE('Persons with similar data: ');
        FOR i IN v_array_names.FIRST..v_array_names.LAST 
            LOOP
            DBMS_OUTPUT.PUT_LINE('Name: '|| v_array_names(i).first_name || ' Last Name: ' || v_array_names(i).last_name);
        END LOOP;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Nobody match to your data');
END find_similar_names_and_last_names_with_table;


END general_search_programs;