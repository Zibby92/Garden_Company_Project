create or replace PACKAGE pkg_errors IS
--employees managment exeptions
err_wrong_driving_licence EXCEPTION;
PRAGMA EXCEPTION_INIT (err_wrong_driving_licence, -12899);
err_wrong_driving_licence_value EXCEPTION;
PRAGMA EXCEPTION_INIT (err_wrong_driving_licence_value, -02290 );
err_no_rows_deleted EXCEPTION;
PRAGMA EXCEPTION_INIT (err_no_rows_deleted, -20001);

--principals managment_exeptions
err_wrong_principals_data EXCEPTION;
PRAGMA EXCEPTION_INIT (err_wrong_principals_data, -20100);
mss_err_wrong_principals_data VARCHAR2(100) := 'There''s no principal whose suit to your data'; 
END;
