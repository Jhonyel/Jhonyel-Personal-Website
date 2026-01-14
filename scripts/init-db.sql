-- PostgreSQL Database Initialization Script
-- This script runs automatically when the Docker container starts for the first time

-- Ensure the database exists (already handled by POSTGRES_DB env var)
-- This file can be used for additional initialization if needed

-- Create extensions if needed (uncomment if required)
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Set timezone
SET timezone = 'UTC';

-- Log successful initialization
DO $$
BEGIN
  RAISE NOTICE 'Database initialized successfully for Jhonyel Personal Website';
END $$;
