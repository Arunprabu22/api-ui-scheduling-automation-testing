-- V1__init.sql
-- Database schema for testpilot application
CREATE DATABASE IF NOT EXISTS testpilot CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE testpilot;

-- Example tables: test_suite, test_cases, test_executions, test_result, artifacts
CREATE TABLE IF NOT EXISTS test_suite (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    suite_xml_file VARCHAR(1024),
    description VARCHAR(2000),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS test_cases (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  test_suite_id BIGINT,
  test_case_id VARCHAR(100) NOT NULL, -- e.g., TC-UI-01
  name VARCHAR(255) NOT NULL,
  description TEXT,
  priority INT DEFAULT 0,
  type VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (test_suite_id) REFERENCES test_suites(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS test_execution (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    test_suite_id BIGINT,
    status VARCHAR(50),
    started_at TIMESTAMP NULL,
    ended_at TIMESTAMP NULL,
    total_tests INT DEFAULT 0,
    passed_tests INT DEFAULT 0,
    failed_tests INT DEFAULT 0,
    skipped_tests INT DEFAULT 0,
    CONSTRAINT fk_execution_suite FOREIGN KEY (test_suite_id) REFERENCES test_suite(id)
);


CREATE TABLE IF NOT EXISTS test_result (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    execution_id BIGINT,
    test_case_id VARCHAR(255),
    test_case_name VARCHAR(1024),
    status VARCHAR(50),
    start_time TIMESTAMP NULL,
    end_time TIMESTAMP NULL,
    duration_ms BIGINT,
    error_message TEXT,
    artifact_path VARCHAR(1024),
    CONSTRAINT fk_result_execution FOREIGN KEY (execution_id) REFERENCES test_execution(id)
);

CREATE TABLE IF NOT EXISTS artifacts(
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  execution_id BIGINT,
  test_result_id BIGINT,
  artifact_type VARCHAR(50),
  path VARCHAR(1024),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (execution_id) REFERENCES test_executions(id) ON DELETE CASCADE,
  FOREIGN KEY (test_result_id) REFERENCES test_results(id) ON DELETE CASCADE
);

-- optionally seed some suites/testcases for quick tests
INSERT INTO test_suites (name, description) VALUES
('BlazeDemo UI Suite', 'UI smoke tests for BlazeDemo'),
('ReqRes API Suite', 'API smoke tests for ReqRes');

-- NOTE: add any more DDL or seed data your original mysql_init.sql has
