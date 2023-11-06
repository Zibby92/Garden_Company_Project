DROP TRIGGER add_job_after_add_principal_tgr;
CREATE OR REPLACE TRIGGER add_job_after_add_principal_tgr 
AFTER INSERT 
ON principals 
FOR EACH ROW
DECLARE
BEGIN
INSERT INTO jobs (principal_id) VALUES (:NEW.id_principal);
END add_job_after_add_principal_tgr;
/
