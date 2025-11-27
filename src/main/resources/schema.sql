CREATE TABLE IF NOT EXISTS loan (
    loan_id BIGSERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    original_amount DECIMAL(15,2) NOT NULL,
    principal_outstanding DECIMAL(15,2) NOT NULL,
    interest_outstanding DECIMAL(15,2) DEFAULT 0,
    annual_interest_rate DECIMAL(5,2) NOT NULL,
    total_interest_accrued DECIMAL(15,2) DEFAULT 0,
    loan_status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_loan_customer_name ON loan(customer_name);
CREATE INDEX IF NOT EXISTS idx_loan_status ON loan(loan_status);

CREATE TABLE IF NOT EXISTS repayment (
    repayment_id BIGSERIAL PRIMARY KEY,
    loan_id BIGINT NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    principal_portion DECIMAL(15,2) NOT NULL,
    interest_portion DECIMAL(15,2) NOT NULL,
    running_balance DECIMAL(15,2) NOT NULL,
    payment_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_repayment_loan FOREIGN KEY (loan_id) REFERENCES loan(loan_id)
);

CREATE INDEX IF NOT EXISTS idx_repayment_loan_date ON repayment(loan_id, payment_date);

CREATE TABLE IF NOT EXISTS interest_history (
    id BIGSERIAL PRIMARY KEY,
    loan_id BIGINT NOT NULL,
    interest_date DATE NOT NULL,
    interest_amount DECIMAL(15,4) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_interest_loan FOREIGN KEY (loan_id) REFERENCES loan(loan_id),
    CONSTRAINT uq_loan_interest_date UNIQUE (loan_id, interest_date)
);

CREATE INDEX IF NOT EXISTS idx_interest_loan_date ON interest_history(loan_id, interest_date);
