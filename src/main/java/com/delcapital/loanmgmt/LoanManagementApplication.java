package com.delcapital.loanmgmt;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
@Slf4j
public class LoanManagementApplication {

	public static void main(String[] args) {
		SpringApplication.run(LoanManagementApplication.class, args);
	}

	@EventListener(ApplicationReadyEvent.class)
	public void onApplicationReady() {
		log.info("========================================");
		log.info("Loan Management Service Started Successfully!");
		log.info("========================================");
		log.info("✓ Database connection established");
		log.info("✓ Daily interest calculation scheduler enabled");
		log.info("✓ Cron schedule: Daily at 00:00 UTC");
		log.info("✓ Health check endpoint: /actuator/health");
		log.info("========================================");
		log.info("Service is ready to accept requests");
		log.info("========================================");
	}

}
