-- Dataset 1: Monthly profit trend (respects the Market parameter)
SELECT order_month, SUM(profit) AS total_profit
FROM (
  SELECT TO_CHAR(TO_DATE(order_date, 'DD Month, YYYY', 'NLS_DATE_LANGUAGE=ENGLISH'), 'YYYY-MM') AS order_month,
         order_profit_per_order AS profit, market
  FROM supply_chain
)
WHERE (:pMarket = 'All' OR market = :pMarket)
GROUP BY order_month
ORDER BY order_month;

-- Dataset 2: Sales by category / market / product (drives KPI, stacked bar, pie, doughnut)
SELECT category_name, market, product_name, SUM(sales) AS sales
FROM Supply_Chain
WHERE (:pMarket = 'All' OR market = :pMarket)
GROUP BY category_name, market, product_name;

-- Dataset 3: Market parameter dropdown ("All" first)
SELECT 'All' AS market, 0 AS sort_no FROM dual
UNION ALL
SELECT DISTINCT market, 1 AS sort_no FROM Supply_Chain
ORDER BY sort_no, market;
