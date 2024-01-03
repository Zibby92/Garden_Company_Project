create or replace PACKAGE invoices_pkg IS

    FUNCTION generate_invoice_number(in_id_job NUMBER) RETURN VARCHAR2;
    PROCEDURE generate_invoice (in_id_job jobs.id_job%TYPE) ;

END invoices_pkg;

/
create or replace PACKAGE BODY invoices_pkg IS

    FUNCTION number_already_exists(in_number VARCHAR2) RETURN VARCHAR2 
        IS 
        v_first_invoice_part VARCHAR2(10);
        v_second_invoice_part VARCHAR2(15);
        v_final_number VARCHAR2(30);
        v_temporary_counter VARCHAR2(30);
        v_temporary_invoice_number VARCHAR2(30);
        BEGIN
          v_first_invoice_part := SUBSTR(in_number,1,INSTR(in_number, '-'));
          v_temporary_invoice_number := LTRIM(in_number,v_first_invoice_part);
          v_second_invoice_part := SUBSTR(v_temporary_invoice_number,INSTR(v_temporary_invoice_number,'-'),LENGTH(v_temporary_invoice_number));
          v_temporary_invoice_number := SUBSTR(v_temporary_invoice_number,1,INSTR(v_temporary_invoice_number,'-') -1);
          v_temporary_counter := v_temporary_invoice_number + 1;

          v_final_number := v_first_invoice_part||v_temporary_counter||v_second_invoice_part;

        RETURN v_final_number;
        END number_already_exists;

    FUNCTION generate_invoice_number(in_id_job NUMBER) RETURN VARCHAR2
    IS 
         c_invoice CONSTANT  VARCHAR2(3)  := 'INV';
         v_date VARCHAR2(20) := TO_CHAR(SYSDATE,'YYYY/MM/DD');  
         v_invoice_number NUMBER := 1;
         v_id_principal NUMBER;
         v_final_invoice_number VARCHAR2(20);
         v_check NUMBER := 1;
        BEGIN            
            SELECT id_principal INTO v_id_principal FROM jobs WHERE id_job = in_id_job;
            v_final_invoice_number := c_invoice|| '-' ||v_invoice_number || '-' ||v_id_principal  || '-' || v_date;    
            SELECT count(*) INTO v_check FROM invoices WHERE invoice_number = v_final_invoice_number;

            WHILE (v_check <> 0) 
                LOOP
                    v_final_invoice_number := number_already_exists(v_final_invoice_number);
                    SELECT count(*) INTO v_check FROM invoices WHERE invoice_number = v_final_invoice_number;
            END LOOP;
        RETURN v_final_invoice_number;
END generate_invoice_number;

PROCEDURE generate_invoice (in_id_job jobs.id_job%TYPE) 
    IS
    v_status VARCHAR2(30) := 'Oczekiwanie na zap�at�';
    v_agreed_amount jobs.agreed_amount%TYPE;
    BEGIN    
    INSERT INTO invoices (invoice_number, id_job, id_principal, agreed_amount, additional_works_amount, status)
        VALUES (generate_invoice_number(in_id_job) , in_id_job, (SELECT id_principal FROM jobs WHERE id_job = in_id_job)
              ,( SELECT agreed_amount FROM jobs WHERE id_job = in_id_job)
              ,(SELECT SUM(price) FROM additional_works WHERE id_job = in_id_job), v_status);
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE(pkg_errors.mss_err_wrong_job_id);
    END generate_invoice;


END invoices_pkg;