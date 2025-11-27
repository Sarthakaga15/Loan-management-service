-- Enhanced Test Data for Loan Management Service
-- This file contains comprehensive test data with diverse scenarios

-- ============================================
-- LOAN DATA (15 loans with various scenarios)
-- ============================================

INSERT INTO loan (customer_name, original_amount, principal_outstanding, interest_outstanding, annual_interest_rate, total_interest_accrued, loan_status, created_at, updated_at)
VALUES 
    -- Active loans with regular payments
    ('Rajesh Kumar', 500000.00, 350000.00, 12500.00, 10.50, 37500.00, 'ACTIVE', CURRENT_TIMESTAMP - INTERVAL '6 months', CURRENT_TIMESTAMP),
    ('Priya Sharma', 1000000.00, 1000000.00, 0.00, 12.00, 0.00, 'ACTIVE', CURRENT_TIMESTAMP - INTERVAL '1 month', CURRENT_TIMESTAMP),
    ('Amit Patel', 800000.00, 600000.00, 18000.00, 9.00, 54000.00, 'ACTIVE', CURRENT_TIMESTAMP - INTERVAL '1 year', CURRENT_TIMESTAMP),
    
    -- High-value loans
    ('Sunita Reddy', 5000000.00, 4500000.00, 125000.00, 11.00, 375000.00, 'ACTIVE', CURRENT_TIMESTAMP - INTERVAL '9 months', CURRENT_TIMESTAMP),
    ('Vikram Singh', 3000000.00, 2100000.00, 45000.00, 8.50, 135000.00, 'ACTIVE', CURRENT_TIMESTAMP - INTERVAL '8 months', CURRENT_TIMESTAMP),
    
    -- Small business loans
    ('Anjali Gupta', 750000.00, 600000.00, 15000.00, 10.00, 45000.00, 'ACTIVE', CURRENT_TIMESTAMP - INTERVAL '7 months', CURRENT_TIMESTAMP),
    ('Rahul Verma', 1200000.00, 900000.00, 22500.00, 9.50, 67500.00, 'ACTIVE', CURRENT_TIMESTAMP - INTERVAL '5 months', CURRENT_TIMESTAMP),
    
    -- Education loans
    ('Neha Kapoor', 600000.00, 480000.00, 10800.00, 7.50, 32400.00, 'ACTIVE', CURRENT_TIMESTAMP - INTERVAL '10 months', CURRENT_TIMESTAMP),
    ('Karan Malhotra', 450000.00, 360000.00, 7200.00, 8.00, 21600.00, 'ACTIVE', CURRENT_TIMESTAMP - INTERVAL '4 months', CURRENT_TIMESTAMP),
    
    -- Nearly paid off loans
    ('Deepak Joshi', 300000.00, 50000.00, 1500.00, 11.50, 85500.00, 'ACTIVE', CURRENT_TIMESTAMP - INTERVAL '2 years', CURRENT_TIMESTAMP),
    ('Meera Nair', 400000.00, 75000.00, 2250.00, 10.25, 120750.00, 'ACTIVE', CURRENT_TIMESTAMP - INTERVAL '18 months', CURRENT_TIMESTAMP),
    
    -- Closed loans (fully paid)
    ('Sanjay Desai', 250000.00, 0.00, 0.00, 9.75, 73125.00, 'CLOSED', CURRENT_TIMESTAMP - INTERVAL '15 months', CURRENT_TIMESTAMP),
    ('Pooja Iyer', 350000.00, 0.00, 0.00, 10.50, 105000.00, 'CLOSED', CURRENT_TIMESTAMP - INTERVAL '13 months', CURRENT_TIMESTAMP),
    
    -- Recent loans (minimal history)
    ('Arjun Rao', 900000.00, 900000.00, 2250.00, 10.00, 2250.00, 'ACTIVE', CURRENT_TIMESTAMP - INTERVAL '15 days', CURRENT_TIMESTAMP),
    ('Kavita Menon', 550000.00, 550000.00, 1375.00, 9.00, 1375.00, 'ACTIVE', CURRENT_TIMESTAMP - INTERVAL '10 days', CURRENT_TIMESTAMP);

-- ============================================
-- REPAYMENT DATA (50+ repayments)
-- ============================================

-- Repayments for Rajesh Kumar (loan_id: 1) - Regular monthly payments
INSERT INTO repayment (loan_id, amount, principal_portion, interest_portion, running_balance, payment_date, created_at)
VALUES 
    (1, 50000.00, 45625.00, 4375.00, 454375.00, CURRENT_DATE - INTERVAL '5 months', CURRENT_TIMESTAMP - INTERVAL '5 months'),
    (1, 50000.00, 46000.00, 4000.00, 408375.00, CURRENT_DATE - INTERVAL '4 months', CURRENT_TIMESTAMP - INTERVAL '4 months'),
    (1, 50000.00, 46500.00, 3500.00, 361875.00, CURRENT_DATE - INTERVAL '3 months', CURRENT_TIMESTAMP - INTERVAL '3 months'),
    (1, 11875.00, 11875.00, 0.00, 350000.00, CURRENT_DATE - INTERVAL '2 months', CURRENT_TIMESTAMP - INTERVAL '2 months');

-- Repayments for Amit Patel (loan_id: 3) - Quarterly payments
INSERT INTO repayment (loan_id, amount, principal_portion, interest_portion, running_balance, payment_date, created_at)
VALUES 
    (3, 100000.00, 82000.00, 18000.00, 718000.00, CURRENT_DATE - INTERVAL '9 months', CURRENT_TIMESTAMP - INTERVAL '9 months'),
    (3, 100000.00, 88000.00, 12000.00, 630000.00, CURRENT_DATE - INTERVAL '6 months', CURRENT_TIMESTAMP - INTERVAL '6 months'),
    (3, 30000.00, 30000.00, 0.00, 600000.00, CURRENT_DATE - INTERVAL '3 months', CURRENT_TIMESTAMP - INTERVAL '3 months');

-- Repayments for Sunita Reddy (loan_id: 4) - Large payments
INSERT INTO repayment (loan_id, amount, principal_portion, interest_portion, running_balance, payment_date, created_at)
VALUES 
    (4, 250000.00, 208750.00, 41250.00, 4750000.00, CURRENT_DATE - INTERVAL '8 months', CURRENT_TIMESTAMP - INTERVAL '8 months'),
    (4, 250000.00, 225000.00, 25000.00, 4525000.00, CURRENT_DATE - INTERVAL '5 months', CURRENT_TIMESTAMP - INTERVAL '5 months'),
    (4, 25000.00, 25000.00, 0.00, 4500000.00, CURRENT_DATE - INTERVAL '2 months', CURRENT_TIMESTAMP - INTERVAL '2 months');

-- Repayments for Vikram Singh (loan_id: 5)
INSERT INTO repayment (loan_id, amount, principal_portion, interest_portion, running_balance, payment_date, created_at)
VALUES 
    (5, 300000.00, 276750.00, 23250.00, 2700000.00, CURRENT_DATE - INTERVAL '7 months', CURRENT_TIMESTAMP - INTERVAL '7 months'),
    (5, 300000.00, 285000.00, 15000.00, 2415000.00, CURRENT_DATE - INTERVAL '4 months', CURRENT_TIMESTAMP - INTERVAL '4 months'),
    (5, 315000.00, 308250.00, 6750.00, 2106750.00, CURRENT_DATE - INTERVAL '1 month', CURRENT_TIMESTAMP - INTERVAL '1 month'),
    (5, 6750.00, 6750.00, 0.00, 2100000.00, CURRENT_DATE - INTERVAL '15 days', CURRENT_TIMESTAMP - INTERVAL '15 days');

-- Repayments for Anjali Gupta (loan_id: 6)
INSERT INTO repayment (loan_id, amount, principal_portion, interest_portion, running_balance, payment_date, created_at)
VALUES 
    (6, 75000.00, 68750.00, 6250.00, 675000.00, CURRENT_DATE - INTERVAL '6 months', CURRENT_TIMESTAMP - INTERVAL '6 months'),
    (6, 75000.00, 70000.00, 5000.00, 605000.00, CURRENT_DATE - INTERVAL '3 months', CURRENT_TIMESTAMP - INTERVAL '3 months'),
    (6, 5000.00, 5000.00, 0.00, 600000.00, CURRENT_DATE - INTERVAL '1 month', CURRENT_TIMESTAMP - INTERVAL '1 month');

-- Repayments for Rahul Verma (loan_id: 7)
INSERT INTO repayment (loan_id, amount, principal_portion, interest_portion, running_balance, payment_date, created_at)
VALUES 
    (7, 150000.00, 138750.00, 11250.00, 1050000.00, CURRENT_DATE - INTERVAL '4 months', CURRENT_TIMESTAMP - INTERVAL '4 months'),
    (7, 150000.00, 143750.00, 6250.00, 906250.00, CURRENT_DATE - INTERVAL '2 months', CURRENT_TIMESTAMP - INTERVAL '2 months'),
    (7, 6250.00, 6250.00, 0.00, 900000.00, CURRENT_DATE - INTERVAL '1 month', CURRENT_TIMESTAMP - INTERVAL '1 month');

-- Repayments for Neha Kapoor (loan_id: 8)
INSERT INTO repayment (loan_id, amount, principal_portion, interest_portion, running_balance, payment_date, created_at)
VALUES 
    (8, 60000.00, 56250.00, 3750.00, 540000.00, CURRENT_DATE - INTERVAL '9 months', CURRENT_TIMESTAMP - INTERVAL '9 months'),
    (8, 60000.00, 57600.00, 2400.00, 482400.00, CURRENT_DATE - INTERVAL '6 months', CURRENT_TIMESTAMP - INTERVAL '6 months'),
    (8, 2400.00, 2400.00, 0.00, 480000.00, CURRENT_DATE - INTERVAL '3 months', CURRENT_TIMESTAMP - INTERVAL '3 months');

-- Repayments for Karan Malhotra (loan_id: 9)
INSERT INTO repayment (loan_id, amount, principal_portion, interest_portion, running_balance, payment_date, created_at)
VALUES 
    (9, 45000.00, 42000.00, 3000.00, 405000.00, CURRENT_DATE - INTERVAL '3 months', CURRENT_TIMESTAMP - INTERVAL '3 months'),
    (9, 45000.00, 43200.00, 1800.00, 361800.00, CURRENT_DATE - INTERVAL '1 month', CURRENT_TIMESTAMP - INTERVAL '1 month'),
    (9, 1800.00, 1800.00, 0.00, 360000.00, CURRENT_DATE - INTERVAL '15 days', CURRENT_TIMESTAMP - INTERVAL '15 days');

-- Repayments for Deepak Joshi (loan_id: 10) - Nearly paid off
INSERT INTO repayment (loan_id, amount, principal_portion, interest_portion, running_balance, payment_date, created_at)
VALUES 
    (10, 50000.00, 31250.00, 18750.00, 250000.00, CURRENT_DATE - INTERVAL '23 months', CURRENT_TIMESTAMP - INTERVAL '23 months'),
    (10, 50000.00, 35000.00, 15000.00, 215000.00, CURRENT_DATE - INTERVAL '20 months', CURRENT_TIMESTAMP - INTERVAL '20 months'),
    (10, 50000.00, 38750.00, 11250.00, 176250.00, CURRENT_DATE - INTERVAL '17 months', CURRENT_TIMESTAMP - INTERVAL '17 months'),
    (10, 50000.00, 42500.00, 7500.00, 133750.00, CURRENT_DATE - INTERVAL '14 months', CURRENT_TIMESTAMP - INTERVAL '14 months'),
    (10, 50000.00, 46250.00, 3750.00, 87500.00, CURRENT_DATE - INTERVAL '11 months', CURRENT_TIMESTAMP - INTERVAL '11 months'),
    (10, 37500.00, 37500.00, 0.00, 50000.00, CURRENT_DATE - INTERVAL '8 months', CURRENT_TIMESTAMP - INTERVAL '8 months');

-- Repayments for Meera Nair (loan_id: 11) - Nearly paid off
INSERT INTO repayment (loan_id, amount, principal_portion, interest_portion, running_balance, payment_date, created_at)
VALUES 
    (11, 65000.00, 48750.00, 16250.00, 335000.00, CURRENT_DATE - INTERVAL '17 months', CURRENT_TIMESTAMP - INTERVAL '17 months'),
    (11, 65000.00, 52000.00, 13000.00, 283000.00, CURRENT_DATE - INTERVAL '14 months', CURRENT_TIMESTAMP - INTERVAL '14 months'),
    (11, 65000.00, 55250.00, 9750.00, 227750.00, CURRENT_DATE - INTERVAL '11 months', CURRENT_TIMESTAMP - INTERVAL '11 months'),
    (11, 65000.00, 58500.00, 6500.00, 169250.00, CURRENT_DATE - INTERVAL '8 months', CURRENT_TIMESTAMP - INTERVAL '8 months'),
    (11, 65000.00, 61750.00, 3250.00, 107500.00, CURRENT_DATE - INTERVAL '5 months', CURRENT_TIMESTAMP - INTERVAL '5 months'),
    (11, 32500.00, 32500.00, 0.00, 75000.00, CURRENT_DATE - INTERVAL '2 months', CURRENT_TIMESTAMP - INTERVAL '2 months');

-- Repayments for Sanjay Desai (loan_id: 12) - CLOSED
INSERT INTO repayment (loan_id, amount, principal_portion, interest_portion, running_balance, payment_date, created_at)
VALUES 
    (12, 50000.00, 43750.00, 6250.00, 200000.00, CURRENT_DATE - INTERVAL '14 months', CURRENT_TIMESTAMP - INTERVAL '14 months'),
    (12, 50000.00, 45625.00, 4375.00, 154375.00, CURRENT_DATE - INTERVAL '11 months', CURRENT_TIMESTAMP - INTERVAL '11 months'),
    (12, 50000.00, 47500.00, 2500.00, 106875.00, CURRENT_DATE - INTERVAL '8 months', CURRENT_TIMESTAMP - INTERVAL '8 months'),
    (12, 50000.00, 49375.00, 625.00, 57500.00, CURRENT_DATE - INTERVAL '5 months', CURRENT_TIMESTAMP - INTERVAL '5 months'),
    (12, 57500.00, 57500.00, 0.00, 0.00, CURRENT_DATE - INTERVAL '2 months', CURRENT_TIMESTAMP - INTERVAL '2 months');

-- Repayments for Pooja Iyer (loan_id: 13) - CLOSED
INSERT INTO repayment (loan_id, amount, principal_portion, interest_portion, running_balance, payment_date, created_at)
VALUES 
    (13, 70000.00, 61250.00, 8750.00, 280000.00, CURRENT_DATE - INTERVAL '12 months', CURRENT_TIMESTAMP - INTERVAL '12 months'),
    (13, 70000.00, 63875.00, 6125.00, 216125.00, CURRENT_DATE - INTERVAL '9 months', CURRENT_TIMESTAMP - INTERVAL '9 months'),
    (13, 70000.00, 66500.00, 3500.00, 149625.00, CURRENT_DATE - INTERVAL '6 months', CURRENT_TIMESTAMP - INTERVAL '6 months'),
    (13, 70000.00, 69125.00, 875.00, 80500.00, CURRENT_DATE - INTERVAL '3 months', CURRENT_TIMESTAMP - INTERVAL '3 months'),
    (13, 80500.00, 80500.00, 0.00, 0.00, CURRENT_DATE - INTERVAL '1 month', CURRENT_TIMESTAMP - INTERVAL '1 month');

-- ============================================
-- INTEREST HISTORY DATA (100+ records)
-- ============================================

-- Interest history for Rajesh Kumar (loan_id: 1) - 6 months
INSERT INTO interest_history (loan_id, interest_date, interest_amount, created_at)
VALUES 
    (1, CURRENT_DATE - INTERVAL '180 days', 1438.36, CURRENT_TIMESTAMP - INTERVAL '180 days'),
    (1, CURRENT_DATE - INTERVAL '179 days', 1438.36, CURRENT_TIMESTAMP - INTERVAL '179 days'),
    (1, CURRENT_DATE - INTERVAL '178 days', 1438.36, CURRENT_TIMESTAMP - INTERVAL '178 days'),
    (1, CURRENT_DATE - INTERVAL '177 days', 1438.36, CURRENT_TIMESTAMP - INTERVAL '177 days'),
    (1, CURRENT_DATE - INTERVAL '176 days', 1438.36, CURRENT_TIMESTAMP - INTERVAL '176 days'),
    (1, CURRENT_DATE - INTERVAL '150 days', 1306.85, CURRENT_TIMESTAMP - INTERVAL '150 days'),
    (1, CURRENT_DATE - INTERVAL '120 days', 1175.34, CURRENT_TIMESTAMP - INTERVAL '120 days'),
    (1, CURRENT_DATE - INTERVAL '90 days', 1043.84, CURRENT_TIMESTAMP - INTERVAL '90 days'),
    (1, CURRENT_DATE - INTERVAL '60 days', 1008.90, CURRENT_TIMESTAMP - INTERVAL '60 days'),
    (1, CURRENT_DATE - INTERVAL '30 days', 1008.90, CURRENT_TIMESTAMP - INTERVAL '30 days'),
    (1, CURRENT_DATE - INTERVAL '15 days', 1008.90, CURRENT_TIMESTAMP - INTERVAL '15 days'),
    (1, CURRENT_DATE - INTERVAL '7 days', 1008.90, CURRENT_TIMESTAMP - INTERVAL '7 days'),
    (1, CURRENT_DATE - INTERVAL '1 day', 1008.90, CURRENT_TIMESTAMP - INTERVAL '1 day');

-- Interest history for Priya Sharma (loan_id: 2) - 1 month
INSERT INTO interest_history (loan_id, interest_date, interest_amount, created_at)
VALUES 
    (2, CURRENT_DATE - INTERVAL '30 days', 3287.67, CURRENT_TIMESTAMP - INTERVAL '30 days'),
    (2, CURRENT_DATE - INTERVAL '25 days', 3287.67, CURRENT_TIMESTAMP - INTERVAL '25 days'),
    (2, CURRENT_DATE - INTERVAL '20 days', 3287.67, CURRENT_TIMESTAMP - INTERVAL '20 days'),
    (2, CURRENT_DATE - INTERVAL '15 days', 3287.67, CURRENT_TIMESTAMP - INTERVAL '15 days'),
    (2, CURRENT_DATE - INTERVAL '10 days', 3287.67, CURRENT_TIMESTAMP - INTERVAL '10 days'),
    (2, CURRENT_DATE - INTERVAL '5 days', 3287.67, CURRENT_TIMESTAMP - INTERVAL '5 days'),
    (2, CURRENT_DATE - INTERVAL '1 day', 3287.67, CURRENT_TIMESTAMP - INTERVAL '1 day');

-- Interest history for Amit Patel (loan_id: 3) - 1 year
INSERT INTO interest_history (loan_id, interest_date, interest_amount, created_at)
VALUES 
    (3, CURRENT_DATE - INTERVAL '365 days', 1972.60, CURRENT_TIMESTAMP - INTERVAL '365 days'),
    (3, CURRENT_DATE - INTERVAL '335 days', 1775.34, CURRENT_TIMESTAMP - INTERVAL '335 days'),
    (3, CURRENT_DATE - INTERVAL '305 days', 1578.08, CURRENT_TIMESTAMP - INTERVAL '305 days'),
    (3, CURRENT_DATE - INTERVAL '275 days', 1775.34, CURRENT_TIMESTAMP - INTERVAL '275 days'),
    (3, CURRENT_DATE - INTERVAL '245 days', 1578.08, CURRENT_TIMESTAMP - INTERVAL '245 days'),
    (3, CURRENT_DATE - INTERVAL '215 days', 1578.08, CURRENT_TIMESTAMP - INTERVAL '215 days'),
    (3, CURRENT_DATE - INTERVAL '185 days', 1578.08, CURRENT_TIMESTAMP - INTERVAL '185 days'),
    (3, CURRENT_DATE - INTERVAL '155 days', 1578.08, CURRENT_TIMESTAMP - INTERVAL '155 days'),
    (3, CURRENT_DATE - INTERVAL '125 days', 1480.82, CURRENT_TIMESTAMP - INTERVAL '125 days'),
    (3, CURRENT_DATE - INTERVAL '95 days', 1480.82, CURRENT_TIMESTAMP - INTERVAL '95 days'),
    (3, CURRENT_DATE - INTERVAL '65 days', 1480.82, CURRENT_TIMESTAMP - INTERVAL '65 days'),
    (3, CURRENT_DATE - INTERVAL '35 days', 1480.82, CURRENT_TIMESTAMP - INTERVAL '35 days'),
    (3, CURRENT_DATE - INTERVAL '5 days', 1480.82, CURRENT_TIMESTAMP - INTERVAL '5 days');

-- Interest history for Sunita Reddy (loan_id: 4) - 9 months (high value)
INSERT INTO interest_history (loan_id, interest_date, interest_amount, created_at)
VALUES 
    (4, CURRENT_DATE - INTERVAL '270 days', 15068.49, CURRENT_TIMESTAMP - INTERVAL '270 days'),
    (4, CURRENT_DATE - INTERVAL '240 days', 14383.56, CURRENT_TIMESTAMP - INTERVAL '240 days'),
    (4, CURRENT_DATE - INTERVAL '210 days', 13698.63, CURRENT_TIMESTAMP - INTERVAL '210 days'),
    (4, CURRENT_DATE - INTERVAL '180 days', 13698.63, CURRENT_TIMESTAMP - INTERVAL '180 days'),
    (4, CURRENT_DATE - INTERVAL '150 days', 13698.63, CURRENT_TIMESTAMP - INTERVAL '150 days'),
    (4, CURRENT_DATE - INTERVAL '120 days', 13698.63, CURRENT_TIMESTAMP - INTERVAL '120 days'),
    (4, CURRENT_DATE - INTERVAL '90 days', 13698.63, CURRENT_TIMESTAMP - INTERVAL '90 days'),
    (4, CURRENT_DATE - INTERVAL '60 days', 13561.64, CURRENT_TIMESTAMP - INTERVAL '60 days'),
    (4, CURRENT_DATE - INTERVAL '30 days', 13561.64, CURRENT_TIMESTAMP - INTERVAL '30 days'),
    (4, CURRENT_DATE - INTERVAL '15 days', 13561.64, CURRENT_TIMESTAMP - INTERVAL '15 days'),
    (4, CURRENT_DATE - INTERVAL '7 days', 13561.64, CURRENT_TIMESTAMP - INTERVAL '7 days'),
    (4, CURRENT_DATE - INTERVAL '1 day', 13561.64, CURRENT_TIMESTAMP - INTERVAL '1 day');

-- Interest history for Vikram Singh (loan_id: 5) - 8 months
INSERT INTO interest_history (loan_id, interest_date, interest_amount, created_at)
VALUES 
    (5, CURRENT_DATE - INTERVAL '240 days', 6986.30, CURRENT_TIMESTAMP - INTERVAL '240 days'),
    (5, CURRENT_DATE - INTERVAL '210 days', 6301.37, CURRENT_TIMESTAMP - INTERVAL '210 days'),
    (5, CURRENT_DATE - INTERVAL '180 days', 5616.44, CURRENT_TIMESTAMP - INTERVAL '180 days'),
    (5, CURRENT_DATE - INTERVAL '150 days', 5616.44, CURRENT_TIMESTAMP - INTERVAL '150 days'),
    (5, CURRENT_DATE - INTERVAL '120 days', 5616.44, CURRENT_TIMESTAMP - INTERVAL '120 days'),
    (5, CURRENT_DATE - INTERVAL '90 days', 5616.44, CURRENT_TIMESTAMP - INTERVAL '90 days'),
    (5, CURRENT_DATE - INTERVAL '60 days', 5479.45, CURRENT_TIMESTAMP - INTERVAL '60 days'),
    (5, CURRENT_DATE - INTERVAL '30 days', 4897.26, CURRENT_TIMESTAMP - INTERVAL '30 days'),
    (5, CURRENT_DATE - INTERVAL '15 days', 4897.26, CURRENT_TIMESTAMP - INTERVAL '15 days'),
    (5, CURRENT_DATE - INTERVAL '7 days', 4897.26, CURRENT_TIMESTAMP - INTERVAL '7 days'),
    (5, CURRENT_DATE - INTERVAL '1 day', 4897.26, CURRENT_TIMESTAMP - INTERVAL '1 day');

-- Interest history for other active loans (6-11) - Sample entries
INSERT INTO interest_history (loan_id, interest_date, interest_amount, created_at)
VALUES 
    -- Anjali Gupta (loan_id: 6)
    (6, CURRENT_DATE - INTERVAL '210 days', 2054.79, CURRENT_TIMESTAMP - INTERVAL '210 days'),
    (6, CURRENT_DATE - INTERVAL '180 days', 1849.32, CURRENT_TIMESTAMP - INTERVAL '180 days'),
    (6, CURRENT_DATE - INTERVAL '150 days', 1643.84, CURRENT_TIMESTAMP - INTERVAL '150 days'),
    (6, CURRENT_DATE - INTERVAL '120 days', 1643.84, CURRENT_TIMESTAMP - INTERVAL '120 days'),
    (6, CURRENT_DATE - INTERVAL '90 days', 1643.84, CURRENT_TIMESTAMP - INTERVAL '90 days'),
    (6, CURRENT_DATE - INTERVAL '60 days', 1643.84, CURRENT_TIMESTAMP - INTERVAL '60 days'),
    (6, CURRENT_DATE - INTERVAL '30 days', 1643.84, CURRENT_TIMESTAMP - INTERVAL '30 days'),
    (6, CURRENT_DATE - INTERVAL '15 days', 1643.84, CURRENT_TIMESTAMP - INTERVAL '15 days'),
    (6, CURRENT_DATE - INTERVAL '7 days', 1643.84, CURRENT_TIMESTAMP - INTERVAL '7 days'),
    (6, CURRENT_DATE - INTERVAL '1 day', 1643.84, CURRENT_TIMESTAMP - INTERVAL '1 day'),
    
    -- Rahul Verma (loan_id: 7)
    (7, CURRENT_DATE - INTERVAL '150 days', 3123.29, CURRENT_TIMESTAMP - INTERVAL '150 days'),
    (7, CURRENT_DATE - INTERVAL '120 days', 2739.73, CURRENT_TIMESTAMP - INTERVAL '120 days'),
    (7, CURRENT_DATE - INTERVAL '90 days', 2356.16, CURRENT_TIMESTAMP - INTERVAL '90 days'),
    (7, CURRENT_DATE - INTERVAL '60 days', 2356.16, CURRENT_TIMESTAMP - INTERVAL '60 days'),
    (7, CURRENT_DATE - INTERVAL '30 days', 2356.16, CURRENT_TIMESTAMP - INTERVAL '30 days'),
    (7, CURRENT_DATE - INTERVAL '15 days', 2356.16, CURRENT_TIMESTAMP - INTERVAL '15 days'),
    (7, CURRENT_DATE - INTERVAL '7 days', 2356.16, CURRENT_TIMESTAMP - INTERVAL '7 days'),
    (7, CURRENT_DATE - INTERVAL '1 day', 2356.16, CURRENT_TIMESTAMP - INTERVAL '1 day'),
    
    -- Neha Kapoor (loan_id: 8)
    (8, CURRENT_DATE - INTERVAL '300 days', 1232.88, CURRENT_TIMESTAMP - INTERVAL '300 days'),
    (8, CURRENT_DATE - INTERVAL '270 days', 1109.59, CURRENT_TIMESTAMP - INTERVAL '270 days'),
    (8, CURRENT_DATE - INTERVAL '240 days', 986.30, CURRENT_TIMESTAMP - INTERVAL '240 days'),
    (8, CURRENT_DATE - INTERVAL '210 days', 986.30, CURRENT_TIMESTAMP - INTERVAL '210 days'),
    (8, CURRENT_DATE - INTERVAL '180 days', 986.30, CURRENT_TIMESTAMP - INTERVAL '180 days'),
    (8, CURRENT_DATE - INTERVAL '150 days', 986.30, CURRENT_TIMESTAMP - INTERVAL '150 days'),
    (8, CURRENT_DATE - INTERVAL '120 days', 986.30, CURRENT_TIMESTAMP - INTERVAL '120 days'),
    (8, CURRENT_DATE - INTERVAL '90 days', 986.30, CURRENT_TIMESTAMP - INTERVAL '90 days'),
    (8, CURRENT_DATE - INTERVAL '60 days', 986.30, CURRENT_TIMESTAMP - INTERVAL '60 days'),
    (8, CURRENT_DATE - INTERVAL '30 days', 986.30, CURRENT_TIMESTAMP - INTERVAL '30 days'),
    (8, CURRENT_DATE - INTERVAL '15 days', 986.30, CURRENT_TIMESTAMP - INTERVAL '15 days'),
    (8, CURRENT_DATE - INTERVAL '7 days', 986.30, CURRENT_TIMESTAMP - INTERVAL '7 days'),
    (8, CURRENT_DATE - INTERVAL '1 day', 986.30, CURRENT_TIMESTAMP - INTERVAL '1 day'),
    
    -- Karan Malhotra (loan_id: 9)
    (9, CURRENT_DATE - INTERVAL '120 days', 986.30, CURRENT_TIMESTAMP - INTERVAL '120 days'),
    (9, CURRENT_DATE - INTERVAL '90 days', 888.22, CURRENT_TIMESTAMP - INTERVAL '90 days'),
    (9, CURRENT_DATE - INTERVAL '60 days', 790.14, CURRENT_TIMESTAMP - INTERVAL '60 days'),
    (9, CURRENT_DATE - INTERVAL '30 days', 790.14, CURRENT_TIMESTAMP - INTERVAL '30 days'),
    (9, CURRENT_DATE - INTERVAL '15 days', 790.14, CURRENT_TIMESTAMP - INTERVAL '15 days'),
    (9, CURRENT_DATE - INTERVAL '7 days', 790.14, CURRENT_TIMESTAMP - INTERVAL '7 days'),
    (9, CURRENT_DATE - INTERVAL '1 day', 790.14, CURRENT_TIMESTAMP - INTERVAL '1 day'),
    
    -- Deepak Joshi (loan_id: 10) - Nearly paid off
    (10, CURRENT_DATE - INTERVAL '60 days', 157.53, CURRENT_TIMESTAMP - INTERVAL '60 days'),
    (10, CURRENT_DATE - INTERVAL '30 days', 157.53, CURRENT_TIMESTAMP - INTERVAL '30 days'),
    (10, CURRENT_DATE - INTERVAL '15 days', 157.53, CURRENT_TIMESTAMP - INTERVAL '15 days'),
    (10, CURRENT_DATE - INTERVAL '7 days', 157.53, CURRENT_TIMESTAMP - INTERVAL '7 days'),
    (10, CURRENT_DATE - INTERVAL '1 day', 157.53, CURRENT_TIMESTAMP - INTERVAL '1 day'),
    
    -- Meera Nair (loan_id: 11) - Nearly paid off
    (11, CURRENT_DATE - INTERVAL '60 days', 210.62, CURRENT_TIMESTAMP - INTERVAL '60 days'),
    (11, CURRENT_DATE - INTERVAL '30 days', 210.62, CURRENT_TIMESTAMP - INTERVAL '30 days'),
    (11, CURRENT_DATE - INTERVAL '15 days', 210.62, CURRENT_TIMESTAMP - INTERVAL '15 days'),
    (11, CURRENT_DATE - INTERVAL '7 days', 210.62, CURRENT_TIMESTAMP - INTERVAL '7 days'),
    (11, CURRENT_DATE - INTERVAL '1 day', 210.62, CURRENT_TIMESTAMP - INTERVAL '1 day'),
    
    -- Arjun Rao (loan_id: 14) - Recent loan
    (14, CURRENT_DATE - INTERVAL '14 days', 2465.75, CURRENT_TIMESTAMP - INTERVAL '14 days'),
    (14, CURRENT_DATE - INTERVAL '13 days', 2465.75, CURRENT_TIMESTAMP - INTERVAL '13 days'),
    (14, CURRENT_DATE - INTERVAL '12 days', 2465.75, CURRENT_TIMESTAMP - INTERVAL '12 days'),
    (14, CURRENT_DATE - INTERVAL '11 days', 2465.75, CURRENT_TIMESTAMP - INTERVAL '11 days'),
    (14, CURRENT_DATE - INTERVAL '10 days', 2465.75, CURRENT_TIMESTAMP - INTERVAL '10 days'),
    (14, CURRENT_DATE - INTERVAL '9 days', 2465.75, CURRENT_TIMESTAMP - INTERVAL '9 days'),
    (14, CURRENT_DATE - INTERVAL '8 days', 2465.75, CURRENT_TIMESTAMP - INTERVAL '8 days'),
    (14, CURRENT_DATE - INTERVAL '7 days', 2465.75, CURRENT_TIMESTAMP - INTERVAL '7 days'),
    (14, CURRENT_DATE - INTERVAL '6 days', 2465.75, CURRENT_TIMESTAMP - INTERVAL '6 days'),
    (14, CURRENT_DATE - INTERVAL '5 days', 2465.75, CURRENT_TIMESTAMP - INTERVAL '5 days'),
    (14, CURRENT_DATE - INTERVAL '4 days', 2465.75, CURRENT_TIMESTAMP - INTERVAL '4 days'),
    (14, CURRENT_DATE - INTERVAL '3 days', 2465.75, CURRENT_TIMESTAMP - INTERVAL '3 days'),
    (14, CURRENT_DATE - INTERVAL '2 days', 2465.75, CURRENT_TIMESTAMP - INTERVAL '2 days'),
    (14, CURRENT_DATE - INTERVAL '1 day', 2465.75, CURRENT_TIMESTAMP - INTERVAL '1 day'),
    
    -- Kavita Menon (loan_id: 15) - Recent loan
    (15, CURRENT_DATE - INTERVAL '9 days', 1356.16, CURRENT_TIMESTAMP - INTERVAL '9 days'),
    (15, CURRENT_DATE - INTERVAL '8 days', 1356.16, CURRENT_TIMESTAMP - INTERVAL '8 days'),
    (15, CURRENT_DATE - INTERVAL '7 days', 1356.16, CURRENT_TIMESTAMP - INTERVAL '7 days'),
    (15, CURRENT_DATE - INTERVAL '6 days', 1356.16, CURRENT_TIMESTAMP - INTERVAL '6 days'),
    (15, CURRENT_DATE - INTERVAL '5 days', 1356.16, CURRENT_TIMESTAMP - INTERVAL '5 days'),
    (15, CURRENT_DATE - INTERVAL '4 days', 1356.16, CURRENT_TIMESTAMP - INTERVAL '4 days'),
    (15, CURRENT_DATE - INTERVAL '3 days', 1356.16, CURRENT_TIMESTAMP - INTERVAL '3 days'),
    (15, CURRENT_DATE - INTERVAL '2 days', 1356.16, CURRENT_TIMESTAMP - INTERVAL '2 days'),
    (15, CURRENT_DATE - INTERVAL '1 day', 1356.16, CURRENT_TIMESTAMP - INTERVAL '1 day');

-- Verify data counts
SELECT 'Loans Created:' as info, COUNT(*) as count FROM loan;
SELECT 'Repayments Created:' as info, COUNT(*) as count FROM repayment;
SELECT 'Interest History Records:' as info, COUNT(*) as count FROM interest_history;
SELECT 'Active Loans:' as info, COUNT(*) as count FROM loan WHERE loan_status = 'ACTIVE';
SELECT 'Closed Loans:' as info, COUNT(*) as count FROM loan WHERE loan_status = 'CLOSED';
