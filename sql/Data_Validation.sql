USE ai_saas_analytics;

-- 1. Customers NULL Check
SELECT
    COUNT(*) AS total_customers,
    SUM(customer_name IS NULL) AS missing_names,
    SUM(email IS NULL) AS missing_emails,
    SUM(company_name IS NULL) AS missing_companies,
    SUM(industry IS NULL) AS missing_industry,
    SUM(country IS NULL) AS missing_country,
    SUM(signup_date IS NULL) AS missing_signup_dates
FROM customers;


-- 2. Plans NULL Check
SELECT
    COUNT(*) AS total_plans,
    SUM(plan_name IS NULL) AS missing_plan_names,
    SUM(monthly_price IS NULL) AS missing_prices
FROM plans;


-- 3. Subscription Validation
SELECT
    subscription_status,
    COUNT(*) AS total_subscriptions,
    SUM(end_date IS NULL) AS null_end_dates
FROM subscriptions
GROUP BY subscription_status;


-- 4. Payment Validation
SELECT
    COUNT(*) AS total_payments,
    SUM(amount IS NULL) AS missing_amounts,
    SUM(payment_status IS NULL) AS missing_status
FROM payments;


-- 5. AI Usage Validation
SELECT
    COUNT(*) AS total_usage,
    SUM(ai_requests IS NULL) AS missing_requests,
    SUM(api_calls IS NULL) AS missing_api_calls,
    SUM(active_users IS NULL) AS missing_users
FROM ai_usage;


-- 6. Support Ticket Validation
SELECT
    COUNT(*) AS total_tickets,
    SUM(issue_category IS NULL) AS missing_categories,
    SUM(priority IS NULL) AS missing_priorities,
    SUM(ticket_status IS NULL) AS missing_status
FROM support_tickets;


-- 7. Duplicate Customer Emails
SELECT
    email,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;


-- 8. Invalid Payment Amounts
SELECT *
FROM payments
WHERE amount <= 0;