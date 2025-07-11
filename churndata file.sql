-- Practice Questions:

-- 1. Convert the TotalCharges column to numeric format for accurate calculations.
-- 2. Retrieve the total number of customers and those who have churned.
-- 3. Calculate the average tenure of customers who churned vs. those who didn't.
-- 4. Find the top 5 most common payment methods used by customers.
-- 5. Create a stored procedure to fetch customers based on a tenure range.
-- 6. Find the percentage of customers using Fiber Optic Internet.
-- 7. Create a trigger to prevent inserting customers with negative MonthlyCharges.
-- 8. Identify customers with above-average MonthlyCharges.
-- 9. Create a view to show customers with online security and tech support.
-- 10. Count the number of customers grouped by contract type, filtering those with over 100 customers.
-- 11. Retrieve the top 10 customers with the highest total charges.
-- 12. Find customers with tenure above 50 months and are still active.
-- 13. Calculate the total revenue generated per payment method.
-- 14. Create an index on tenure to optimize performance.
-- 15. Retrieve the count of customers who have both streaming TV and streaming movies services.
-- 16. Use a CASE statement to categorize customers based on tenure:
--     - 'New' (0-12 months), 'Intermediate' (13-48 months), 'Loyal' (49+ months).
-- 17. Use a CASE statement to classify customers based on MonthlyCharges:
--     - 'Low' (below $30), 'Medium' ($30-$70), 'High' (above $70).
-- 18. Create a function to calculate the total revenue for a given contract type.
-- 19. Insert a new customer record into the churn_data table.
-- 20. Update the MonthlyCharges for a specific customer.
-- 21. Delete a customer record from the churn_data table.

SELECT * FROM kishan.churndata;

DESCRIBE churndata;

#1. Convert the TotalCharges column to numeric format for accurate calculations.

SELECT CAST(TotalCharges AS DECIMAL(10,2)) AS TotalChargesNumeric
FROM churndata;

SELECT * FROM kishan.churndata;

#2. Retrieve the total number of customers and those who have churned.

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM churndata;

SELECT * FROM kishan.churndata;

#3. Calculate the average tenure of customers who churned vs. those who didn't.

SELECT
    Churn,
    AVG(tenure) AS average_tenure
FROM churndata
GROUP BY Churn;

SELECT * FROM kishan.churndata;

#4 Find the top 5 most common payment methods used by customers.

SELECT * FROM kishan.churndata;

SELECT
    PaymentMethod,
    COUNT(*) AS method_count
FROM churndata
GROUP BY PaymentMethod
ORDER BY method_count DESC
LIMIT 5;

#5. Create a stored procedure to fetch customers based on a tenure range.

DELIMITER $$

CREATE PROCEDURE CustomersByTenure(
    IN min_tenure INT,
    IN max_tenure INT
)
BEGIN
    SELECT * FROM churndata WHERE tenure BETWEEN min_tenure AND max_tenure;
END $$

DELIMITER ;

call CustomersByTenure(15,50);

SELECT * FROM kishan.churndata;

#6. Find the percentage of customers using Fiber Optic Internet.

SELECT 
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM churndata), 2) AS fiber_optic_percentage FROM churndata
WHERE 
    internetservice = 'Fiber Optic';

SELECT * FROM kishan.churndata;

#7. Create a trigger to prevent inserting customers with negative MonthlyCharges.

ALTER TABLE churndata ADD 
CONSTRAINT check_monthly_charges_positive 
CHECK (MonthlyCharges >= 0);

insert into churndata(MonthlyCharges) value (-34);
SELECT * FROM kishan.churndata;

#8. Identify customers with above-average MonthlyCharges.

SELECT *
FROM churndata
WHERE MonthlyCharges > (
    SELECT AVG(MonthlyCharges) FROM churndata
)
order by MonthlyCharges DESC;

SELECT * FROM kishan.churndata;

#9. Create a view to show customers with online security and tech support.

CREATE VIEW Customers_With_Security_And_Support AS
SELECT Onlinebackup, TechSupport from churndata;

SELECT * FROM Customers_With_Security_And_Support;
select tenure from Customers_With_Security_And_Support ;
SELECT * FROM kishan.churndata;
drop view Customers_With_Security_And_Support;

#10. Count the number of customers grouped by contract type, filtering those with over 100 customers.

SELECT 
    Contract,
    COUNT(*) AS customer_count
FROM churndata
GROUP BY Contract
HAVING customer_count > 100;

SELECT * FROM kishan.churndata;

# 11. Retrieve the top 10 customers with the highest total charges.

SELECT CustomerID, TotalCharges
FROM churndata
WHERE TotalCharges IS NOT NULL
ORDER BY CAST(TotalCharges AS DECIMAL(10,2)) DESC
LIMIT 10;

SELECT * FROM kishan.churndata;

# 12. Find customers with tenure above 50 months and are still active.

SELECT *
FROM churndata
WHERE tenure > 50 AND Churn = 'No';

SELECT * FROM kishan.churndata;

# 13. Calculate the total revenue generated per payment method.

SELECT 
    PaymentMethod,
    SUM(CAST(TotalCharges AS DECIMAL(10,2))) AS total_revenue # **CAST(TotalCharges AS DECIMAL(10,2))** because TotalCharges is likely stored as a string (VARCHAR) table — not a numeric type.
FROM churndata
WHERE TotalCharges IS NOT NULL
GROUP BY PaymentMethod;

SELECT * FROM kishan.churndata;

#14. Create an index on tenure to optimize performance.

CREATE INDEX idx_tenure ON churndata(tenure);

SELECT * FROM churndata ORDER BY tenure;
SELECT * FROM churndata WHERE tenure > 50;

SHOW INDEXES FROM churndata;

SELECT * FROM kishan.churndata;

#15. Retrieve the count of customers who have both streaming TV and streaming movies services.

SELECT COUNT(*) AS customer_count
FROM churndata
WHERE StreamingTV = 'Yes' AND StreamingMovies = 'Yes';

SELECT * FROM kishan.churndata;

#16. Use a CASE statement to categorize customers based on tenure:
--     - 'New' (0-12 months), 'Intermediate' (13-48 months), 'Loyal' (49+ months).

SELECT 
    CustomerID,
    tenure,
    CASE
        WHEN tenure BETWEEN 0 AND 12 THEN 'New'
        WHEN tenure BETWEEN 13 AND 48 THEN 'Intermediate'
        WHEN tenure >= 49 THEN 'Loyal'
        ELSE 'Unknown'
    END AS tenure_category
FROM churndata;

SELECT * FROM kishan.churndata;

#17. Use a CASE statement to classify customers based on MonthlyCharges:
--     - 'Low' (below $30), 'Medium' ($30-$70), 'High' (above $70).

SELECT 
    CustomerID,
    MonthlyCharges,
    CASE
        WHEN MonthlyCharges < 30 THEN 'Low'
        WHEN MonthlyCharges BETWEEN 30 AND 70 THEN 'Medium'
        WHEN MonthlyCharges > 70 THEN 'High'
        ELSE 'Unknown'
    END AS charge_category
FROM churndata;

SELECT * FROM kishan.churndata;

#18. Create a function to calculate the total revenue for a given contract type.

DELIMITER $$

CREATE FUNCTION CalculateTotalRevenue(contract_type VARCHAR(50))
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE total_revenue DECIMAL(15,2);

    SELECT SUM(TotalCharges) INTO total_revenue
    FROM churndata
    WHERE Contract = contract_type AND TotalCharges IS NOT NULL;

    RETURN total_revenue;
END $$

DELIMITER ;

SELECT CalculateTotalRevenue('month-to-month');

SELECT * FROM kishan.churndata;

# 19. Insert a new customer record into the churn_data table.

INSERT INTO churndata (CustomerID, gender,seniorcitizen, Tenure,phoneservice,internetservice,onlinebackup,deviceprotection,techsupport,streamingtv,streamingmovies,contract,paperlessbilling,paymentmethod, MonthlyCharges, TotalCharges, Churn) 
values ('5977-KISHAN','MALE', 0 , 58, 'YES', 'DSL','YES','NO','YES','YES','YES','ONE YEAR','NO','MAILED CHECK',59.77,5977.77,'NO');

SELECT * FROM kishan.churndata;


# 20. Update the MonthlyCharges for a specific customer.

UPDATE churndata
SET MonthlyCharges = 27.05
WHERE CustomerID = '5977-kishan';

SELECT * FROM kishan.churndata;

# 21. Delete a customer record from the churn_data table.

DELETE FROM churndata
WHERE CustomerID = '5977-kishan';

SELECT * FROM kishan.churndata;







