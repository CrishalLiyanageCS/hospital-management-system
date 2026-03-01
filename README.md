# Hospital Management System

A full-stack enterprise-grade Hospital & Clinic Management System built with React, FastAPI, and PostgreSQL. Features patient records (EHR), appointment scheduling, doctor management, billing & invoicing, and secure role-based authentication.

---

## Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [How to Run](#how-to-run)
- [API Endpoints](#api-endpoints)
- [Role-Based Access](#role-based-access)
- [Database Schema](#database-schema)
- [Testing](#testing)

---

## Overview

This system digitalises core healthcare facility operations, allowing administrators, doctors, receptionists, and patients to interact through a unified platform. Built as a portfolio project demonstrating enterprise-level full-stack architecture with React on the frontend and FastAPI on the backend, connected to a PostgreSQL relational database with JWT-based authentication and role-based access control.

---

## Project Structure
```
hospital-management-system/
├── frontend/                        # React application (Vite + Tailwind CSS)
│   └── src/
│       ├── components/              # Reusable UI components
│       │   ├── common/              # Navbar, Sidebar, Modal, Table
│       │   ├── patient/             # PatientCard, PatientForm
│       │   ├── doctor/              # DoctorCard, DoctorSchedule
│       │   ├── appointment/         # AppointmentForm, Calendar
│       │   └── billing/             # InvoiceCard, BillingForm
│       ├── pages/                   # Full page views per role
│       │   ├── auth/                # Login, Register
│       │   ├── admin/               # AdminDashboard, ManageDoctors
│       │   ├── doctor/              # DoctorDashboard, MyPatients
│       │   ├── patient/             # PatientDashboard, BookAppointment
│       │   └── billing/             # BillingDashboard, InvoiceView
│       ├── context/                 # AuthContext, AppContext
│       ├── hooks/                   # useAuth, useFetch
│       ├── services/                # API call functions per module
│       └── utils/                   # formatDate, validateForm
│
├── backend/                         # FastAPI application (Python)
│   └── app/
│       ├── models/                  # SQLAlchemy database models
│       ├── schemas/                 # Pydantic validation schemas
│       ├── routers/                 # API route handlers
│       ├── services/                # Business logic layer
│       ├── middleware/              # JWT authentication middleware
│       └── utils/                   # Hashing, JWT, Email helpers
│
├── database/
│   ├── schema.sql                   # Table creation scripts
│   ├── seed.sql                     # Sample data for development
│   └── migrations/                  # Alembic migration files
│
└── README.md
```

---

## Features

### Patient Module
| Feature | Description |
|---|---|
| Patient Registration | Register patients with personal and medical details |
| Electronic Health Records | View full medical history, diagnoses, prescriptions |
| Medical History Timeline | Chronological view of all past consultations |

### Doctor Module
| Feature | Description |
|---|---|
| Doctor Profiles | Specialisation, department, license, working hours |
| Schedule Management | Define availability slots per day |
| Patient Assignment | View and manage assigned patients |

### Appointment Module
| Feature | Description |
|---|---|
| Appointment Booking | Patients book slots based on doctor availability |
| Conflict Detection | Prevents double-booking of the same doctor slot |
| Status Flow | Pending → Confirmed → Completed → Cancelled |
| Calendar View | Visual calendar for doctors to manage their schedule |

### Billing Module
| Feature | Description |
|---|---|
| Auto Invoice Generation | Invoice created automatically on appointment completion |
| Payment Tracking | Track Unpaid → Paid status per invoice |
| Billing History | Full payment history per patient |
| Print-Ready Layout | Invoice view formatted for printing |

### Admin Module
| Feature | Description |
|---|---|
| Dashboard Analytics | Total patients, doctors, appointments, revenue overview |
| Charts & Graphs | Visual stats using Recharts |
| Manage Users | Add, edit, remove doctors and staff |
| Role Management | Assign and update user roles |

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | React 18 + Vite + Tailwind CSS |
| Backend | FastAPI (Python 3.11) |
| Database | PostgreSQL + SQLAlchemy ORM |
| Authentication | JWT (JSON Web Tokens) + bcrypt |
| Migrations | Alembic |
| Testing | Pytest + HTTPX |
| Containerisation | Docker + Docker Compose |

---

## How to Run

### Prerequisites

- Python 3.11 or higher
- Node.js 18 or higher
- PostgreSQL 15 or higher
- Git

### 1. Clone the Repository
```bash
git clone https://github.com/CrishalLiyanageCS/hospital-management-system.git
cd hospital-management-system
```

### 2. Backend Setup
```bash
cd backend
python -m venv venv
venv\Scripts\activate        # Windows
source venv/bin/activate     # Mac/Linux

pip install -r requirements.txt
```

Create your `.env` file:
```bash
cp .env.example .env
```

Update `.env` with your database credentials:
```
DATABASE_URL=postgresql://username:password@localhost:5432/hospital_db
SECRET_KEY=your_secret_key_here
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
```

Run database migrations:
```bash
alembic upgrade head
```

Start the backend server:
```bash
uvicorn app.main:app --reload
```

Backend runs at: `http://localhost:8000`
API docs at: `http://localhost:8000/docs`

### 3. Frontend Setup
```bash
cd frontend
npm install
```

Create your `.env` file:
```bash
cp .env.example .env
```

Start the development server:
```bash
npm run dev
```

Frontend runs at: `http://localhost:5173`

---

## API Endpoints

### Authentication
| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/auth/register` | Register a new user |
| POST | `/api/auth/login` | Login and receive JWT token |

### Patients
| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/patients/` | List all patients (Admin) |
| GET | `/api/patients/{id}` | Get patient details |
| POST | `/api/patients/` | Register new patient |
| PUT | `/api/patients/{id}` | Update patient details |
| DELETE | `/api/patients/{id}` | Remove patient |

### Doctors
| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/doctors/` | List all doctors |
| GET | `/api/doctors/{id}` | Get doctor profile |
| POST | `/api/doctors/` | Add doctor (Admin only) |
| PUT | `/api/doctors/{id}` | Update doctor details |

### Appointments
| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/appointments/` | List appointments (role-filtered) |
| POST | `/api/appointments/` | Book new appointment |
| PUT | `/api/appointments/{id}` | Reschedule or update status |
| DELETE | `/api/appointments/{id}` | Cancel appointment |

### Medical Records
| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/records/{patient_id}` | Get patient medical records |
| POST | `/api/records/` | Add record (Doctor only) |

### Billing
| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/billing/{patient_id}` | Get patient invoices |
| POST | `/api/billing/` | Generate invoice |
| PUT | `/api/billing/{id}` | Update payment status |

---

## Role-Based Access

| Feature | Admin | Doctor | Patient | Receptionist |
|---|---|---|---|---|
| Manage doctors | ✅ | ❌ | ❌ | ❌ |
| View all patients | ✅ | ✅ | ❌ | ✅ |
| Book appointment | ✅ | ❌ | ✅ | ✅ |
| Add medical record | ❌ | ✅ | ❌ | ❌ |
| View own records | ❌ | ❌ | ✅ | ❌ |
| Generate invoice | ✅ | ❌ | ❌ | ✅ |
| View dashboard analytics | ✅ | ❌ | ❌ | ❌ |

---

## Database Schema
```
Users (id, name, email, password_hash, role, created_at)
    │
    ├── Patients (id, user_id, DOB, blood_type, address, emergency_contact)
    │       └── MedicalRecords (id, patient_id, doctor_id, diagnosis, prescription, date)
    │
    ├── Doctors (id, user_id, specialisation, license_no, department)
    │       └── DoctorSchedule (id, doctor_id, day, start_time, end_time)
    │
    ├── Appointments (id, patient_id, doctor_id, date, time, status, notes)
    │
    └── Billing (id, patient_id, appointment_id, amount, status, created_at)
```

---

## Testing

Backend tests are located in `backend/tests/`.

| Test File | What It Verifies |
|---|---|
| `test_patients.py` | Patient CRUD endpoints, validation, auth protection |
| `test_appointments.py` | Booking logic, conflict detection, status updates |
| `test_billing.py` | Invoice generation, payment status tracking |

### Run Tests
```bash
cd backend
pytest
```

### Run with coverage report
```bash
pytest --cov=app tests/
```

---

## Development Status

🚧 In active development — started March 2026

| Phase | Status |
|---|---|
| Project Setup | ✅ Complete |
| Authentication | 🔄 In Progress |
| Patient Module | ⏳ Pending |
| Doctor Module | ⏳ Pending |
| Appointment Module | ⏳ Pending |
| Medical Records | ⏳ Pending |
| Billing Module | ⏳ Pending |
| Admin Dashboard | ⏳ Pending |
| Testing & Deployment | ⏳ Pending |