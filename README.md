# Loan Management Service

A Spring Boot REST API for managing loans, repayments, and automated daily interest calculations.

## 🚀 Live Demo

**Live API**: https://loan-management-services.up.railway.app

**GitHub Repository**: https://github.com/Sarthakaga15/Loan-management-service

### Quick Test

```bash
# Health Check
curl https://loan-management-services.up.railway.app/actuator/health

# Get All Loans
curl https://loan-management-services.up.railway.app/api/loans

# Get Specific Loan
curl https://loan-management-services.up.railway.app/api/loans/1
```

---

## 📋 API Endpoints

### Loans
- `GET /api/loans` - Get all loans
- `GET /api/loans/{id}` - Get loan details with repayment and interest history
- `GET /api/loans/search?customerName={name}` - Search loans by customer name

### Repayments
- `POST /api/loans/{loanId}/repayments` - Add a repayment
  ```json
  {
    "amount": 5000.00,
    "paymentDate": "2024-03-15"
  }
  ```
- `GET /api/loans/{loanId}/repayments` - Get repayment history

### Interest
- `POST /api/interest/calculate?date=2024-03-15` - Manually trigger interest calculation
- `GET /api/loans/{loanId}/interest-history` - Get interest calculation history

### Health
- `GET /actuator/health` - Application health status

---

## 🏗️ Application Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Client Applications                      │
│              (Postman, Frontend, Mobile App)                 │
└────────────────────────┬────────────────────────────────────┘
                         │ HTTP/REST
                         ▼
┌─────────────────────────────────────────────────────────────┐
│                    Spring Boot Application                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ Controllers  │  │   Services   │  │ Repositories │      │
│  │  (REST API)  │─▶│  (Business)  │─▶│     (JPA)    │      │
│  └──────────────┘  └──────────────┘  └──────┬───────┘      │
│                                              │               │
│  ┌──────────────────────────────────────────┘               │
│  │          Interest Scheduler                               │
│  │      (Cron: Daily at 00:00 UTC)                          │
│  └──────────────────────────────────────────┐               │
└────────────────────────────────────────────┼───────────────┘
                                              │ JDBC
                                              ▼
                                    ┌──────────────────┐
                                    │   PostgreSQL     │
                                    │    Database      │
                                    └──────────────────┘
```

### Key Components

1. **Controllers** - Handle HTTP requests and responses
   - `LoanController` - Loan operations
   - `RepaymentController` - Repayment processing
   - `InterestController` - Interest calculations

2. **Services** - Business logic layer
   - `LoanService` - Loan management
   - `RepaymentService` - Repayment allocation (interest first, then principal)
   - `InterestCalculationService` - Daily interest computation

3. **Repositories** - Data access layer (Spring Data JPA)
   - `LoanRepository`
   - `RepaymentRepository`
   - `InterestHistoryRepository`

4. **Scheduler** - Automated tasks
   - `InterestScheduler` - Runs daily at midnight UTC
   - Calculates interest for all active loans
   - Updates `interestOutstanding` and `totalInterestAccrued`

5. **Database** - PostgreSQL
   - `loan` - Loan records
   - `repayment` - Payment history
   - `interest_history` - Daily interest calculations

---

## 💻 Local Development

### Prerequisites
- Java 17+
- Maven 3.6+
- PostgreSQL 12+

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/Sarthakaga15/Loan-management-service.git
   cd Loan-management-service
   ```

2. **Configure database**
   
   Edit `src/main/resources/application.properties`:
   ```properties
   spring.datasource.url=jdbc:postgresql://localhost:5432/loan_db
   spring.datasource.username=postgres
   spring.datasource.password=your_password
   ```

3. **Create database**
   ```sql
   CREATE DATABASE loan_db;
   ```

4. **Build and run**
   ```bash
   mvn clean install
   mvn spring-boot:run
   ```

5. **Load test data** (optional)
   ```bash
   psql -U postgres -d loan_db -f src/main/resources/data.sql
   ```

6. **Access the application**
   - API: http://localhost:8080
   - Health: http://localhost:8080/actuator/health

---

## 🧪 Testing the API

### Example: Create a Repayment

```bash
curl -X POST https://loan-management-services.up.railway.app/api/loans/1/repayments \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 10000.00,
    "paymentDate": "2024-03-15"
  }'
```

### Example: Get Loan Details

```bash
curl https://loan-management-services.up.railway.app/api/loans/1
```

**Response:**
```json
{
  "loanId": 1,
  "customerName": "Rajesh Kumar",
  "principalAmount": 500000.00,
  "interestRate": 12.5,
  "principalOutstanding": 450000.00,
  "interestOutstanding": 15000.00,
  "totalInterestAccrued": 25000.00,
  "status": "ACTIVE",
  "repayments": [...],
  "interestHistory": [...]
}
```

---

## 📊 Business Logic

### Interest Calculation
- **Formula**: `Daily Interest = (Principal Outstanding × Annual Rate) / 365`
- **Frequency**: Calculated daily at 00:00 UTC
- **Accrual**: Added to `interestOutstanding` and `totalInterestAccrued`

### Repayment Allocation
1. **Interest First**: Payment applied to outstanding interest
2. **Principal Second**: Remaining amount reduces principal
3. **Status Update**: Loan marked as `CLOSED` when both are zero

### Example
```
Loan: ₹500,000 @ 12.5% annual interest
Daily Interest: (500,000 × 0.125) / 365 = ₹171.23

After 30 days:
- Interest Accrued: ₹5,136.99
- Repayment of ₹10,000:
  - ₹5,136.99 → Interest
  - ₹4,863.01 → Principal
- New Principal: ₹495,136.99
```

---

## 🛠️ Tech Stack

- **Framework**: Spring Boot 3.2.3
- **Language**: Java 17
- **Database**: PostgreSQL 16
- **ORM**: Hibernate/JPA
- **Build Tool**: Maven
- **Deployment**: Railway.app
- **Monitoring**: Spring Boot Actuator

---

## 📝 Database Schema

### Loan Table
```sql
CREATE TABLE loan (
    loan_id BIGSERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    principal_amount DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    principal_outstanding DECIMAL(15,2) NOT NULL,
    interest_outstanding DECIMAL(15,2) DEFAULT 0,
    total_interest_accrued DECIMAL(15,2) DEFAULT 0,
    disbursement_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'ACTIVE'
);
```

### Repayment Table
```sql
CREATE TABLE repayment (
    repayment_id BIGSERIAL PRIMARY KEY,
    loan_id BIGINT REFERENCES loan(loan_id),
    amount DECIMAL(15,2) NOT NULL,
    payment_date DATE NOT NULL,
    interest_paid DECIMAL(15,2) DEFAULT 0,
    principal_paid DECIMAL(15,2) DEFAULT 0
);
```

### Interest History Table
```sql
CREATE TABLE interest_history (
    history_id BIGSERIAL PRIMARY KEY,
    loan_id BIGINT REFERENCES loan(loan_id),
    interest_date DATE NOT NULL,
    interest_amount DECIMAL(15,2) NOT NULL,
    principal_outstanding DECIMAL(15,2) NOT NULL
);
```

---

## 📅 Scheduler Details

The application includes an automated scheduler that:
- **Runs**: Daily at 00:00 UTC
- **Calculates**: Interest for all `ACTIVE` loans
- **Updates**: `interestOutstanding` and `totalInterestAccrued`
- **Records**: Each calculation in `interest_history`
- **Logs**: Execution metrics (loans processed, total interest, duration)

---

## 🔍 Monitoring

Check application health:
```bash
curl https://loan-management-services.up.railway.app/actuator/health
```

Expected response:
```json
{
  "status": "UP",
  "components": {
    "db": {
      "status": "UP",
      "details": {
        "database": "PostgreSQL",
        "validationQuery": "SELECT 1"
      }
    }
  }
}
```

---

## 📄 License

This project is developed as part of a backend assessment.

---

## 👤 Author

**Sarthak Agarwal**
- GitHub: [@Sarthakaga15](https://github.com/Sarthakaga15)
- Repository: [Loan-management-service](https://github.com/Sarthakaga15/Loan-management-service)
