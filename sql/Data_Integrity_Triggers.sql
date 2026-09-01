USE ai_saas_analytics;

DELIMITER $$


-- 01. Validate Payment Amount
CREATE TRIGGER ValidatePaymentAmount
BEFORE INSERT ON payments
FOR EACH ROW
BEGIN
    IF NEW.amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment amount must be greater than zero';
    END IF;
END $$


-- 02. Validate AI Usage
CREATE TRIGGER ValidateAIUsage
BEFORE INSERT ON ai_usage
FOR EACH ROW
BEGIN
    IF NEW.ai_requests < 0
       OR NEW.api_calls < 0
       OR NEW.active_users < 0
       OR NEW.hours_saved < 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'AI usage values cannot be negative';

    END IF;
END $$


-- 03. Validate Subscription Dates
CREATE TRIGGER ValidateSubscriptionDates
BEFORE INSERT ON subscriptions
FOR EACH ROW
BEGIN
    IF NEW.end_date IS NOT NULL
       AND NEW.end_date < NEW.start_date THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'End date cannot be earlier than start date';

    END IF;
END $$


DELIMITER ;

SHOW TRIGGERS
FROM ai_saas_analytics;