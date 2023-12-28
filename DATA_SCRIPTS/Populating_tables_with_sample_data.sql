CREATE SEQUENCE employee_id_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 10000
  NOCYCLE
  ;
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Jakub', 'Ku�mi�ski','N', DATE'23-10-01',25);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Micha�', 'Kowalczyk','N', DATE'22-10-01',30);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Zofia', 'Adak','N', DATE'21-10-01',30);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Kornel', 'Brzezi�ski','N', DATE'20-10-01',35);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Jerzy', 'Zdu�ski','Y', DATE'23-01-01',20);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Dominik', 'Twaim','N', DATE'22-06-01',20);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Micha�', 'Opozda','Y', DATE'23-02-01',33);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Marek', 'Ele�ski','N', DATE'20-12-01',31);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Robert', 'Nadaremno','N', DATE'23-12-01',40);
INSERT INTO employees (id_employee, first_name, last_name, driving_licence, hire_date, hour_wage) VALUES (employee_id_seq.nextval,'Szczepan', 'Bocian','Y', DATE'21-09-01',50);

DROP SEQUENCE employee_id_seq;
DROP TABLE employees;

CREATE SEQUENCE principals_id_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 10000
  NOCYCLE
  ;
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Konstanty', 'Tyszkiewisz', 'Warszawa', 'Woronicza', 123, 123123123);
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Jaros�aw', 'Wachad�o', 'Pruszk�w', 'Sienkiewicza', 1743, 99913132);
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Lech', 'Mikrus', 'O�ary', 'Le�na', 1, 51230232);
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Arkadiusz', 'Ziobro', 'Mi�sk Mazowiecki', 'Sosnowa', 123, 34123222);
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Remigiusz', 'Elwi�ska', 'Toru�', 'Ma�a', '1123A', 513140222);
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Ilona', 'Asymilewisz', 'Warszawa', 'Kr�tka', '43B', 514310381);
INSERT INTO principals (id_principal, first_name, last_name, city, street, home_number, phone_number) VALUES (principals_id_seq.NEXTVAL, 'Weronika', 'Toru�ska', 'Siennica', 'D�uga', '12/12', 123444122);

DROP SEQUENCE principals_id_seq;
DROP TABLE principals;
SELECT * FROM principals;

CREATE SEQUENCE jobs_id_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 10000
  NOCYCLE
  ;
INSERT INTO jobs (id_job, id_principal, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 1, 25000, DATE'23-10-01',DATE'23-11-10','Ogr�d o powierzchni 300m2, nic skomplikowanego, �atwy dojazd');
INSERT INTO jobs (id_job, id_principal, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 2, 15000, DATE'23-11-10',DATE'23-11-30','Trawnik wraz z licznymi klombami');
INSERT INTO jobs (id_job, id_principal, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 3, 5000, DATE'24-01-02',DATE'24-01-15','Niwelacja tereniu i nawo�enie ziemi');
INSERT INTO jobs (id_job, id_principal, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 1, 27000, DATE'24-01-16',DATE'24-02-02','Droga z kostki prowadz�ca do altany');
INSERT INTO jobs (id_job, id_principal, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 4, 30000, DATE'23-02-03',DATE'23-02-27','Wiosenna piel�gnacja ogromnego ogrodu');

DROP TABLE jobs;
SELECT * FROM jobs;