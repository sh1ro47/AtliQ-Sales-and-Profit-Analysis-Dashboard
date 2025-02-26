-- 1. Top 10 customer sales 
use sales ;
SELECT 
    c.customer_code,
    c.custmer_name,
    SUM(t.sales_amount) AS total_sales
FROM transactions t
JOIN customers c ON t.customer_code = c.customer_code
GROUP BY c.customer_code, c.custmer_name
ORDER BY total_sales DESC
limit 10 ;


-- 2 Sales by Month for a Given Year
SELECT 
  d.year,
  d.month_name,
  SUM(t.sales_amount) AS monthly_sales
FROM transactions t
JOIN date d ON t.order_date = d.order_date
WHERE d.year = 2019 
GROUP BY d.year, d.month_name
ORDER BY d.year,
FIELD(d.month_name, 'January', 'February', 'March', 'April', 'May', 'June', 
                     'July', 'August', 'September', 'October', 'November', 'December');  
                     
                     
-- 4  top 3 selling month
WITH ranked_sales AS (
  SELECT
    d.year,
    d.month_name,
    SUM(t.sales_amount) AS monthly_sales,
    ROW_NUMBER() OVER (PARTITION BY d.year ORDER BY SUM(t.sales_amount) DESC) AS rn
  FROM transactions t
  JOIN date d ON t.order_date = d.order_date
  GROUP BY d.year, d.month_name
)
SELECT
  year,
  month_name,
  monthly_sales
FROM ranked_sales
WHERE rn <= 3
ORDER BY year, rn;

-- 4.  Sales by Market Name 
SELECT 
  m.markets_name as city ,
  SUM(t.sales_amount) AS total_sales
FROM transactions t
JOIN markets m ON t.market_code = m.market_code
 GROUP BY  m.markets_name
ORDER BY total_sales DESC 
limit 10 ;


-- 5. Sales by Product Type

SELECT 
  p.product_type,
  SUM(t.sales_amount) AS total_sales
FROM transactions t
JOIN products p ON t.product_code = p.product_code
GROUP BY p.product_type
ORDER BY total_sales DESC;

-- 6. sales of city Owner brand VS Distribution 
SELECT 
  m.markets_name AS city,
  p.product_type,
  SUM(t.sales_amount) AS total_sales
FROM transactions t
JOIN markets m ON t.market_code = m.market_code
JOIN products p ON t.product_code = p.product_code
GROUP BY m.markets_name, p.product_type
ORDER BY m.markets_name, total_sales DESC;


-- 7. sales by zone own vs distri..
SELECT 
  m.zone,
  p.product_type,
  SUM(t.sales_amount) AS total_sales
FROM transactions t
JOIN markets m ON t.market_code = m.market_code
JOIN products p ON t.product_code = p.product_code
GROUP BY m.zone, p.product_type
ORDER BY m.zone, total_sales DESC;
 
 



