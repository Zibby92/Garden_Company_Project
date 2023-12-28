CREATE OR REPLACE PACKAGE invoices_pkg IS

END invoices_pkg;
/
CREATE OR REPLACE PACKAGE BODY invoices_pkg IS

PROCEDURE generate_invoice (in_id_job jobs.id_job%TYPE, in_principal_id principals.id_principal%TYPE) 
    IS
    v_agreed_amount jobs.agreed_amount%TYPE;
    BEGIN
    SELECT agreed_amount FROM jobs WHERE id_job = in_id_job; 
    INSERT INTO invoices (invoice_number, id_job, id_principal, id_agreed_amount, additional_works_amount, status)
           VALUES ( , in_id_job, in_principal_id, ( SELECT agreed_amount FROM jobs WHERE id_job = in_id_job),
                    (SELECT SUM(price) FROM additional_work WHERE id_job = in_id_job), 'Oczekiwanie na zap³atê');
    END generate_invoice;
          

END invoices_pkg;