CREATE OR REPLACE VIEW view_done_jobs_cost AS
SELECT  p.first_name AS "Principal Name"
        ,p.last_name AS "Principal Surname"
        ,j.street AS "Street_of_job"
        ,jd.cost_of_worked_hours AS "Workers salary"
        ,jd.material_cost AS "Material cost"
        ,jd.cost_of_additional_works AS "Additional work cost"
        ,jd.driven_kilometers AS " Driven kilometers"
        ,jd.amount_of_unpredicted_costs AS " Unpredicted costs"
        ,jd.agreed_amount AS "Agreed Amount" 
        ,jd.agreed_amount - jd.cost_of_additional_works - jd.material_cost - jd.amount_of_unpredicted_costs
        - jd.amount_of_unpredicted_costs - jd.cost_of_worked_hours AS "Profit"
FROM principals p 
INNER JOIN jobs j ON p.id_principal = j.id_principal
INNER JOIN jobs_done_statistics jd ON jd.principal_first_name = p.first_name AND jd.principal_last_name = p.last_name
        AND j.street = jd.street;
