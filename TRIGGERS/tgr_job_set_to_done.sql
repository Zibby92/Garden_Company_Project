create or replace TRIGGER job_set_to_done
AFTER 
UPDATE 
OF status ON jobs
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
v_id_job NUMBER;
BEGIN 
    v_id_job := :NEW.id_job;    
    pkg_invoices.p_generate_invoice(v_id_job);
    DBMS_OUTPUT.PUT_LINE('Created invoice to job with ID -  ' || v_id_job);
    pkg_jobs_done_statistics.p_add_data_to_statistic(v_id_job);
    DBMS_OUTPUT.PUT_LINE('Transfered data from jobs to table jobs_done_statistic'); 
COMMIT;
END job_set_to_done;