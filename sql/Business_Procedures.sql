USE ai_saas_analytics;

DELIMITER $$


-- 01. Customer Revenue Procedure
CREATE PROCEDURE GetCustomerRevenue(IN p_customer_id INT)
BEGIN
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
    WHERE c.customer_id = p_customer_id
    GROUP BY c.customer_id, c.company_name;
END $$


-- 02. Industry Revenue Procedure
CREATE PROCEDURE GetIndustryRevenue(IN p_industry VARCHAR(100))
BEGIN
    SELECT
        c.industry,
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
    WHERE c.industry = p_industry
    GROUP BY c.industry;
END $$


-- 03. Customer AI Usage Procedure
CREATE PROCEDURE GetCustomerAIUsage(IN p_customer_id INT)
BEGIN
    SELECT
        c.customer_id,
        c.company_name,
        SUM(a.ai_requests) AS total_ai_requests,
        SUM(a.api_calls) AS total_api_calls,
        SUM(a.active_users) AS total_active_users,
        ROUND(SUM(a.hours_saved), 2) AS total_hours_saved
    FROM customers c
    JOIN ai_usage a
        ON c.customer_id = a.customer_id
    WHERE c.customer_id = p_customer_id
    GROUP BY c.customer_id, c.company_name;
END $$


-- 04. Subscription Status Procedure
CREATE PROCEDURE GetSubscriptionStatus(IN p_status VARCHAR(30))
BEGIN
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
        ON s.plan_id = pl.plan_id
    WHERE s.subscription_status = p_status
    ORDER BY s.start_date DESC;
END $$


-- 05. Support Ticket Procedure
CREATE PROCEDURE GetCustomerSupportTickets(IN p_customer_id INT)
BEGIN
    SELECT
        t.ticket_id,
        c.company_name,
        t.issue_category,
        t.priority,
        t.resolution_time_hours,
        t.ticket_status
    FROM support_tickets t
    JOIN customers c
        ON t.customer_id = c.customer_id
    WHERE t.customer_id = p_customer_id
    ORDER BY t.ticket_date DESC;
END $$

DELIMITER ;

SHOW PROCEDURE STATUS
WHERE Db = 'ai_saas_analytics';

