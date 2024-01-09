create or replace PACKAGE principal_managment  IS
PROCEDURE add_principal (in_first_name principals.first_name%TYPE
                        ,in_last_name principals.last_name%TYPE
                        ,in_city principals.city%TYPE
                        ,in_street principals.street%TYPE
                        ,in_home_number principals.home_number%TYPE
                        ,in_phone_number  principals.phone_number%TYPE );
PROCEDURE drop_principal(in_first_name principals.first_name%TYPE, in_last_name principals.last_name%TYPE);

END principal_managment;
/

create or replace PACKAGE BODY                "PRINCIPAL_MANAGMENT" IS 

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
        IF SQL%rowcount = 0 THEN RAISE pkg_errors.err_no_rows_deleted; END IF;
EXCEPTION
        WHEN pkg_errors.err_no_rows_deleted THEN DBMS_OUTPUT.PUT_LINE('There''s no record which match to you''re data input');
END drop_principal;

END principal_managment;