SELECT * FROM JOBS;
DELETE FROM JOBS WHERE ID_JOB = 23;
SELECT * FROM principals;
SELECT * FROM ADDITIONAL_WORKS;
DELETE FROM PRINCIPALS WHERE ID_PRINCIPAL = 43;
EXECUTE jobs_managment_pkg.p_add_job('jakub', 'mi造', 20000, TO_DATE('01/01/2023','DD/MM/YYYY'),TO_DATE('01/06/2023','DD/MM/YYYY'));
EXECUTE jobs_managment_pkg.p_begin_job('jakub', 'mi造',TO_DATE('01/01/2023','DD/MM/YYYY'));
EXECUTE jobs_managment_pkg.p_end_job('jakub', 'mi造',TO_DATE('01/06/2023','DD/MM/YYYY'));
/
ALTER TABLE jobs DROP column is_done;
EXECUTE principal_managment.add_principal('jakub', 'mi造','pogorzel','minska', 51,123123);
EXECUTE  additional_works_managment_pkg.add_work(42,'20 workow ziemi', 100);
set serveroutput on;
