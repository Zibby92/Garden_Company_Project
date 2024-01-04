CREATE SEQUENCE employee_id_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 10000
  NOCYCLE;
/
CREATE TABLE employees (
    id_employee     NUMBER DEFAULT employee_id_seq.NEXTVAL CONSTRAINT employee_pk PRIMARY KEY ,
    first_name      VARCHAR2(30) NOT NULL,
    last_name       VARCHAR2(50) NOT NULL,
    driving_licence VARCHAR2(1) CHECK (driving_licence IN ('Y','y','N','n')) ,
    hire_date       DATE DEFAULT SYSDATE,
    hour_wage       NUMBER
);
/
CREATE SEQUENCE principals_id_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 10000
  NOCYCLE;
/
CREATE TABLE principals (
    id_principal  NUMBER DEFAULT principals_id_seq.NEXTVAL CONSTRAINT principals_pk PRIMARY KEY ,
    first_name    VARCHAR2(30) NOT NULL,
    last_name     VARCHAR2(50) NOT NULL,
    city          VARCHAR2(100),
    street        VARCHAR2(100),
    home_number   VARCHAR2(10),
    phone_number  NUMBER
);
/
CREATE SEQUENCE jobs_id_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 100000
  NOCYCLE;
/
CREATE TABLE jobs 
   (id_job NUMBER DEFAULT jobs_id_seq.NEXTVAL CONSTRAINT jobs_pk PRIMARY KEY , 
	id_principal NUMBER CONSTRAINT jobs_id_principal_fk REFERENCES principals(id_principal), 
    street VARCHAR2(50),
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
   (id_additional_work NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT additional_works_pk PRIMARY KEY, 
	id_job NUMBER NOT NULL ENABLE CONSTRAINT additional_works_id_job_fk REFERENCES jobs(id_job), 
	work_describe VARCHAR2(1000 BYTE), 
	price NUMBER,
    day_of_finish DATE DEFAULT SYSDATE
    );
/
 CREATE TABLE daily_costs 
   (id_daily_cost NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT daily_costs_pk PRIMARY KEY, 
	id_job NUMBER CONSTRAINT daily_costs_id_job_fk REFERENCES jobs(id_job) ON DELETE CASCADE,  
	amount_of_kilometers NUMBER, 
	unpredicted_costs NUMBER, 
	unpredicted_costs_details VARCHAR2(1000 BYTE), 
	daily_cost_date DATE
    );
/
 CREATE TABLE worked_hours 
   (id_worked_hours NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT worked_hours_pk PRIMARY KEY, 
	day_of_work DATE DEFAULT SYSDATE NOT NULL, 
	hours_per_day NUMBER DEFAULT 8, 
	id_job NUMBER CONSTRAINT worked_hours_id_job_fk REFERENCES jobs(id_job) ON DELETE CASCADE, 
	id_employee NUMBER CONSTRAINT worked_hours_id_employee_fk REFERENCES employees(id_employee) ON DELETE CASCADE
    );
/
CREATE SEQUENCE invoice_id_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 10000
  NOCYCLE;
/
CREATE TABLE invoices
    (id_invoice NUMBER DEFAULT invoice_id_seq.NEXTVAL CONSTRAINT invoices_pk PRIMARY KEY,
     invoice_number VARCHAR2 (30),
     id_job NUMBER CONSTRAINT invoices_id_job_fk REFERENCES jobs(id_job) ON DELETE CASCADE,
     id_principal NUMBER CONSTRAINT invoices_id_principal_fk REFERENCES principals(id_principal) ON DELETE CASCADE,
     agreed_amount NUMBER,
     additional_works_amount NUMBER,
     date_of_issue DATE DEFAULT SYSDATE,
     payment_maturity DATE DEFAULT SYSDATE + 60,
     status VARCHAR2(30) DEFAULT 'Oczekiwanie na zap³atê½'
     );
/
CREATE TABLE done_jobs 
   (id_done_job NUMBER  CONSTRAINT done_jobs_pk PRIMARY KEY , 
	id_principal NUMBER CONSTRAINT done_jobs_id_principal_fk REFERENCES principals(id_principal) ON DELETE SET NULL, 
	agreed_amount NUMBER, 
	predicted_beginning DATE, 
	predicted_ending DATE ,
	job_begin DATE, 
	job_end DATE,
    job_description VARCHAR2(1000),
    status VARCHAR2(30)
    );
/
CREATE SEQUENCE materials_id_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 10000
  NOCYCLE;
/
CREATE TABLE used_materials
    (id_used_material NUMBER DEFAULT materials_id_seq.NEXTVAL CONSTRAINT used_materials_pk PRIMARY KEY,
     id_job NUMBER CONSTRAINT materials_id_jobs_fk REFERENCES jobs(id_job),
     id_material VARCHAR2(100),
     material_price NUMBER, 
     material_amount VARCHAR2(500)
     );
/
CREATE TABLE materials
    (id_material NUMBER CONSTRAINT materials_pk PRIMARY KEY,
     material_name VARCHAR2(100),
     material_measure VARCHAR2(10) CHECK (material_measure IN ('szt','SZT','M2','m2','T','t'))
     );
/
CREATE TABLE jobs_done_statistics
    (id_job_done_statistic NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT jobs_done_statistics PRIMARY KEY,
     principal_first_name VARCHAR2 (30),
     principal_last_name VARCHAR2 (40),
     street VARCHAR2 (30),
     worked_hours NUMBER,
     cost_of_worked_hours NUMBER,
     material_cost NUMBER,
     number_of_additional_works NUMBER,
     cost_of_additional_works NUMBER,
     driven_kilometers NUMBER,
     agreed_amount NUMBER,
     amount_of_unpredicted_costs NUMBER,
     predicted_time_in_days NUMBER,
     final_time_in_days NUMBER
     );
     
     
     
     
     
DROP TABLE DAILY_COSTS;
DROP TABLE WORKED_HOURS;
DROP TABLE EMPLOYEES;
DROP TABLE ADDITIONAL_WORKS;
DROP TABLE INVOICES;
DROP TABLE USED_MATERIALS;
DROP tABLE JOBS;
DROP TABLE DONE_JOBS;
DROP TABLE PRINCIPALS;
DROP TABLE MATERIALS;
DROP TABLE JOBS_DONE_STATISTICS;

DROP SEQUENCE employee_id_seq;
DROP SEQUENCE principals_id_seq;
DROP SEQUENCE jobs_id_seq;
DROP SEQUENCE invoice_id_seq;
DROP SEQUENCE materials_id_seq;

