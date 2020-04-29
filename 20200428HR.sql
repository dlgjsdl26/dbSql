join8

SELECT countries.region_id, region_name, country_name
FROM countries, regions
WHERE countries.region_id = regions.region_id 
    AND region_name = 'Europe';
    
join9

SELECT countries.region_id, region_name, country_name, city
FROM countries, regions, locations
WHERE countries.region_id = regions.region_id 
    AND locations.country_id = countries.country_id
    AND region_name = 'Europe';
    
join10

SELECT countries.region_id, region_name, country_name, city, department_name
FROM countries, regions, locations, departments
WHERE countries.region_id = regions.region_id 
    AND locations.country_id = countries.country_id
    AND locations.location_id = departments.location_id
    AND region_name = 'Europe';
    
--join11

SELECT countries.region_id, region_name, country_name, city, department_name
FROM countries, regions, locations, departments, employees
WHERE countries.region_id = regions.region_id 
    AND (locations.country_id = countries.country_id
    OR locations.location_id = departments.location_id)
    AND employees. employee_id = departments.manager_id
    AND region_name = 'Europe'
    AND country_name = 'United Kingdom'
ORDER BY countries.region_id, country_name;


join12

SELECT employee_id, first_name || last_name name, jobs.job_id, job_title
FROM employees, jobs
WHERE employees.job_id = jobs.job_id;


join13

SELECT e.manager_id mgr_id, m.first_name || m.last_name mgr_name,
e.employee_id, e.first_name || e.last_name name, jobs.job_id, job_title
FROM employees e, jobs, employees m
WHERE e.job_id = jobs.job_id
AND e.manager_id = m.employee_id;