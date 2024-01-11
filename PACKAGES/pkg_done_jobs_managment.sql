CREATE OR REPLACE PACKAGE pkg_done_jobs_managment IS

PROCEDURE p_copy_data_to_jobs_done (in_id_job jobs.id_job%TYPE);

END pkg_done_jobs_managment;
/
CREATE OR REPLACE PACKAGE BODY pkg_done_jobs_managment IS 

PROCEDURE p_copy_data_to_jobs_done (in_id_job jobs.id_job%TYPE)
    IS
BEGIN
   INSERT INTO done_jobs ( SELECT id_job, id_principal, agreed_amount, predicted_beginning, predicted_ending, job_begin
            , job_end, job_description, status FROM jobs WHERE id_job = in_id_job);
EXCEPTION 
WHEN OTHERS THEN  pkg_errors_managment.p_add_error(SQLCODE,SQLERRM, DBMS_UTILITY.format_call_stack);
    DBMS_OUTPUT.PUT_LINE('Something wrong happend, necessary data is added to table with errors');
END p_copy_data_to_jobs_done;

END pkg_done_jobs_managment; 