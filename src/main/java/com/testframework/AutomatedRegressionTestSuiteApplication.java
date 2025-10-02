package com.testframework;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Main Spring Boot application class for the Automated Regression Test Suite Framework.
 * Enables asynchronous processing and scheduling for test execution management.
 */
@SpringBootApplication
@EnableAsync
@EnableScheduling
public class AutomatedRegressionTestSuiteApplication {

    public static void main(String[] args) {
        SpringApplication.run(AutomatedRegressionTestSuiteApplication.class, args);
    }
}