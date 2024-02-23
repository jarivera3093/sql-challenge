
CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "dept_managers" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);


ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_managers" ADD CONSTRAINT "fk_dept_managers_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_managers" ADD CONSTRAINT "fk_dept_managers_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

SELECT 
e.emp_no,
e.last_name,
e.first_name,
e.sex,
s.salary
FROM employees AS e
LEFT JOIN salaries AS s ON e.emp_no = s.emp_no;

SELECT
first_name,
last_name,
hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

SELECT 
d.dept_no AS department_number,
d.dept_name AS department_name,
dm.emp_no AS employee_number,
employees.last_name,
employees.first_name

FROM departments d
LEFT JOIN dept_managers dm 
ON d.dept_no = dm.dept_no
LEFT JOIN employees
ON dm.emp_no = employees.emp_no;

SELECT 
employees.emp_no AS employee_number,
employees.last_name,
employees.first_name,
dept_emp.dept_no AS department_number,
departments.dept_name AS department_name

FROM employees 
LEFT JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no;

SELECT 
first_name,
last_name,
sex

FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

SELECT
employees.emp_no AS employee_number,
employees.last_name,
employees.first_name

FROM employees
JOIN dept_emp de ON employees.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

SELECT 
employees.emp_no AS employee_number,
employees.last_name,
employees.first_name,
d.dept_name AS department_name

FROM employees
JOIN dept_emp de ON employees.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

SELECT 
employees.last_name,
COUNT(*) AS frequency

FROM employees
GROUP BY last_name
ORDER BY frequency DESC, last_name;


