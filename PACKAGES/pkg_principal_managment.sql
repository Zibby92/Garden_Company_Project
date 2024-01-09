CREATE OR REPLACE PACKAGE pkg_principal_managment  IS
PROCEDURE add_principal (in_first_name principals.first_name%TYPE
                        ,in_last_name principals.last_name%TYPE
                        ,in_city principals.city%TYPE
                        ,in_street principals.street%TYPE
                        ,in_home_number principals.home_number%TYPE
                        ,in_phone_number  principals.phone_number%TYPE );
PROCEDURE drop_principal(in_first_name principals.first_name%TYPE, in_last_name principals.last_name%TYPE);

END pkg_principal_managment;
/

create or replace PACKAGE BODY pkg_principal_managment IS 
    err_no_rows_deleted EXCEPTION;
    PRAGMA EXCEPTION_INIT (err_no_rows_deleted, -20001);

PROCEDURE add_principal (in_first_name principals.first_name%TYPE 
                        ,in_last_name principals.last_name%TYPE
                        ,in_city principals.city%TYPE
                        ,in_street principals.street%TYPE
                        ,in_home_number principals.home_number%TYPE
                        ,in_phone_number  principals.phone_number%TYPE )
    IS
BEGIN  
        INSERT INTO principals (first_name, last_name, city, street, home_number, phone_number)
        VALUES  (in_first_name, in_last_name, in_city, in_street, in_home_number,  in_phone_number) ;
END add_principal;

PROCEDURE drop_principal(in_first_name principals.first_name%TYPE, in_last_name principals.last_name%TYPE) 
    IS 
BEGIN 
        DELETE FROM principals WHERE UPPER(first_name) = UPPER(in_first_name) AND UPPER(last_name) = UPPER(in_last_name);
        IF SQL%rowcount = 0 THEN RAISE_APPLICATION_ERROR(-20001,'No rows deleted' ); END IF;
EXCEPTION
    WHEN err_no_rows_deleted THEN pkg_errors_managment.p_add_error(SQLCODE,SQLERRM, DBMS_UTILITY.format_call_stack);
    DBMS_OUTPUT.PUT_LINE('Error occured. Check details in table');
END drop_principal;

END pkg_principal_managment;