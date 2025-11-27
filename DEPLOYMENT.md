# Deployment Guide: Railway.app

## 🚀 Quick Deploy Steps

### 1. Prepare Your GitHub Repository

```bash
cd "c:\Users\sarth\Downloads\Loan Management Service"

# Initialize git if not already done
git init
git add .
git commit -m "Prepare for deployment"

# Create GitHub repository and push
git remote add origin https://github.com/YOUR_USERNAME/loan-management-service.git
git branch -M main
git push -u origin main
```

### 2. Deploy to Railway

1. **Sign Up**: Go to [railway.app](https://railway.app) and sign in with GitHub
2. **New Project**: Click "New Project" → "Deploy from GitHub repo"
3. **Select Repo**: Choose `loan-management-service`
4. **Add Database**: Click "New" → "Database" → "Add PostgreSQL"

### 3. Configure Environment Variables

In Railway dashboard, go to your service → Variables tab:

```env
# Database (Railway auto-fills these from PostgreSQL service)
DATABASE_URL=postgresql://...
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=...

# CORS - Add your frontend URL
ALLOWED_ORIGINS=https://your-frontend.vercel.app,http://localhost:4200

# Spring Profile
SPRING_PROFILES_ACTIVE=prod
```

### 4. Deploy & Verify

Railway will automatically:
- Build your application
- Deploy to a public URL
- Provide HTTPS

**Your API will be available at**: `https://your-app.railway.app`

### 5. Load Test Data

```bash
# Get database connection string from Railway
# Connect and run data.sql
psql "postgresql://..." -f src/main/resources/data.sql
```

Or use Railway's built-in PostgreSQL client.

---

## 📋 Alternative: Render.com

### Quick Steps
1. Sign up at [render.com](https://render.com)
2. New → Web Service → Connect GitHub repo
3. Build Command: `mvn clean package -DskipTests`
4. Start Command: `java -Dserver.port=$PORT -Dspring.profiles.active=prod -jar target/loan-management-service-0.0.1-SNAPSHOT.jar`
5. Add PostgreSQL database from Render dashboard
6. Set environment variables (same as above)

---

## 🔧 Environment Variables Reference

| Variable | Description | Example |
|----------|-------------|---------|
| `DATABASE_URL` | PostgreSQL connection string | `postgresql://user:pass@host:5432/db` |
| `DATABASE_USERNAME` | Database username | `postgres` |
| `DATABASE_PASSWORD` | Database password | Auto-generated |
| `ALLOWED_ORIGINS` | Frontend URLs (comma-separated) | `https://app.vercel.app` |
| `SPRING_PROFILES_ACTIVE` | Spring profile | `prod` |
| `PORT` | Server port (auto-set by platform) | `8080` |

---

## ✅ Post-Deployment Checklist

- [ ] API is accessible at public URL
- [ ] Database connection works
- [ ] Test data loaded
- [ ] CORS configured for frontend
- [ ] All endpoints tested
- [ ] GitHub README updated with live URL

---

## 🌐 Update GitHub README

Add this to your README.md:

```markdown
## 🔗 Live Demo

**Backend API**: https://your-app.railway.app
**API Documentation**: https://your-app.railway.app/api/loans

### Example Endpoints
- GET https://your-app.railway.app/api/loans
- GET https://your-app.railway.app/api/loans/1
- POST https://your-app.railway.app/api/loans/1/repayments
```

---

## 🐛 Troubleshooting

### Build Fails
- Check Java version in `pom.xml` matches Railway (Java 17)
- Ensure `mvn clean package` works locally

### Database Connection Error
- Verify environment variables are set
- Check DATABASE_URL format
- Ensure PostgreSQL service is running

### CORS Error
- Add frontend URL to `ALLOWED_ORIGINS`
- Include protocol (https://)
- Restart service after changing env vars
