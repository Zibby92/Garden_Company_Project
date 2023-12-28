CREATE TABLE employees (
    id_employee     NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT employee_pk PRIMARY KEY ,
    first_name      VARCHAR2(30) NOT NULL,
    last_name       VARCHAR2(50) NOT NULL,
    driving_licence VARCHAR2(1) CHECK (driving_licence IN ('Y','y','N','n')) ,
    hire_date       DATE DEFAULT SYSDATE,
    hour_wage       NUMBER
);

CREATE TABLE principals (
    id_principal NUMBER GENERATED ALWAYS AS IDENTITY  CONSTRAINT principals_pk PRIMARY KEY ,
    first_name    VARCHAR2(30) NOT NULL,
    last_name     VARCHAR2(50) NOT NULL,
    city          VARCHAR2(100),
    street        VARCHAR2(100),
    home_number   NUMBER,
    phone_number  NUMBER
);

CREATE TABLE jobs 
   (id_job NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT id_jobs_pk PRIMARY KEY , 
	id_principal NUMBER CONSTRAINT jobs_id_principal_fk REFERENCES principals(id_principal) ON DELETE SET NULL, 
	agreed_amount NUMBER, 
	predicted_beginning DATE, 
	predicted_ending DATE ,
	job_begin DATE, 
	job_end DATE,
    job_description VARCHAR2(1000),
    status VARCHAR2(30) DEFAULT 'Nie rozpoczêta'
    );
    /
CREATE TABLE additional_works 
   (id_additional_work NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT id_additional_works_pk PRIMARY KEY, 
	id_job NUMBER NOT NULL ENABLE CONSTRAINT additional_works_id_job_fk REFERENCES jobs(id_job), 
	work_describe VARCHAR2(1000 BYTE), 
	price NUMBER,
    day_of_finish DATE
    );
/
 CREATE TABLE daily_costs 
   (id_daily_cost NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT daily_costs_pk PRIMARY KEY, 
	id_job NUMBER CONSTRAINT daily_costs_id_job_fk REFERENCES jobs(id_job) ON DELETE CASCADE, 
	material_cost NUMBER, 
	amount_of_kilometers NUMBER, 
	unpredicted_costs NUMBER, 
	unpredicted_costs_details VARCHAR2(1000 BYTE), 
	daily_cost_date DATE
    );
/
 CREATE TABLE worked_hours 
   (id_worked_hours NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT worked_hours_pk PRIMARY KEY, 
	worked_day DATE DEFAULT SYSDATE NOT NULL, 
	hours_per_day NUMBER DEFAULT 8, 
	job_id NUMBER CONSTRAINT worked_hours_id_job_fk REFERENCES jobs(id_job) ON DELETE CASCADE, 
	id_employee NUMBER CONSTRAINT worked_hours_id_employee_fk REFERENCES jobs(id_job) ON DELETE CASCADE
    );
/
CREATE TABLE invoices
    (id_ivoice NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT id_invoice_pk PRIMARY KEY,
     invoice_number VARCHAR (15),
     id_job NUMBER CONSTRAINT invoices_id_job_fk REFERENCES jobs(id_job) ON DELETE CASCADE,
     id_principal NUMBER CONSTRAINT invoices_id_principal_fk REFERENCES principals(id_principal) ON DELETE CASCADE,
     id_agreed_amount NUMBER,
     additional_works_amount NUMBER,
     date_of_issue DATE DEFAULT SYSDATE,
     payment_maturity DATE DEFAULT SYSDATE + 60,
     status VARCHAR2(30) DEFAULT 'Oczekiwanie na zap³atê'
     );
/

DROP TABLE EMPLOYEES;
DROP TABLE ADDITIONAL_WORKS;
DROP TABLE DAILY_COSTS;
DROP TABLE WORKED_HOURS;
DROP TABLE INVOICES;
DROP tABLE JOBS;
DROP TABLE PRINCIPALS;
