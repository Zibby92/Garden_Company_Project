CREATE OR REPLACE VIEW salaries AS
SELECT  e.first_name AS "First Name"
        ,e.last_name AS "Last Name"
        ,TO_CHAR(TO_DATE(wh.day_of_work,'YY/MM/DD'),'Year') as "Year"
        ,TO_CHAR(wh.day_of_work,'Month') as "Month"
        ,SUM(wh.hours_per_day) AS "Worked hours"
        ,SUM(wh.hours_per_day) * e.hour_wage AS "Salary"
FROM employees e
INNER JOIN worked_hours wh ON e.id_employee = wh.id_employee
GROUP BY e.first_name, e.last_name,e.hour_wage
,TO_CHAR(TO_DATE(wh.day_of_work,'YY/MM/DD'),'Year')
,TO_CHAR((wh.day_of_work),'Month')
ORDER BY "Year","Month";
