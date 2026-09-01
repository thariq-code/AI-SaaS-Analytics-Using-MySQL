USE ai_saas_analytics;


-- 01. Customer Revenue Ranking
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


-- 02. Top Revenue Customer by Industry
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


-- 03. Customer Business Profile
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