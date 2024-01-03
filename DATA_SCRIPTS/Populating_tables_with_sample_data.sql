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

INSERT INTO jobs (id_job, id_principal, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 1, 25000, DATE'23-10-01',DATE'23-11-10','Ogród o powierzchni 300m2, nic skomplikowanego, ³atwy dojazd');
INSERT INTO jobs (id_job, id_principal, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 2, 15000, DATE'23-11-10',DATE'23-11-30','Trawnik wraz z licznymi klombami');
INSERT INTO jobs (id_job, id_principal, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 3, 5000, DATE'24-01-02',DATE'24-01-15','Niwelacja tereniu i nawo¿enie ziemi');
INSERT INTO jobs (id_job, id_principal, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 1, 27000, DATE'24-01-16',DATE'24-02-02','Droga z kostki prowadz¹ca do altany');
INSERT INTO jobs (id_job, id_principal, agreed_amount, predicted_beginning, predicted_ending, job_description) VALUES (jobs_id_seq.NEXTVAL, 4, 30000, DATE'23-02-03',DATE'23-02-27','Wiosenna pielêgnacja ogromnego ogrodu');

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

