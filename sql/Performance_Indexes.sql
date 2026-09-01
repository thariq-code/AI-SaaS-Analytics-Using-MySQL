USE ai_saas_analytics;


-- 01. Customer Industry Index
CREATE INDEX idx_customers_industry
ON customers(industry);


-- 02. Customer Country Index
CREATE INDEX idx_customers_country
ON customers(country);


-- 03. Subscription Customer Index
CREATE INDEX idx_subscriptions_customer
ON subscriptions(customer_id);


-- 04. Subscription Plan Index
CREATE INDEX idx_subscriptions_plan
ON subscriptions(plan_id);


-- 05. Subscription Status Index
CREATE INDEX idx_subscriptions_status
ON subscriptions(subscription_status);


-- 06. Payment Date Index
CREATE INDEX idx_payments_date
ON payments(payment_date);


-- 07. Payment Status Index
CREATE INDEX idx_payments_status
ON payments(payment_status);


-- 08. Payment Subscription Index
CREATE INDEX idx_payments_subscription
ON payments(subscription_id);


-- 09. AI Usage Customer Index
CREATE INDEX idx_ai_usage_customer
ON ai_usage(customer_id);


-- 10. AI Usage Date Index
CREATE INDEX idx_ai_usage_date
ON ai_usage(usage_date);


-- 11. Support Customer Index
CREATE INDEX idx_support_customer
ON support_tickets(customer_id);


-- 12. Support Ticket Date Index
CREATE INDEX idx_support_ticket_date
ON support_tickets(ticket_date);

SHOW INDEX FROM customers;

SHOW INDEX FROM subscriptions;

SHOW INDEX FROM payments;

SHOW INDEX FROM ai_usage;

SHOW INDEX FROM support_tickets;