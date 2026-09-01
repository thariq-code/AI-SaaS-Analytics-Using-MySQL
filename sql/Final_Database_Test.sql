USE ai_saas_analytics;


-- 01. Check All Tables
SHOW TABLES;


-- 02. Check Customer Records
SELECT *
FROM customers
LIMIT 10;


-- 03. Check Plan Records
SELECT *
FROM plans;


-- 04. Check Subscription Records
SELECT *
FROM subscriptions
LIMIT 10;


-- 05. Check Payment Records
SELECT *
FROM payments
LIMIT 10;


-- 06. Check AI Usage Records
SELECT *
FROM ai_usage
LIMIT 10;


-- 07. Check Support Ticket Records
SELECT *
FROM support_tickets
LIMIT 10;


-- 08. Check Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;


-- 09. Check Total Subscriptions
SELECT COUNT(*) AS total_subscriptions
FROM subscriptions;


-- 10. Check Total Revenue
SELECT
    ROUND(SUM(amount), 2) AS total_revenue
FROM payments
WHERE payment_status = 'Paid';


-- 11. Check Active Subscriptions
SELECT COUNT(*) AS active_subscriptions
FROM subscriptions
WHERE subscription_status = 'Active';


-- 12. Check Payment Status
SELECT
    payment_status,
    COUNT(*) AS payment_count
FROM payments
GROUP BY payment_status;


-- 13. Check Subscription Status
SELECT
    subscription_status,
    COUNT(*) AS subscription_count
FROM subscriptions
GROUP BY subscription_status;


-- 14. Check AI Usage
SELECT
    SUM(ai_requests) AS total_ai_requests,
    SUM(api_calls) AS total_api_calls,
    SUM(active_users) AS total_active_users,
    ROUND(SUM(hours_saved), 2) AS total_hours_saved
FROM ai_usage;


-- 15. Check Support Tickets
SELECT
    ticket_status,
    COUNT(*) AS ticket_count
FROM support_tickets
GROUP BY ticket_status;


-- 16. Test Customer Revenue View
SELECT *
FROM customer_revenue_view
LIMIT 10;


-- 17. Test Plan Performance View
SELECT *
FROM plan_performance_view;


-- 18. Test AI Usage View
SELECT *
FROM ai_usage_performance_view
LIMIT 10;


-- 19. Test Support Performance View
SELECT *
FROM support_performance_view
LIMIT 10;


-- 20. Test Subscription View
SELECT *
FROM subscription_overview_view
LIMIT 10;