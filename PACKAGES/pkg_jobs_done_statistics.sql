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