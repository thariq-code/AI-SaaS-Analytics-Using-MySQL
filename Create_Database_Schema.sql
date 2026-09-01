CREATE DATABASE ai_saas_analytics;

USE ai_saas_analytics;

USE ai_saas_analytics;

-- 1. Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    company_name VARCHAR(150) NOT NULL,
    industry VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    signup_date DATE NOT NULL
);

-- 2. Plans
CREATE TABLE plans (
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(50) NOT NULL,
    billing_cycle VARCHAR(20) NOT NULL,
    monthly_price DECIMAL(10,2) NOT NULL,
    user_limit INT NOT NULL,
    ai_features VARCHAR(255) NOT NULL
);

-- 3. Subscriptions
CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    plan_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    subscription_status VARCHAR(30) NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (plan_id)
        REFERENCES plans(plan_id)
);

-- 4. Payments
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    subscription_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(30) NOT NULL,

    FOREIGN KEY (subscription_id)
        REFERENCES subscriptions(subscription_id)
);

-- 5. AI Usage
CREATE TABLE ai_usage (
    usage_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    usage_date DATE NOT NULL,
    ai_requests INT DEFAULT 0,
    active_users INT DEFAULT 0,
    api_calls INT DEFAULT 0,
    hours_saved DECIMAL(10,2) DEFAULT 0,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- 6. Support Tickets
CREATE TABLE support_tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    ticket_date DATE NOT NULL,
    issue_category VARCHAR(100) NOT NULL,
    priority VARCHAR(30) NOT NULL,
    resolution_time_hours DECIMAL(10,2) NOT NULL,
    ticket_status VARCHAR(30) NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);