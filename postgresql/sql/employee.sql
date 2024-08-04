DROP TABLE IF EXISTS employee;

-- Create the employee table
CREATE TABLE employee (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE
);

-- Insert data into the employee table
INSERT INTO employee (first_name, last_name, email, hire_date)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '2022-01-15'),
    ('Jane', 'Smith', 'jane.smith@example.com', '2021-11-23'),
    ('Robert', 'Johnson', 'robert.johnson@example.com', '2020-05-10'),
    ('Emily', 'Davis', 'emily.davis@example.com', '2019-08-30');
