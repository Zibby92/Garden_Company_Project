create or replace PACKAGE pkg_errors IS
--employees managment exeptions
err_wrong_driving_licence EXCEPTION;
PRAGMA EXCEPTION_INIT (err_wrong_driving_licence, -12899);
err_wrong_driving_licence_value EXCEPTION;
PRAGMA EXCEPTION_INIT (err_wrong_driving_licence_value, -02290 );
err_no_rows_deleted EXCEPTION;
PRAGMA EXCEPTION_INIT (err_no_rows_deleted, -20001);

END;