## 
-- ============================================================
-- BRIGHT MOTORS CAR SALES CASE STUDY
-- Databricks SQL Script
-- Purpose: Data cleaning, transformation, analysis and dashboard prep
-- Table name: car_sales_data
-- ============================================================

-- ============================================================
-- 1. Raw Dataset
-- ============================================================

SELECT *
FROM workspace.default.car_sales_data
LIMIT 20;



-- ============================================================
-- 2. Check Table Structure
-- ============================================================

DESCRIBE workspace.default.car_sales_data;



-- ============================================================
-- 3. Check Number of Records
-- ============================================================

SELECT COUNT(*) AS total_rows
FROM workspace.default.car_sales_data;



-- ============================================================
-- 4. Check for Duplicate Records
-- ============================================================

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT vin) AS unique_vins,
    COUNT(*) - COUNT(DISTINCT vin) AS duplicate_records
FROM workspace.default.car_sales_data;



-- ============================================================
-- 5. Check Date Range
-- ============================================================

SELECT 
    MIN(saledate) AS earliest_sale_date,
    MAX(saledate) AS latest_sale_date
FROM workspace.default.car_sales_data;



-- ============================================================
-- 6. Check Missing Values
-- ============================================================

SELECT *
FROM workspace.default.car_sales_data
WHERE vin IS NULL
   OR saledate IS NULL
   OR make IS NULL
   OR model IS NULL
   OR year IS NULL
   OR sellingprice IS NULL
   OR mmr IS NULL
   OR state IS NULL;



-- ============================================================
-- 7. Check Distinct Car Makes
-- ============================================================

SELECT DISTINCT make
FROM workspace.default.car_sales_data
ORDER BY make;



-- ============================================================
-- 8. Check Distinct Car Models
-- ============================================================

SELECT DISTINCT model
FROM workspace.default.car_sales_data
ORDER BY model;



-- ============================================================
-- 9. Check Distinct Regions
-- ============================================================

SELECT DISTINCT state
FROM workspace.default.car_sales_data
ORDER BY state;



-- ============================================================
-- 10. Check Distinct Body Types
-- ============================================================

SELECT DISTINCT body
FROM workspace.default.car_sales_data
ORDER BY body;



-- ============================================================
-- 11. Check Price Range
-- ============================================================

SELECT 
    MIN(sellingprice) AS lowest_selling_price,
    MAX(sellingprice) AS highest_selling_price,
    AVG(sellingprice) AS average_selling_price
FROM workspace.default.car_sales_data;



-- ============================================================
-- 12. Check Odometer Range
-- ============================================================

SELECT 
    MIN(odometer) AS lowest_odometer,
    MAX(odometer) AS highest_odometer,
    AVG(odometer) AS average_odometer
FROM workspace.default.car_sales_data;



-- ============================================================
-- 13. Sales Distribution by Body Type
-- ============================================================

SELECT
    body AS body_type,
    COUNT(*) AS total_vehicles_sold,
    ROUND(SUM(sellingprice), 2) AS total_revenue,
    ROUND(AVG(sellingprice), 2) AS average_selling_price
FROM workspace.default.car_sales_data
GROUP BY body
ORDER BY total_revenue DESC;



-- ============================================================
-- 14. Revenue by State
-- ============================================================

SELECT
    state,
    COUNT(*) AS total_vehicles_sold,
    ROUND(SUM(sellingprice), 2) AS total_revenue,
    ROUND(SUM(sellingprice - mmr), 2) AS total_profit,
    ROUND(AVG(sellingprice), 2) AS average_selling_price
FROM workspace.default.car_sales_data
GROUP BY state
ORDER BY total_revenue DESC;



-- ============================================================
-- 15. Revenue by Car Make
-- ============================================================

SELECT
    make,
    COUNT(*) AS total_vehicles_sold,
    ROUND(SUM(sellingprice), 2) AS total_revenue,
    ROUND(SUM(sellingprice - mmr), 2) AS total_profit,
    ROUND(AVG(((sellingprice - mmr) / sellingprice) * 100), 2) AS average_profit_margin
FROM workspace.default.car_sales_data
GROUP BY make
ORDER BY total_revenue DESC;



-- ============================================================
-- 16. Revenue Trend by Month
-- ============================================================

SELECT
    YEAR(to_timestamp(substring(saledate, 5), 'MMM dd yyyy HH:mm:ss')) AS sale_year,
    MONTH(to_timestamp(substring(saledate, 5), 'MMM dd yyyy HH:mm:ss')) AS sale_month_number,
    DATE_FORMAT(to_timestamp(substring(saledate, 5), 'MMM dd yyyy HH:mm:ss'), 'MMMM') AS sale_month_name,
    COUNT(*) AS total_vehicles_sold,
    ROUND(SUM(sellingprice), 2) AS monthly_revenue,
    ROUND(SUM(sellingprice - mmr), 2) AS monthly_profit,
    ROUND(AVG(sellingprice), 2) AS average_selling_price
FROM workspace.default.car_sales_data
GROUP BY 
    YEAR(to_timestamp(substring(saledate, 5), 'MMM dd yyyy HH:mm:ss')),
    MONTH(to_timestamp(substring(saledate, 5), 'MMM dd yyyy HH:mm:ss')),
    DATE_FORMAT(to_timestamp(substring(saledate, 5), 'MMM dd yyyy HH:mm:ss'), 'MMMM')
ORDER BY sale_year, sale_month_number;



-- ============================================================
-- 17. Revenue Trend by Quarter
-- ============================================================

SELECT
    sale_year,
    sale_quarter,
    SUM(units_sold) AS total_units_sold,
    ROUND(SUM(total_revenue), 2) AS quarterly_revenue,
    ROUND(SUM(total_profit), 2) AS quarterly_profit
FROM workspace.default.car_sales_data
GROUP BY sale_year, sale_quarter
ORDER BY sale_year, sale_quarter;



-- ============================================================
-- 18. Create Cleaned and Enriched Dataset
-- ============================================================

SELECT
    TRIM(make) AS make,
    TRIM(model) AS model,
    CAST(year AS INT) AS manufacture_year,
    CAST(odometer AS DOUBLE) AS mileage,
    CAST(sellingprice AS DOUBLE) AS selling_price,
    1 AS units_sold,
    CAST(sellingprice AS DOUBLE) AS total_revenue,
    ROUND(((sellingprice - mmr) / sellingprice) * 100, 2) AS profit_margin_percentage
FROM workspace.default.car_sales_data
WHERE odometer IS NOT NULL
  AND sellingprice IS NOT NULL
ORDER BY sellingprice DESC;



-- ============================================================
-- 19. Average Selling Price by Manufacture Year
-- ============================================================

SELECT year AS manufacture_year,
    COUNT(DISTINCT vin) AS number_of_sales,
    COUNT(*) AS total_units_sold,
    ROUND(AVG(sellingprice), 2) AS average_selling_price,
    ROUND(SUM(sellingprice), 2) AS total_revenue
FROM workspace.default.car_sales_data
GROUP BY year
ORDER BY year;



-- ============================================================
-- 20. Cleaned Dataset
-- ============================================================

SELECT 
    vin,
    to_timestamp(substring(saledate, 5), 'MMM dd yyyy HH:mm:ss') AS sale_date,
    
    TRIM(make) AS make,
    TRIM(model) AS model,
    CAST(year AS INT) AS manufacture_year,
    TRIM(state) AS region,
    TRIM(body) AS body_type,
    CAST(sellingprice AS DOUBLE) AS selling_price,
    CAST(mmr AS DOUBLE) AS cost_price,
    CAST(odometer AS DOUBLE) AS mileage,

    -- Calculations
    CAST(sellingprice AS DOUBLE) AS total_revenue,
    (sellingprice - mmr) AS total_profit,
    ROUND(((sellingprice - mmr) / sellingprice) * 100, 2) AS profit_margin_percentage,

    -- Dates
    YEAR(to_timestamp(substring(saledate, 5), 'MMM dd yyyy HH:mm:ss')) AS sale_year,
    MONTH(to_timestamp(substring(saledate, 5), 'MMM dd yyyy HH:mm:ss')) AS sale_month_number,
    DATE_FORMAT(to_timestamp(substring(saledate, 5), 'MMM dd yyyy HH:mm:ss'), 'MMMM') AS sale_month_name,

    -- Day Type
    CASE 
        WHEN DATE_FORMAT(to_timestamp(substring(saledate, 5), 'MMM dd yyyy HH:mm:ss'), 'EEEE') IN ('Saturday', 'Sunday') 
        THEN 'Weekend' 
        ELSE 'Weekday' 
    END AS day_classification,

    -- Margin Tiers
    CASE 
        WHEN ((sellingprice - mmr) / sellingprice) * 100 >= 30 THEN 'High Margin'
        WHEN ((sellingprice - mmr) / sellingprice) * 100 >= 15 THEN 'Medium Margin'
        ELSE 'Low Margin' 
    END AS profit_margin_tier

FROM workspace.default.car_sales_data

WHERE vin IS NOT NULL 
  AND saledate IS NOT NULL 
  AND make IS NOT NULL;
