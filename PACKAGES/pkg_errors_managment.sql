CREATE OR REPLACE PACKAGE pkg_errors_managment IS

PROCEDURE add_error(in_error_number VARCHAR2, in_error_details VARCHAR2, error_details VARCHAR2); 

END pkg_errors_managment;
/
CREATE OR REPLACE PACKAGE BODY pkg_errors_managment IS 
    
    PROCEDURE add_error(in_error_number VARCHAR2, in_error_details VARCHAR2, error_details VARCHAR2) 
        IS
    v_place_where_error_occur VARCHAR2(200);
    BEGIN 
        v_place_where_error_occur := SUBSTR(error_details,INSTR(error_details,'name')+ 5,LENGTH(error_details));
        INSERT INTO errors_details (error_number, error_message, user_name, error_details)
        VALUES (in_error_number, in_error_details, user, v_place_where_error_occur);
    END add_error;
    
    
END pkg_errors_managment;