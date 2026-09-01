USE ai_saas_analytics;


-- 01. Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;


-- 02. Customers by Country
SELECT country, COUNT(*) AS customer_count
FROM customers
GROUP BY country
ORDER BY customer_count DESC;


-- 03. Customers by Industry
SELECT industry, COUNT(*) AS customer_count
FROM customers
GROUP BY industry
ORDER BY customer_count DESC;


-- 04. Average Plan Price
SELECT AVG(monthly_price) AS average_plan_price
FROM plans;


-- 05. Subscription Count by Plan
SELECT
    p.plan_name,
    COUNT(s.subscription_id) AS subscription_count
FROM plans p
LEFT JOIN subscriptions s
    ON p.plan_id = s.plan_id
GROUP BY p.plan_id, p.plan_name
ORDER BY subscription_count DESC;


-- 06. Active Subscriptions
SELECT COUNT(*) AS active_subscriptions
FROM subscriptions
WHERE subscription_status = 'Active';


-- 07. Subscription Status Analysis
SELECT
    subscription_status,
    COUNT(*) AS total_subscriptions
FROM subscriptions
GROUP BY subscription_status
ORDER BY total_subscriptions DESC;


-- 08. Total Revenue
SELECT
    SUM(amount) AS total_revenue
FROM payments
WHERE payment_status = 'Paid';


-- 09. Revenue by Payment Method
SELECT
    payment_method,
    SUM(amount) AS total_revenue
FROM payments
WHERE payment_status = 'Paid'
GROUP BY payment_method
ORDER BY total_revenue DESC;


-- 10. Monthly Revenue
SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS revenue_month,
    SUM(amount) AS monthly_revenue
FROM payments
WHERE payment_status = 'Paid'
GROUP BY revenue_month
ORDER BY revenue_month;

-- 11. Top 10 Customers by Revenue
SELECT
    c.customer_id,
    c.company_name,
    SUM(p.amount) AS total_revenue
FROM customers c
JOIN subscriptions s
    ON c.customer_id = s.customer_id
JOIN payments p
    ON s.subscription_id = p.subscription_id
WHERE p.payment_status = 'Paid'
GROUP BY c.customer_id, c.company_name
ORDER BY total_revenue DESC
LIMIT 10;


-- 12. Revenue by Subscription Plan
SELECT
    pl.plan_name,
    SUM(p.amount) AS total_revenue
FROM plans pl
JOIN subscriptions s
    ON pl.plan_id = s.plan_id
JOIN payments p
    ON s.subscription_id = p.subscription_id
WHERE p.payment_status = 'Paid'
GROUP BY pl.plan_id, pl.plan_name
ORDER BY total_revenue DESC;


-- 13. Average Revenue per Customer
SELECT
    ROUND(SUM(p.amount) / COUNT(DISTINCT s.customer_id), 2)
    AS average_revenue_per_customer
FROM payments p
JOIN subscriptions s
    ON p.subscription_id = s.subscription_id
WHERE p.payment_status = 'Paid';


-- 14. Customers with Multiple Subscriptions
SELECT
    c.customer_id,
    c.company_name,
    COUNT(s.subscription_id) AS subscription_count
FROM customers c
JOIN subscriptions s
    ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.company_name
HAVING COUNT(s.subscription_id) > 1
ORDER BY subscription_count DESC;


-- 15. AI Requests by Customer
SELECT
    c.company_name,
    SUM(a.ai_requests) AS total_ai_requests
FROM customers c
JOIN ai_usage a
    ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.company_name
ORDER BY total_ai_requests DESC
LIMIT 10;


-- 16. Average AI Requests per Customer
SELECT
    ROUND(AVG(total_requests), 2) AS avg_ai_requests
FROM (
    SELECT
        customer_id,
        SUM(ai_requests) AS total_requests
    FROM ai_usage
    GROUP BY customer_id
) AS customer_usage;


-- 17. AI Usage by Industry
SELECT
    c.industry,
    SUM(a.ai_requests) AS total_ai_requests,
    SUM(a.api_calls) AS total_api_calls
FROM customers c
JOIN ai_usage a
    ON c.customer_id = a.customer_id
GROUP BY c.industry
ORDER BY total_ai_requests DESC;


-- 18. Top Customers by Hours Saved
SELECT
    c.company_name,
    ROUND(SUM(a.hours_saved), 2) AS total_hours_saved
FROM customers c
JOIN ai_usage a
    ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.company_name
ORDER BY total_hours_saved DESC
LIMIT 10;


-- 19. Support Tickets by Category
SELECT
    issue_category,
    COUNT(*) AS ticket_count
FROM support_tickets
GROUP BY issue_category
ORDER BY ticket_count DESC;


-- 20. Support Tickets by Priority
SELECT
    priority,
    COUNT(*) AS ticket_count
FROM support_tickets
GROUP BY priority
ORDER BY ticket_count DESC;


-- 21. Average Ticket Resolution Time
SELECT
    ROUND(AVG(resolution_time_hours), 2)
    AS average_resolution_hours
FROM support_tickets;


-- 22. Customers with Most Support Tickets
SELECT
    c.company_name,
    COUNT(t.ticket_id) AS total_tickets
FROM customers c
JOIN support_tickets t
    ON c.customer_id = t.customer_id
GROUP BY c.customer_id, c.company_name
ORDER BY total_tickets DESC
LIMIT 10;


-- 23. Payment Success Rate
SELECT
    ROUND(
        SUM(payment_status = 'Paid') * 100.0 / COUNT(*),
        2
    ) AS payment_success_rate
FROM payments;


-- 24. Failed Payments by Month
SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS payment_month,
    COUNT(*) AS failed_payments
FROM payments
WHERE payment_status = 'Failed'
GROUP BY payment_month
ORDER BY payment_month;


-- 25. Customer Revenue Ranking
WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.company_name,
        COALESCE(SUM(
            CASE
                WHEN p.payment_status = 'Paid'
                THEN p.amount
                ELSE 0
            END
        ), 0) AS total_revenue
    FROM customers c
    LEFT JOIN subscriptions s
        ON c.customer_id = s.customer_id
    LEFT JOIN payments p
        ON s.subscription_id = p.subscription_id
    GROUP BY c.customer_id, c.company_name
)
SELECT
    company_name,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM customer_revenue
ORDER BY revenue_rank;


-- 26. Plan Revenue Ranking
WITH plan_revenue AS (
    SELECT
        pl.plan_name,
        COALESCE(SUM(
            CASE
                WHEN p.payment_status = 'Paid'
                THEN p.amount
                ELSE 0
            END
        ), 0) AS total_revenue
    FROM plans pl
    LEFT JOIN subscriptions s
        ON pl.plan_id = s.plan_id
    LEFT JOIN payments p
        ON s.subscription_id = p.subscription_id
    GROUP BY pl.plan_id, pl.plan_name
)
SELECT
    plan_name,
    total_revenue,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM plan_revenue
ORDER BY revenue_rank;


-- 27. High Usage Customers
SELECT
    c.company_name,
    SUM(a.ai_requests) AS total_ai_requests
FROM customers c
JOIN ai_usage a
    ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.company_name
HAVING SUM(a.ai_requests) >
(
    SELECT AVG(customer_requests)
    FROM (
        SELECT
            customer_id,
            SUM(ai_requests) AS customer_requests
        FROM ai_usage
        GROUP BY customer_id
    ) AS avg_usage
)
ORDER BY total_ai_requests DESC;


-- 28. Customer Business Profile
SELECT
    c.company_name,
    c.industry,
    c.country,
    COUNT(DISTINCT s.subscription_id) AS subscriptions,
    COALESCE(SUM(p.amount), 0) AS revenue,
    COALESCE(SUM(a.ai_requests), 0) AS ai_requests,
    COUNT(DISTINCT t.ticket_id) AS support_tickets
FROM customers c
LEFT JOIN subscriptions s
    ON c.customer_id = s.customer_id
LEFT JOIN payments p
    ON s.subscription_id = p.subscription_id
    AND p.payment_status = 'Paid'
LEFT JOIN ai_usage a
    ON c.customer_id = a.customer_id
LEFT JOIN support_tickets t
    ON c.customer_id = t.customer_id
GROUP BY
    c.customer_id,
    c.company_name,
    c.industry,
    c.country
ORDER BY revenue DESC;


-- 29. Customer Engagement Classification
SELECT
    c.company_name,
    SUM(a.ai_requests) AS total_ai_requests,
    CASE
        WHEN SUM(a.ai_requests) >= 30000 THEN 'Highly Engaged'
        WHEN SUM(a.ai_requests) >= 15000 THEN 'Moderately Engaged'
        ELSE 'Low Engagement'
    END AS engagement_level
FROM customers c
JOIN ai_usage a
    ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.company_name
ORDER BY total_ai_requests DESC;


-- 30. Top Revenue Customer by Industry
WITH industry_customers AS (
    SELECT
        c.industry,
        c.company_name,
        COALESCE(SUM(
            CASE
                WHEN p.payment_status = 'Paid'
                THEN p.amount
                ELSE 0
            END
        ), 0) AS total_revenue
    FROM customers c
    LEFT JOIN subscriptions s
        ON c.customer_id = s.customer_id
    LEFT JOIN payments p
        ON s.subscription_id = p.subscription_id
    GROUP BY c.industry, c.customer_id, c.company_name
),
ranked_customers AS (
    SELECT
        industry,
        company_name,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY industry
            ORDER BY total_revenue DESC
        ) AS industry_rank
    FROM industry_customers
)
SELECT
    industry,
    company_name,
    total_revenue
FROM ranked_customers
WHERE industry_rank = 1
ORDER BY industry;