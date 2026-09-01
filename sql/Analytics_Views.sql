USE ai_saas_analytics;


-- 01. Customer Revenue View
CREATE VIEW customer_revenue_view AS
SELECT
    c.customer_id,
    c.company_name,
    c.industry,
    c.country,
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
GROUP BY
    c.customer_id,
    c.company_name,
    c.industry,
    c.country;


-- 02. Plan Performance View
CREATE VIEW plan_performance_view AS
SELECT
    pl.plan_id,
    pl.plan_name,
    pl.monthly_price,
    COUNT(DISTINCT s.subscription_id) AS total_subscriptions,
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
GROUP BY
    pl.plan_id,
    pl.plan_name,
    pl.monthly_price;


-- 03. AI Usage Performance View
CREATE VIEW ai_usage_performance_view AS
SELECT
    c.customer_id,
    c.company_name,
    c.industry,
    COALESCE(SUM(a.ai_requests), 0) AS total_ai_requests,
    COALESCE(SUM(a.api_calls), 0) AS total_api_calls,
    COALESCE(SUM(a.active_users), 0) AS total_active_users,
    COALESCE(SUM(a.hours_saved), 0) AS total_hours_saved
FROM customers c
LEFT JOIN ai_usage a
    ON c.customer_id = a.customer_id
GROUP BY
    c.customer_id,
    c.company_name,
    c.industry;


-- 04. Support Performance View
CREATE VIEW support_performance_view AS
SELECT
    c.customer_id,
    c.company_name,
    COUNT(t.ticket_id) AS total_tickets,
    ROUND(AVG(t.resolution_time_hours), 2) AS avg_resolution_hours,
    SUM(t.priority = 'Critical') AS critical_tickets,
    SUM(t.ticket_status IN ('Open','In Progress')) AS unresolved_tickets
FROM customers c
LEFT JOIN support_tickets t
    ON c.customer_id = t.customer_id
GROUP BY
    c.customer_id,
    c.company_name;


-- 05. Subscription Overview View
CREATE VIEW subscription_overview_view AS
SELECT
    s.subscription_id,
    c.company_name,
    pl.plan_name,
    s.start_date,
    s.end_date,
    s.subscription_status
FROM subscriptions s
JOIN customers c
    ON s.customer_id = c.customer_id
JOIN plans pl
    ON s.plan_id = pl.plan_id;
    
    
-- Check Created Views
SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';