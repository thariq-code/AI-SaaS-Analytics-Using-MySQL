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