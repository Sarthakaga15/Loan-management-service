# Loan Management Service

Backend service for the Loan Management System built with Spring Boot 3.x and PostgreSQL.

## 🔗 Live Demo

**GitHub Repository**: https://github.com/Sarthakaga15/Loan-management-service

**Live API**: `https://your-app.railway.app` (Will be updated after Railway deployment)

**Example Endpoints** (Update after deployment):
- GET `https://your-app.railway.app/api/loans`
- GET `https://your-app.railway.app/api/loans/1`
- POST `https://your-app.railway.app/api/loans/1/repayments`

## 🚀 Deployment

See [DEPLOYMENT.md](DEPLOYMENT.md) for detailed instructions on deploying to Railway.app or Render.com.

## 📋 Prerequisites

- Java 17+
- Maven 3.8+
- PostgreSQL 14+

## 🛠️ Local Setup

### 1. Database Setup

1. Install PostgreSQL
2. Create a database named `loan_db`
3. Update credentials in `src/main/resources/application.properties`

```sql
CREATE DATABASE loan_db;
```

### 2. Configuration

Update `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/loan_db
spring.datasource.username=postgres
spring.datasource.password=your_password
```

### 3. Load Test Data

The service includes comprehensive test data with 15 diverse loan scenarios:

```bash
psql -U postgres -d loan_db -f src/main/resources/data.sql
```

This will create:
- **15 loans** (active, closed, high-value, education, business loans)
- **55 repayment records** (various payment patterns)
- **120+ interest history entries** (daily calculations)

### 4. Run Application

```bash
mvn spring-boot:run
```

The application will start on `http://localhost:8080`.

**Expected Startup Logs**:
```
========================================
Loan Management Service Started Successfully!
========================================
✓ Database connection established
✓ Daily interest calculation scheduler enabled
✓ Cron schedule: Daily at 00:00 UTC
✓ Health check endpoint: /actuator/health
========================================
Service is ready to accept requests
========================================
```

## 📚 API Documentation & Testing Guide

### Quick Start - Test All Features

Follow these steps to test all the assignment requirements:

#### 1. Check Service Health

```bash
curl http://localhost:8080/actuator/health
```

**Expected Response**: Database status should be "UP"

---

#### 2. Get All Loans (List View)

```bash
curl http://localhost:8080/api/loans
```

**What you'll see**: List of 15 loans with basic information
- Loan ID, Customer Name
- Original Amount, Principal Outstanding, Interest Outstanding
- Annual Interest Rate, Total Interest Accrued
- Loan Status (ACTIVE/CLOSED)
- Created/Updated timestamps

**Sample customers**: Rajesh Kumar, Priya Sharma, Amit Patel, Sunita Reddy, etc.

---

#### 3. Get Loan Details (Full Information)

```bash
curl http://localhost:8080/api/loans/1
```

**What you'll see**: Complete loan information including:
- All loan fields
- **Repayment History** (all payments made)
- **Interest History** (daily interest calculations)

Try different loan IDs (1-15) to see various scenarios:
- `loan_id=1` - Regular monthly payments
- `loan_id=4` - High-value loan (₹5M)
- `loan_id=10` - Nearly paid off
- `loan_id=12` - Fully closed loan

---

#### 4. Search Loans by Customer Name

```bash
curl "http://localhost:8080/api/loans/search?name=Kumar"
```

**What you'll see**: All loans matching "Kumar" (e.g., Rajesh Kumar)

Try other names:
- `name=Sharma`
- `name=Patel`
- `name=Reddy`

---

#### 5. Get Repayment History for a Loan

```bash
curl http://localhost:8080/api/loans/1/repayments
```

**What you'll see**: All repayments for loan #1, showing:
- Repayment ID, Amount
- Principal Portion, Interest Portion
- Running Balance after payment
- Payment Date

---

#### 6. Add a New Repayment

```bash
curl -X POST http://localhost:8080/api/loans/1/repayments \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 10000.00,
    "paymentDate": "2025-11-27"
  }'
```

**What happens**:
1. Interest is paid first from the amount
2. Remaining amount goes to principal
3. Loan outstanding balances are updated
4. If fully paid, loan status changes to "CLOSED"

**Response**: Details of the repayment created

---

#### 7. Get Interest Calculation History

```bash
curl http://localhost:8080/api/loans/1/interest-history
```

**What you'll see**: Daily interest calculations for the loan
- Interest Date
- Interest Amount (calculated daily)
- Shows how interest accumulates over time

---

#### 8. Manually Trigger Interest Calculation

```bash
curl -X POST http://localhost:8080/api/interest/run
```

**What happens**:
- Calculates interest for all ACTIVE loans
- For yesterday's date (as per requirement)
- Updates `interest_outstanding` and `total_interest_accrued`
- Creates entries in `interest_history` table

**Response**: Summary showing:
- Number of loans processed
- Total interest calculated
- Any errors encountered

---

### Complete API Reference

#### Loan APIs

| Method | Endpoint | Description | Response |
|--------|----------|-------------|----------|
| GET | `/api/loans` | Get all loans | List of loan summaries |
| GET | `/api/loans/{id}` | Get loan details | Full loan info with repayment & interest history |
| GET | `/api/loans/search?name={name}` | Search by customer name | Filtered loan list |

#### Repayment APIs

| Method | Endpoint | Description | Request Body |
|--------|----------|-------------|--------------|
| POST | `/api/loans/{loanId}/repayments` | Add a repayment | `{"amount": 10000.00, "paymentDate": "2025-11-27"}` |
| GET | `/api/loans/{loanId}/repayments` | Get repayment history | - |

#### Interest APIs

| Method | Endpoint | Description | Response |
|--------|----------|-------------|----------|
| POST | `/api/interest/run` | Manually trigger interest calculation | Calculation summary |
| GET | `/api/loans/{loanId}/interest-history` | Get interest history | List of daily interest entries |

#### Health Check API

| Method | Endpoint | Description | Response |
|--------|----------|-------------|----------|
| GET | `/actuator/health` | Check application & database health | Health status with details |

---

## ⏰ Daily Interest Calculation Scheduler

The application includes an **automated daily cron job** that:
- Runs at **00:00 UTC every day**
- Calculates interest for all ACTIVE loans
- Updates loan balances automatically
- Logs detailed execution metrics

**Cron Expression**: `0 0 0 * * ?`

**Sample Scheduler Logs**:
```
========================================
Starting scheduled daily interest calculation at 2025-11-27 00:00:00
========================================
Calculating interest for date: 2025-11-26
========================================
Scheduled interest calculation completed successfully!
Loans processed: 13
Total interest calculated: ₹45,234.56
Errors encountered: 0
Execution time: 1234 ms (1.234 seconds)
========================================
```

---

## 🎯 Assignment Requirements Verification

### ✅ All Required Features Implemented

1. **Loan Management**
   - ✅ View all loans with outstanding balances
   - ✅ View detailed loan information
   - ✅ Search loans by customer name

2. **Repayment Processing**
   - ✅ Add repayments with automatic allocation (interest first, then principal)
   - ✅ View repayment history
   - ✅ Automatic loan closure when fully paid

3. **Interest Calculation**
   - ✅ Daily interest calculation using formula: `(principal × rate / 100) / 365`
   - ✅ Automated daily cron job at midnight UTC
   - ✅ Manual trigger option via API
   - ✅ Interest history tracking

4. **Database & Health**
   - ✅ PostgreSQL database with proper schema
   - ✅ Database health check endpoint
   - ✅ Connection pooling with startup wait (60s)
   - ✅ Comprehensive test data (15 loans, 55 repayments, 120+ interest records)

---

## 🧪 Testing

Run unit tests:

```bash
mvn test
```

Build the project:

```bash
mvn clean compile
```

---

## 🏗️ Tech Stack

- **Framework**: Spring Boot 3.2.3
- **Database**: PostgreSQL
- **ORM**: Hibernate/JPA
- **Build Tool**: Maven
- **Java Version**: 17
- **Monitoring**: Spring Boot Actuator

---

## 📁 Project Structure

```
src/main/java/com/delcapital/loanmgmt/
├── controller/     # REST API endpoints
├── service/        # Business logic
├── repository/     # Database access
├── entity/         # JPA entities
├── dto/            # Data transfer objects
├── config/         # Configuration classes
├── scheduler/      # Scheduled tasks (daily interest calculation)
└── exception/      # Exception handling
```

---

## 🔍 Key Features

- **Automatic Interest Calculation**: Daily cron job calculates interest for all active loans
- **Smart Repayment Allocation**: Interest is paid first, then principal
- **Comprehensive Logging**: Detailed logs for scheduler execution and service startup
- **Health Monitoring**: Real-time database and application health status
- **Database Resilience**: Service waits for database to be ready (up to 60 seconds)
- **Rich Test Data**: 15 diverse loan scenarios for thorough testing

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request
