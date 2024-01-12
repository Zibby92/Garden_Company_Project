CREATE OR REPLACE VIEW profit_and_costs_per_jobs AS
SELECT p.first_name, p.last_name, j.street, ROUND(amount_per_job / Days_on_job) AS daily_cost        
        ,(jd.agreed_amount - (jd.amount_of_unpredicted_costs + jd.cost_of_additional_works 
        + jd.material_cost + Amounds.amount_per_job )) / Amounds.days_on_job AS profit_per_day 
FROM
(SELECT SUM(e.hour_wage * wh.hours_per_day) AS Amount_per_job , wh.id_job id_job
    , COUNT(DISTINCT(wh.day_of_work)) AS Days_on_job
FROM employees e
INNER JOIN worked_hours wh ON e.id_employee = wh.id_employee
GROUP BY wh.id_job ) Amounds
INNER JOIN jobs j ON Amounds.id_job = j.id_job
INNER JOIN principals p ON p.id_principal = j.id_principal
INNER JOIN jobs_done_statistics jd ON jd.principal_first_name = p.first_name 
            AND jd.principal_last_name = p.last_name
            AND jd.street = j.street;