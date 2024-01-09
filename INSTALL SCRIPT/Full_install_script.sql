--CREATING NECESSERY SEQUENCES AND TABLES
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
/
CREATE TABLE errors_details
    (id_error NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     occur_time TIMESTAMP DEFAULT SYSTIMESTAMP,
     error_number VARCHAR2(30),
     error_message VARCHAR2 (300),
     error_details VARCHAR2 (500),
     user_name VARCHAR2(30)
     );
/
--POPULING THE TABLES WITH SAMPLE DATA
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Jakub', 'Kuœmiñski','N', DATE'23-10-01',25);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Micha³', 'Kowalczyk','N', DATE'22-10-01',30);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Zofia', 'Adak','N', DATE'21-10-01',30);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Kornel', 'Brzeziñski','N', DATE'20-10-01',35);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Jerzy', 'Zduñski','Y', DATE'23-01-01',20);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Dominik', 'Twaim','N', DATE'22-06-01',20);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Micha³', 'Opozda','Y', DATE'23-02-01',33);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Marek', 'Eleñski','N', DATE'20-12-01',31);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Robert', 'Nadaremno','N', DATE'23-12-01',40);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Szczepan', 'Bocian','Y', DATE'21-09-01',50);
  
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Konstanty', 'Tyszkiewisz', 'Warszawa', 'Woronicza', 123, 123123123);
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Jaros³aw', 'Wachad³o', 'Pruszków', 'Sienkiewicza', 1743, 99913132);
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Lech', 'Mikrus', 'O¿ary', 'Leœna', 1, 51230232);
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Arkadiusz', 'Ziobro', 'Miñsk Mazowiecki', 'Sosnowa', 123, 34123222);
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Remigiusz', 'Elwiñska', 'Toruñ', 'Ma³a', '1123A', 513140222);
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Ilona', 'Asymilewisz', 'Warszawa', 'Krótka', '43B', 514310381);
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Weronika', 'Toruñska', 'Siennica', 'D³uga', '12/12', 123444122);

INSERT INTO jobs (id_job, id_principal, street, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 1, '£opuszañska', 25000, DATE'23-10-01',DATE'23-11-10','Ogród o powierzchni 300m2, nic skomplikowanego, ³atwy dojazd');
INSERT INTO jobs (id_job, id_principal, street, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 2, 'Jagieloñska', 15000, DATE'23-11-10',DATE'23-11-30','Trawnik wraz z licznymi klombami');
INSERT INTO jobs (id_job, id_principal, street, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 3, 'Jagieloñska',5000, DATE'24-01-02',DATE'24-01-15','Niwelacja tereniu i nawo¿enie ziemi');
INSERT INTO jobs (id_job, id_principal, street, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 1, 'Traugutta', 27000, DATE'24-01-16',DATE'24-02-02','Droga z kostki prowadz¹ca do altany');
INSERT INTO jobs (id_job, id_principal, street, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 4, 'Misiewicza', 30000, DATE'23-02-03',DATE'23-02-27','Wiosenna pielêgnacja ogromnego ogrodu');

INSERT INTO invoices (id_invoice, invoice_number, id_job, id_principal, agreed_amount, additional_works_amount, date_of_issue, payment_maturity)
        VALUES ( invoice_id_seq.NEXTVAL, '1/30/01/2020', 1, 1, 2300, 300, DATE'20-01-30',DATE'20-01-30'+ 60);
INSERT INTO invoices (id_invoice, invoice_number, id_job, id_principal, agreed_amount, additional_works_amount, date_of_issue, payment_maturity, status)
        VALUES ( invoice_id_seq.NEXTVAL, '1/10/02/2020', 2, 2, 20300, 4300, DATE'20-02-10',DATE'20-02-10'+ 60,'zap³acono');      

INSERT INTO additional_works (id_job, work_describe, price, day_of_finish) VALUES (1, 'Dodatkowe 10 roslin', 200, DATE'20-01-21'); 
INSERT INTO additional_works (id_job, work_describe, price, day_of_finish) VALUES (1, '5 Worków ziemi', 100, DATE'20-01-23');
INSERT INTO additional_works (id_job, work_describe, price, day_of_finish) VALUES (2, 'Do³o¿one 5 metrów plastikowych obrze¿y', 300, DATE'20-02-02');
INSERT INTO additional_works (id_job, work_describe, price, day_of_finish) VALUES (2, '5 m2 kostki brukowej', 2000, DATE'20-02-06');
INSERT INTO additional_works (id_job, work_describe, price, day_of_finish) VALUES (2, '3 du¿e klony', 1000, DATE'20-02-07');
INSERT INTO additional_works (id_job, work_describe, price, day_of_finish) VALUES (2, 'Dodatkowy samochód ziemi na podwy¿szenie terenu', 1000, DATE'20-02-08');

INSERT INTO daily_costs (id_job, amount_of_kilometers, unpredicted_costs, unpredicted_costs_details, daily_cost_date)
        VALUES (1, 100, 40, 'tarcze do szlifierki', DATE'20-01-21');
INSERT INTO daily_costs (id_job, amount_of_kilometers, unpredicted_costs, unpredicted_costs_details, daily_cost_date)
        VALUES (1, 100, 200, 'nowa taczka', DATE'20-01-22');
INSERT INTO daily_costs (id_job, amount_of_kilometers, daily_cost_date)
        VALUES (1, 100, DATE'20-01-23');
INSERT INTO daily_costs (id_job, amount_of_kilometers, unpredicted_costs, unpredicted_costs_details, daily_cost_date)
        VALUES (1, 100, 500, 'przebita obota w samochodzie', DATE'20-01-25');
INSERT INTO daily_costs (id_job, amount_of_kilometers, daily_cost_date)
        VALUES (1, 100, DATE'20-01-26');
INSERT INTO daily_costs (id_job, amount_of_kilometers, unpredicted_costs, unpredicted_costs_details, daily_cost_date)
        VALUES (2, 38, 100, 'z³amany szpadel', DATE'20-02-01');
INSERT INTO daily_costs (id_job, amount_of_kilometers, daily_cost_date)
        VALUES (2, 38, DATE'20-02-02');
INSERT INTO daily_costs (id_job, amount_of_kilometers, unpredicted_costs, unpredicted_costs_details, daily_cost_date)
        VALUES (2, 38, 120, '2 nowe kaski', DATE'20-02-03');
INSERT INTO daily_costs (id_job, amount_of_kilometers, unpredicted_costs, unpredicted_costs_details, daily_cost_date)
        VALUES (2, 78, 1200, 'zakup zniszczonych roœlin przez jednego z pracowników', DATE'20-02-04');
INSERT INTO daily_costs (id_job, amount_of_kilometers, daily_cost_date)
        VALUES (2, 38, DATE'20-02-05');
INSERT INTO daily_costs (id_job, amount_of_kilometers, daily_cost_date)
        VALUES (2, 38, DATE'20-02-06');
        
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-21', 8, 1, 1);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-21', 8, 1, 2);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-21', 8, 1, 3);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-21', 8, 1, 4);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-21', 8, 1, 5);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-21', 8, 1, 6);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-21', 8, 1, 7);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-21', 8, 1, 8);

INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-22', 8, 1, 1);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-22', 8, 1, 3);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-22', 8, 1, 4);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-22', 8, 1, 5);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-22', 8, 1, 6);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-22', 8, 1, 7);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-22', 8, 1, 8);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-22', 8, 1, 9);

INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-23', 8, 1, 1);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-23', 8, 1, 2);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-23', 8, 1, 3);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-23', 8, 1, 6);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-23', 8, 1, 7);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-23', 8, 1, 8);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-23', 8, 1, 9);

INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-24', 8, 1, 1);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-24', 8, 1, 2);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-24', 8, 1, 3);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-24', 8, 1, 6);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-24', 8, 1, 7);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-24', 8, 1, 8);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-24', 8, 1, 9);

INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-25', 10, 1, 1);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-25', 10, 1, 2);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-25', 10, 1, 3);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-25', 10, 1, 4);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-25', 10, 1, 5);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-25', 10, 1, 6);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-25', 10, 1, 7);

INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-27', 8, 2, 1);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-27', 8, 2, 2);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-27', 8, 2, 3);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-27', 8, 2, 6);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-27', 8, 2, 7);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-27', 8, 2, 8);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-27', 8, 2, 9);

INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-28', 8, 2, 1);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-28', 8, 2, 2);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-28', 8, 2, 3);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-28', 8, 2, 6);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-28', 8, 2, 7);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-28', 8, 2, 8);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-28', 8, 2, 9);

INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-29', 7, 2, 1);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-29', 7, 2, 2);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-29', 7, 2, 3);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-29', 7, 2, 6);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-29', 7, 2, 7);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-29', 7, 2, 8);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-29', 7, 2, 9);

INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-30', 8, 2, 1);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-30', 8, 2, 2);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-30', 8, 2, 3);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-30', 8, 2, 6);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-30', 8, 2, 7);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-30', 8, 2, 8);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-01-30', 8, 2, 9);

INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-01', 10, 2, 1);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-01', 10, 2, 2);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-01', 10, 2, 3);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-01', 10, 2, 6);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-01', 10, 2, 7);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-01', 10, 2, 8);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-01', 10, 2, 9);

INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-02', 8, 2, 1);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-02', 8, 2, 2);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-02', 8, 2, 3);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-02', 8, 2, 6);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-02', 8, 2, 7);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-02', 8, 2, 8);
INSERT INTO worked_hours (day_of_work, hours_per_day, id_job, id_employee) VALUES (DATE'20-02-02', 8, 2, 9);

INSERT INTO materials(id_material, material_name, material_measure) VALUES (materials_id_seq.NEXTVAL, 'sadzonka œwierk - 60 cm', 'szt');
INSERT INTO materials(id_material, material_name, material_measure) VALUES (materials_id_seq.NEXTVAL, 'sadzonka œwierk - 100 cm', 'szt');
INSERT INTO materials(id_material, material_name, material_measure) VALUES (materials_id_seq.NEXTVAL, 'sadzonka tuja - 40 cm', 'szt');
INSERT INTO materials(id_material, material_name, material_measure) VALUES (materials_id_seq.NEXTVAL, 'sadzonka œwierk - 100 cm', 'szt');
INSERT INTO materials(id_material, material_name, material_measure) VALUES (materials_id_seq.NEXTVAL, 'agrow³óknina', 'm2');
INSERT INTO materials(id_material, material_name, material_measure) VALUES (materials_id_seq.NEXTVAL, 'siatka na krety', 'm2');
INSERT INTO materials(id_material, material_name, material_measure) VALUES (materials_id_seq.NEXTVAL, 'ziemia do iglaków', 'szt');
INSERT INTO materials(id_material, material_name, material_measure) VALUES (materials_id_seq.NEXTVAL, 'ziemia uniwersalna', 'szt');
INSERT INTO materials(id_material, material_name, material_measure) VALUES (materials_id_seq.NEXTVAL, 'ziemia na podwy¿szenie terenu', 't');
INSERT INTO materials(id_material, material_name, material_measure) VALUES (materials_id_seq.NEXTVAL, 'ziemia pod trawnik', 't');
INSERT INTO materials(id_material, material_name, material_measure) VALUES (materials_id_seq.NEXTVAL, 'trawa uniwersalna 5 kg ', 'szt');
INSERT INTO materials(id_material, material_name, material_measure) VALUES (materials_id_seq.NEXTVAL, 'trawa uniwersalna 1 kg', 'szt');

INSERT INTO used_materials (id_job, id_material, material_price, material_amount) VALUES (1, 1,5.20, 100);
INSERT INTO used_materials (id_job, id_material, material_price, material_amount) VALUES (1, 4,2.20, 50);
INSERT INTO used_materials (id_job, id_material, material_price, material_amount) VALUES (1, 2,15, 10);
INSERT INTO used_materials (id_job, id_material, material_price, material_amount) VALUES (1, 3,25.20, 1);
INSERT INTO used_materials (id_job, id_material, material_price, material_amount) VALUES (1, 11,16.20, 2);
INSERT INTO used_materials (id_job, id_material, material_price, material_amount) VALUES (1, 9,500, 1);
INSERT INTO used_materials (id_job, id_material, material_price, material_amount) VALUES (2, 1,5.20, 10);
INSERT INTO used_materials (id_job, id_material, material_price, material_amount) VALUES (2, 2,10.20, 5);
INSERT INTO used_materials (id_job, id_material, material_price, material_amount) VALUES (2, 3,23.90, 5);
INSERT INTO used_materials (id_job, id_material, material_price, material_amount) VALUES (2, 5,5, 10);
INSERT INTO used_materials (id_job, id_material, material_price, material_amount) VALUES (2, 6,7, 40);
/
--pkg_general_search_programs
/
--pkg_errors
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

--additional jobs exceptions
err_wrong_id EXCEPTION;
PRAGMA EXCEPTION_INIT(err_wrong_id,-02291);
mss_err_wrong_id VARCHAR2(200) := 'Id which You''ve introduced is wrong, correct it or insert additional job by name and
                                and last name of principal';
-- invoices exceptions
mss_err_wrong_job_id VARCHAR2(200) := 'You introduced wrong id_job, please correct it';
--jobs_done_statistics exeptions


END;
/
CREATE OR REPLACE PACKAGE general_search_programs IS
PROCEDURE find_similar_names_and_last_names_by_table(first_name VARCHAR2, last_name VARCHAR2, table_name VARCHAR2); 
FUNCTION f_find_job_id_by_name_and_last_name_of_principal   
                                                (in_principal_name principals.first_name%TYPE,
                                                in_principal_last_name principals.last_name%TYPE
                                                ) RETURN NUMBER ;
FUNCTION check_if_id_job_is_right (in_id_job jobs.id_job%TYPE) RETURN jobs.id_job%TYPE;
END general_search_programs;
/
CREATE OR REPLACE PACKAGE BODY general_search_programs IS 

FUNCTION check_if_id_job_is_right (in_id_job jobs.id_job%TYPE) RETURN jobs.id_job%TYPE
    IS
    v_check NUMBER := 0; 
BEGIN
    SELECT COUNT(*) INTO v_check FROM jobs WHERE id_job = in_id_job;
    IF (v_check <= 0) THEN RAISE NO_DATA_FOUND; END IF;
    RETURN in_id_job;
END check_if_id_job_is_right;

PROCEDURE find_similar_names_and_last_names_by_table(first_name VARCHAR2, last_name VARCHAR2, table_name VARCHAR2) 
    IS  
    TYPE first_and_last IS RECORD (first_name VARCHAR2(100), last_name VARCHAR2(100) ) ;
    TYPE array_names IS TABLE OF first_and_last;
    v_array_names array_names;
    v_condition VARCHAR2(1000):=' WHERE LOWER(first_name) LIKE LOWER(SUBSTR('''||first_name||''',1,1)) || ''%''
                                OR
                                LOWER(last_name) LIKE LOWER(SUBSTR('''||last_name||''',1,1)) || ''%''';
    BEGIN 
        EXECUTE IMMEDIATE  'SELECT first_name, last_name FROM '
        || table_name ||v_condition BULK COLLECT INTO v_array_names;
        IF SQL%ROWCOUNT = 0 THEN RAISE NO_DATA_FOUND; END IF;
        DBMS_OUTPUT.PUT_LINE('No found person with these data, maybe were you looking for one of those? ');
        DBMS_OUTPUT.PUT_LINE('Persons with similar data: ');
        FOR i IN v_array_names.FIRST..v_array_names.LAST 
            LOOP
            DBMS_OUTPUT.PUT_LINE('Name: '|| v_array_names(i).first_name || ' Last Name: ' || v_array_names(i).last_name);
        END LOOP;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Nobody match to your data');
END find_similar_names_and_last_names_by_table;

FUNCTION f_find_job_id_by_name_and_last_name_of_principal   
                                                (in_principal_name principals.first_name%TYPE,
                                                in_principal_last_name principals.last_name%TYPE
                                                ) RETURN NUMBER  
    IS 
    v_id NUMBER := NULL;
    v_job_id NUMBER := NULL;
    BEGIN
    SELECT id_principal INTO v_id FROM principals WHERE LOWER(first_name) = 
                        LOWER(in_principal_name) AND LOWER(last_name) = LOWER(in_principal_last_name);
    SELECT id_job INTO v_job_id FROM jobs WHERE id_principal = v_id;
    RETURN v_job_id;
EXCEPTION  
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('There''s no principal whose match to your data' );
                    general_search_programs.find_similar_names_and_last_names_by_table
                    (in_principal_name,in_principal_last_name,'principals');
                    RETURN NULL;
END f_find_job_id_by_name_and_last_name_of_principal; 



END general_search_programs;
/
--PKG_ADDDITIONAL_WORKS_MANAGMENT 
CREATE OR REPLACE PACKAGE additional_works_managment_pkg IS
PROCEDURE add_work  (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_work_describe additional_works.work_describe%TYPE
                     ,in_price additional_works.price%TYPE );
                     
PROCEDURE add_work  (in_work_id jobs.id_job%TYPE
                     ,in_work_describe additional_works.work_describe%TYPE
                     ,in_price additional_works.price%TYPE );

END additional_works_managment_pkg;
/
CREATE OR REPLACE PACKAGE BODY additional_works_managment_pkg IS

PROCEDURE add_work  (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_work_describe additional_works.work_describe%TYPE
                     ,in_price additional_works.price%TYPE )
                     IS
v_id_job principals.id_principal%TYPE; 
BEGIN 
    v_id_job := general_search_programs.f_find_job_id_by_name_and_last_name_of_principal
                (in_principal_name,in_principal_last_name);
    IF v_id_job IS NULL THEN RAISE pkg_errors.err_wrong_principals_data; END IF;
    
    INSERT INTO additional_works (id_job, work_describe, price )  
                                VALUES (v_id_job, in_work_describe, in_price );
EXCEPTION 
    WHEN pkg_errors.err_wrong_principals_data THEN DBMS_OUTPUT.PUT_LINE(pkg_errors.mss_err_wrong_principals_data);
END add_work;

PROCEDURE add_work  (in_work_id jobs.id_job%TYPE
                     ,in_work_describe additional_works.work_describe%TYPE
                     ,in_price additional_works.price%TYPE )
                     IS
BEGIN     
    INSERT INTO additional_works (id_job, work_describe, price )  
                                VALUES (in_work_id, in_work_describe, in_price );
EXCEPTION 
    WHEN pkg_errors.err_wrong_id THEN DBMS_OUTPUT.PUT_LINE(pkg_errors.mss_err_wrong_id);
END add_work;


END additional_works_managment_pkg;
/
--pkg_employees_managment
create or replace PACKAGE employees_managment IS 
PROCEDURE add_employee(  in_first_name employees.first_name%TYPE
                        ,in_last_name employees.last_name%TYPE
                        ,in_driving_licence employees.driving_licence%TYPE
                        ,in_hire_dare employees.hire_date%TYPE
                        ,in_hour_wage employees.hour_wage%TYPE );

PROCEDURE fire_worker(in_first_name employees.first_name%TYPE, in_last_name employees.last_name%TYPE); 
END  employees_managment;

/

create or replace PACKAGE BODY  employees_managment IS 

PROCEDURE add_employee(  in_first_name employees.first_name%TYPE
                        ,in_last_name employees.last_name%TYPE
                        ,in_driving_licence employees.driving_licence%TYPE
                        ,in_hire_dare employees.hire_date%TYPE
                        ,in_hour_wage employees.hour_wage%TYPE )
    IS
BEGIN 
    INSERT INTO employees (first_name, last_name, driving_licence, hire_date, hour_wage) VALUES
                        (in_first_name, in_last_name, UPPER(in_driving_licence), in_hire_dare,in_hour_wage);
EXCEPTION 
        WHEN pkg_errors.err_wrong_driving_licence THEN DBMS_OUTPUT.PUT_LINE('Wrong driving licence information, only values "Y" and 
                                            "N" are accepted');
        WHEN pkg_errors.err_wrong_driving_licence_value THEN DBMS_OUTPUT.PUT_LINE('Driver licence value can get only "y" or "n" values');
END add_employee;

PROCEDURE fire_worker(in_first_name employees.first_name%TYPE, in_last_name employees.last_name%TYPE) 
    IS
BEGIN 
    DELETE FROM employees WHERE UPPER(last_name) = UPPER(in_last_name) AND UPPER(first_name) = UPPER(in_first_name);
    IF SQL%ROWCOUNT = 0 THEN
    RAISE pkg_errors.err_no_rows_deleted;
    END IF;
EXCEPTION 
    WHEN pkg_errors.err_no_rows_deleted THEN DBMS_OUTPUT.PUT_LINE('Wrong data, there'' no worker with those name or last name');
END fire_worker;

END employees_managment;
/

--pkg_errors_managment
CREATE OR REPLACE PACKAGE pkg_errors_managment IS

PROCEDURE add_error(in_error_number VARCHAR2, in_error_details VARCHAR2, error_details VARCHAR2); 

END pkg_errors_managment;
/
CREATE OR REPLACE PACKAGE BODY pkg_errors_managment IS 
    
    PROCEDURE add_error(in_error_number VARCHAR2, in_error_details VARCHAR2, error_details VARCHAR2) 
        IS
    v_place_where_error_occur VARCHAR2(200);
    BEGIN 
        v_place_where_error_occur := SUBSTR(error_details,INSTR(error_details,'name')+ 5,LENGTH(error_details));
        INSERT INTO errors_details (error_number, error_message, user_name, error_details)
        VALUES (in_error_number, in_error_details, user, v_place_where_error_occur);
    END add_error;
    
    
END pkg_errors_managment;
/

--pkg_invoices
create or replace PACKAGE invoices_pkg IS

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
    v_status VARCHAR2(30) := 'Oczekiwanie na zap³atê';
    v_agreed_amount jobs.agreed_amount%TYPE;
    v_invoice_number VARCHAR2(30);
    BEGIN    
    v_invoice_number := generate_invoice_number(in_id_job);
    INSERT INTO invoices (invoice_number, id_job, id_principal, agreed_amount, additional_works_amount, status)
        VALUES (v_invoice_number , in_id_job, (SELECT id_principal FROM jobs WHERE id_job = in_id_job)
              ,( SELECT agreed_amount FROM jobs WHERE id_job = in_id_job)
              ,(SELECT SUM(price) FROM additional_works WHERE id_job = in_id_job), v_status);
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE(pkg_errors.mss_err_wrong_job_id);
    END generate_invoice;


END invoices_pkg;
/
--pkg_jobs_done_statistics
CREATE OR REPLACE PACKAGE pkg_jobs_done_statistics IS

PROCEDURE add_data_to_statistic(in_id_job jobs.id_job%TYPE);
 
END pkg_jobs_done_statistics;
/
CREATE OR REPLACE PACKAGE BODY pkg_jobs_done_statistics IS
            
    FUNCTION get_first_name(in_id_job jobs.id_job%TYPE) RETURN VARCHAR2
        IS
        v_principal_first_name principals.first_name%TYPE;
    BEGIN
        SELECT first_name INTO v_principal_first_name FROM principals p 
        INNER JOIN jobs j ON p.id_principal = j.id_principal WHERE j.id_job = in_id_job;
        RETURN v_principal_first_name;
    END get_first_name;
    
    FUNCTION get_last_name(in_id_job jobs.id_job%TYPE) RETURN VARCHAR2
        IS
        v_principal_last_name principals.last_name%TYPE;
    BEGIN
         SELECT last_name INTO v_principal_last_name FROM principals p 
        INNER JOIN jobs j ON p.id_principal = j.id_principal WHERE j.id_job = in_id_job;
        RETURN v_principal_last_name;
    END get_last_name;
    
    FUNCTION get_street(in_id_job jobs.id_job%TYPE) RETURN VARCHAR2
        IS
        v_street jobs.street%TYPE;
    BEGIN 
        SELECT street INTO v_street FROM jobs WHERE id_job = in_id_job;
        RETURN v_street;
    END get_street;

    FUNCTION get_all_worked_hours(in_id_job jobs.id_job%TYPE) RETURN NUMBER 
        IS
        v_amount_of_hours NUMBER;
    BEGIN
        SELECT SUM(hours_per_day) INTO v_amount_of_hours FROM worked_hours WHERE id_job = in_id_job;
        RETURN v_amount_of_hours;
    END get_all_worked_hours;
    
    FUNCTION get_cost_of_worked_hours(in_id_job jobs.id_job%TYPE) RETURN NUMBER 
        IS
        v_cost_of_hours NUMBER;
    BEGIN
        SELECT SUM(hours_per_day * hour_wage)INTO v_cost_of_hours FROM worked_hours w JOIN employees  e 
        ON w.id_employee = e.id_employee
        WHERE id_job = in_id_job;
        RETURN v_cost_of_hours;
    END get_cost_of_worked_hours;
    
    FUNCTION get_material_cost(in_id_job jobs.id_job%TYPE) RETURN NUMBER 
        IS
        v_material_cost NUMBER;
    BEGIN
        SELECT SUM(material_price * material_amount) INTO v_material_cost FROM used_materials WHERE id_job = in_id_job;
        RETURN v_material_cost;
    END get_material_cost;
    
    FUNCTION get_number_of_additional_works(in_id_job jobs.id_job%TYPE) RETURN NUMBER 
        IS
        v_additional_works NUMBER;
    BEGIN
        SELECT COUNT(*)INTO v_additional_works FROM additional_works WHERE id_job = in_id_job;
        RETURN v_additional_works;
    END get_number_of_additional_works;

      FUNCTION get_cost_of_additional_works(in_id_job jobs.id_job%TYPE) RETURN NUMBER 
        IS
        v_cost_of_additional_works NUMBER;
    BEGIN
        SELECT SUM(price) INTO v_cost_of_additional_works FROM additional_works WHERE id_job = in_id_job;        
        RETURN v_cost_of_additional_works;
    END get_cost_of_additional_works;
    
     FUNCTION get_amount_of_kilometers(in_id_job jobs.id_job%TYPE) RETURN NUMBER 
        IS
        v_amount_of_kilometers NUMBER;
    BEGIN
        SELECT SUM(amount_of_kilometers) INTO v_amount_of_kilometers FROM daily_costs WHERE id_job = in_id_job;        
        RETURN v_amount_of_kilometers;
    END get_amount_of_kilometers;
    
    FUNCTION get_agreed_amount(in_id_job jobs.id_job%TYPE) RETURN NUMBER 
        IS
        v_agreed_amount NUMBER;
    BEGIN
        SELECT agreed_amount INTO v_agreed_amount FROM jobs WHERE id_job = in_id_job;        
        RETURN v_agreed_amount;
    END get_agreed_amount;

     FUNCTION get_amount_of_unpredicted_costs(in_id_job jobs.id_job%TYPE) RETURN NUMBER 
        IS
        v_amount_of_unpredicted_costs NUMBER;
    BEGIN
        SELECT SUM(unpredicted_costs) INTO v_amount_of_unpredicted_costs FROM daily_costs where id_job = in_id_job;
        RETURN v_amount_of_unpredicted_costs;
    END get_amount_of_unpredicted_costs; 
    
     FUNCTION get_predicted_time(in_id_job jobs.id_job%TYPE) RETURN NUMBER 
        IS
        v_predicted_time NUMBER;
    BEGIN
        SELECT predicted_ending - predicted_beginning INTO v_predicted_time FROM jobs where id_job = in_id_job;
        RETURN v_predicted_time;
    END get_predicted_time;
    
     FUNCTION get_final_time(in_id_job jobs.id_job%TYPE) RETURN NUMBER 
        IS
        v_final_time NUMBER;
    BEGIN
        SELECT job_end - job_begin INTO v_final_time FROM jobs where id_job = in_id_job;
        RETURN v_final_time;
    END get_final_time;

PROCEDURE add_data_to_statistic_table_after_check(in_id_job jobs.id_job%TYPE)
    IS    
    v_check NUMBER := 0;
    v_first_name VARCHAR2(30) := get_first_name(in_id_job); 
    v_last_name VARCHAR2(40) := get_last_name(in_id_job);
    v_street VARCHAR2(30) := get_street(in_id_job);
    v_all_worked_hours NUMBER := get_all_worked_hours(in_id_job);
    v_cost_of_worked_hours NUMBER :=  get_cost_of_worked_hours(in_id_job);
    v_material_cost NUMBER := get_material_cost(in_id_job);
    v_number_of_additional_works NUMBER := get_number_of_additional_works(in_id_job);
    v_cost_of_additional_works NUMBER := get_cost_of_additional_works(in_id_job);
    v_driven_kilometers NUMBER := get_amount_of_kilometers(in_id_job);
    v_agreed_amount NUMBER := get_agreed_amount(in_id_job);
    v_amount_of_unpredicted_costs NUMBER := get_amount_of_unpredicted_costs(in_id_job);
    v_predicted_time NUMBER := get_predicted_time(in_id_job);
    v_final_time NUMBER := get_final_time(in_id_job) ;
BEGIN
    INSERT INTO jobs_done_statistics 
            (principal_first_name, principal_last_name, street, worked_hours, cost_of_worked_hours, material_cost,
            number_of_additional_works, cost_of_additional_works, driven_kilometers, agreed_amount, amount_of_unpredicted_costs,
            predicted_time_in_days, final_time_in_days)
    VALUES (v_first_name, v_last_name, v_street,v_all_worked_hours,
            v_cost_of_worked_hours , v_material_cost,v_number_of_additional_works,
            v_cost_of_additional_works,v_driven_kilometers ,v_agreed_amount ,
            v_amount_of_unpredicted_costs,v_predicted_time ,v_final_time);
END add_data_to_statistic_table_after_check;

PROCEDURE add_data_to_statistic(in_id_job jobs.id_job%TYPE)
    IS
    v_id_job NUMBER;
BEGIN
    v_id_job := general_search_programs.check_if_id_job_is_right(in_id_job);
    add_data_to_statistic_table_after_check(v_id_job);
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Id_job that you inserted is wrong, please correct it.');
END add_data_to_statistic;

END pkg_jobs_done_statistics;
/
--pkg_jobs_managment
create or replace PACKAGE jobs_managment_pkg IS
PROCEDURE p_add_job   (in_principal_name principals.first_name%TYPE
                    ,in_principal_last_name principals.last_name%TYPE
                    ,in_agreed_amount jobs.agreed_amount%TYPE
                    ,in_predicted_beginning jobs.predicted_beginning%TYPE
                    ,in_predicted_ending jobs.predicted_ending%TYPE
                    ,in_job_description jobs.job_description%TYPE);

PROCEDURE p_begin_job  (in_principal_name principals.first_name%TYPE
                        ,in_principal_last_name principals.last_name%TYPE
                        ,in_begin DATE);
PROCEDURE p_end_job (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_end DATE) ;
PROCEDURE p_set_job_as_done(in_principal_first_name principals.first_name%TYPE
                          , in_principal_last_name principals.last_name%TYPE, in_street jobs.street%TYPE);

                     

END jobs_managment_pkg;
/
create or replace PACKAGE BODY jobs_managment_pkg IS


PROCEDURE p_set_job_as_done(in_principal_first_name principals.first_name%TYPE
                          , in_principal_last_name principals.last_name%TYPE, in_street jobs.street%TYPE)
    IS 
    v_status CONSTANT VARCHAR2(15) := 'Zakoñczone';
    v_table_name CONSTANT VARCHAR2(10) := 'principals';
BEGIN 
        UPDATE JOBS 
        SET status = v_status
        WHERE id_job = 
        (SELECT id_job FROM jobs j INNER JOIN principals p ON j.id_principal = p.id_principal 
        WHERE p.first_name = in_principal_first_name 
        AND p.last_name = in_principal_last_name 
        AND j.street = in_street);
       
       IF (SQL%ROWCOUNT = 0 ) THEN general_search_programs.find_similar_names_and_last_names_by_table( in_principal_first_name,
                                                           in_principal_last_name,v_table_name);
        ELSE DBMS_OUTPUT.PUT_LINE('You succesfully updated status');
        END IF;
       
END p_set_job_as_done;

PROCEDURE p_add_job   (in_principal_name principals.first_name%TYPE
                    ,in_principal_last_name principals.last_name%TYPE
                    ,in_agreed_amount jobs.agreed_amount%TYPE
                    ,in_predicted_beginning jobs.predicted_beginning%TYPE
                    ,in_predicted_ending jobs.predicted_ending%TYPE
                    ,in_job_description jobs.job_description%TYPE)
    IS 
    v_principal_id NUMBER;
BEGIN  
    SELECT id_principal INTO v_principal_id  FROM principals WHERE first_name = in_principal_name AND last_name = in_principal_last_name;
    
    IF in_principal_last_name IS NULL OR 
    in_principal_name IS NULL 
    THEN RAISE pkg_errors.err_wrong_principals_data; END IF;
    
    INSERT INTO jobs (id_principal, agreed_amount, predicted_beginning, predicted_ending, job_description)
            VALUES ((SELECT id_principal FROM principals WHERE first_name = in_principal_name AND last_name = in_principal_last_name),
                    in_agreed_amount, in_predicted_beginning, in_predicted_ending, in_job_description);
EXCEPTION 
    WHEN NO_DATA_FOUND OR pkg_errors.err_wrong_principals_data 
        THEN DBMS_OUTPUT.PUT_LINE (pkg_errors.mss_err_wrong_principals_data);
        general_search_programs.find_similar_names_and_last_names_by_table(in_principal_name, in_principal_last_name, 'principals');
END p_add_job; 

PROCEDURE p_begin_job  (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_begin DATE) 
IS 
v_id_job principals.id_principal%TYPE; 
BEGIN 
    v_id_job := general_search_programs.f_find_job_id_by_name_and_last_name_of_principal
                (in_principal_name,in_principal_last_name);
    IF v_id_job IS NULL THEN RAISE pkg_errors.err_wrong_principals_data; END IF;
    UPDATE jobs  SET job_begin = in_begin WHERE id_job = v_id_job;
EXCEPTION 
    WHEN pkg_errors.err_wrong_principals_data THEN DBMS_OUTPUT.PUT_LINE(pkg_errors.mss_err_wrong_principals_data);
END p_begin_job;

PROCEDURE p_end_job (in_principal_name principals.first_name%TYPE
                     ,in_principal_last_name principals.last_name%TYPE
                     ,in_end DATE) 
IS 
v_id_job principals.id_principal%TYPE; 
BEGIN
     v_id_job := general_search_programs.f_find_job_id_by_name_and_last_name_of_principal
                (in_principal_name,in_principal_last_name);
    IF v_id_job IS NULL THEN RAISE pkg_errors.err_wrong_principals_data; END IF;
    UPDATE jobs SET job_end = in_end WHERE id_job = v_id_job;
EXCEPTION 
    WHEN pkg_errors.err_wrong_principals_data THEN DBMS_OUTPUT.PUT_LINE(pkg_errors.mss_err_wrong_principals_data);
END p_end_job;



END jobs_managment_pkg;
/
--pkg_principal_managment
create or replace PACKAGE principal_managment  IS
PROCEDURE add_principal (in_first_name principals.first_name%TYPE
                        ,in_last_name principals.last_name%TYPE
                        ,in_city principals.city%TYPE
                        ,in_street principals.street%TYPE
                        ,in_home_number principals.home_number%TYPE
                        ,in_phone_number  principals.phone_number%TYPE );
PROCEDURE drop_principal(in_first_name principals.first_name%TYPE, in_last_name principals.last_name%TYPE);

END principal_managment;
/

create or replace PACKAGE principal_managment  IS
PROCEDURE add_principal (in_first_name principals.first_name%TYPE
                        ,in_last_name principals.last_name%TYPE
                        ,in_city principals.city%TYPE
                        ,in_street principals.street%TYPE
                        ,in_home_number principals.home_number%TYPE
                        ,in_phone_number  principals.phone_number%TYPE );
PROCEDURE drop_principal(in_first_name principals.first_name%TYPE, in_last_name principals.last_name%TYPE);

END principal_managment;
/

create or replace PACKAGE BODY                "PRINCIPAL_MANAGMENT" IS 

PROCEDURE add_principal (in_first_name principals.first_name%TYPE 
                        ,in_last_name principals.last_name%TYPE
                        ,in_city principals.city%TYPE
                        ,in_street principals.street%TYPE
                        ,in_home_number principals.home_number%TYPE
                        ,in_phone_number  principals.phone_number%TYPE )
    IS
BEGIN  
        INSERT INTO principals (first_name, last_name, city, street, home_number, phone_number)
        VALUES  (in_first_name, in_last_name, in_city, in_street, in_home_number,  in_phone_number) ;
END add_principal;

PROCEDURE drop_principal(in_first_name principals.first_name%TYPE, in_last_name principals.last_name%TYPE) 
    IS 
BEGIN 
        DELETE FROM principals WHERE UPPER(first_name) = UPPER(in_first_name) AND UPPER(last_name) = UPPER(in_last_name);
        IF SQL%rowcount = 0 THEN RAISE pkg_errors.err_no_rows_deleted; END IF;
EXCEPTION
        WHEN pkg_errors.err_no_rows_deleted THEN DBMS_OUTPUT.PUT_LINE('There''s no record which match to you''re data input');
END drop_principal;

END principal_managment;
/
--pkg_worked_hours
create or replace PACKAGE worked_hours_pkg IS
PROCEDURE all_at_one_job( in_day_of_work DATE
                         ,in_hours_per_day worked_hours.hours_per_day%TYPE
                         ,in_id_job jobs.id_job%TYPE);

END worked_hours_pkg;
/
create or replace PACKAGE BODY worked_hours_pkg IS

TYPE ntt_all_employees IS TABLE OF employees.id_employee%TYPE;

FUNCTION get_all_employees_id RETURN ntt_all_employees IS
    v_all_employees ntt_all_employees;
    CURSOR all_id IS SELECT id_employee FROM employees;
    BEGIN 
        OPEN all_id;
        FETCH all_id BULK COLLECT INTO v_all_employees;
        CLOSE all_id;
    RETURN v_all_employees;
END get_all_employees_id;
 
 
PROCEDURE all_at_one_job( in_day_of_work DATE
                         ,in_hours_per_day worked_hours.hours_per_day%TYPE
                         ,in_id_job jobs.id_job%TYPE)
    IS 
    v_all_employees ntt_all_employees;
    BEGIN 
     v_all_employees:= get_all_employees_id();
    FOR i in v_all_employees.FIRST..v_all_employees.LAST
        LOOP 
           INSERT INTO worked_hours(day_of_work, hours_per_day, id_job, id_employee)
                            VALUES (in_day_of_work, in_hours_per_day, in_id_job, v_all_employees(i) );
        END LOOP;

END all_at_one_job;

END;
/
--              TRIGGERS
--trg_job_set_to_done
CREATE OR REPLACE TRIGGER job_set_to_done
AFTER 
UPDATE 
OF status ON jobs
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
v_id_job NUMBER;
BEGIN 
    v_id_job := :NEW.id_job;    
    invoices_pkg.generate_invoice(v_id_job);
    DBMS_OUTPUT.PUT_LINE('Created invoice to job with ID -  ' || v_id_job);
    pkg_jobs_done_statistics.add_data_to_statistic(v_id_job);
    DBMS_OUTPUT.PUT_LINE('Transfered data from jobs to table jobs_done_statistic'); 
COMMIT;
END job_set_to_done;
/
