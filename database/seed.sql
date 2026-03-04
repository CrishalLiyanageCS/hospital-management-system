-- ============================================
-- Hospital Management System - Seed Data
-- ============================================

-- Admin user (password: admin123)
INSERT INTO users (name, email, password_hash, role) VALUES
('Admin User', 'admin@hospital.com', '$2b$12$placeholder_hash_admin', 'admin'),
('Dr. John Smith', 'john.smith@hospital.com', '$2b$12$placeholder_hash_doctor1', 'doctor'),
('Dr. Sarah Johnson', 'sarah.johnson@hospital.com', '$2b$12$placeholder_hash_doctor2', 'doctor'),
('Alice Brown', 'alice.brown@hospital.com', '$2b$12$placeholder_hash_patient1', 'patient'),
('Bob Wilson', 'bob.wilson@hospital.com', '$2b$12$placeholder_hash_patient2', 'patient'),
('Reception Staff', 'reception@hospital.com', '$2b$12$placeholder_hash_receptionist', 'receptionist');

-- Doctor profiles
INSERT INTO doctors (user_id, specialisation, license_number, department, phone) VALUES
(2, 'Cardiology', 'LIC-001-2024', 'Cardiology', '+94-11-123-4567'),
(3, 'Neurology', 'LIC-002-2024', 'Neurology', '+94-11-123-4568');

-- Patient profiles
INSERT INTO patients (user_id, date_of_birth, blood_type, address, phone, emergency_contact, emergency_phone) VALUES
(4, '1990-05-15', 'A+', '123 Main St, Colombo', '+94-77-123-4567', 'John Brown', '+94-77-123-4568'),
(5, '1985-08-22', 'O-', '456 Park Ave, Colombo', '+94-77-234-5678', 'Mary Wilson', '+94-77-234-5679');

-- Doctor schedules
INSERT INTO doctor_schedules (doctor_id, day_of_week, start_time, end_time) VALUES
(1, 'Monday', '09:00', '17:00'),
(1, 'Wednesday', '09:00', '17:00'),
(1, 'Friday', '09:00', '13:00'),
(2, 'Tuesday', '09:00', '17:00'),
(2, 'Thursday', '09:00', '17:00');

-- Sample appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, status, notes) VALUES
(1, 1, '2026-03-10', '10:00', 'confirmed', 'Regular checkup'),
(2, 2, '2026-03-11', '14:00', 'pending', 'Follow-up consultation');

-- Sample billing
INSERT INTO billing (patient_id, appointment_id, amount, status) VALUES
(1, 1, 2500.00, 'unpaid'),
(2, 2, 3000.00, 'unpaid');