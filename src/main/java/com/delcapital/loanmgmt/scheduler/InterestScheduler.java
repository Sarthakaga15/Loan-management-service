package com.delcapital.loanmgmt.scheduler;

import com.delcapital.loanmgmt.dto.response.InterestCalculationResult;
import com.delcapital.loanmgmt.service.InterestCalculationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Component
@RequiredArgsConstructor
@Slf4j
public class InterestScheduler {

    private final InterestCalculationService interestService;
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    // Run daily at 00:00 UTC
    @Scheduled(cron = "0 0 0 * * ?", zone = "UTC")
    public void scheduleDailyInterestCalculation() {
        LocalDateTime startTime = LocalDateTime.now();
        log.info("========================================");
        log.info("Starting scheduled daily interest calculation at {}", startTime.format(DATE_FORMATTER));
        log.info("========================================");

        long executionStartMillis = System.currentTimeMillis();

        try {
            // Calculate for yesterday as interest accrues for the day passed
            LocalDate calculationDate = LocalDate.now().minusDays(1);
            log.info("Calculating interest for date: {}", calculationDate);

            InterestCalculationResult result = interestService.processAllLoans(calculationDate);

            long duration = System.currentTimeMillis() - executionStartMillis;
            log.info("========================================");
            log.info("Scheduled interest calculation completed successfully!");
            log.info("Loans processed: {}", result.getLoansProcessed());
            log.info("Total interest calculated: ₹{}", result.getTotalInterestCalculated());
            log.info("Errors encountered: {}", result.getErrors());
            log.info("Execution time: {} ms ({} seconds)", duration, duration / 1000.0);
            log.info("========================================");
        } catch (Exception e) {
            long duration = System.currentTimeMillis() - executionStartMillis;
            log.error("========================================");
            log.error("ERROR during scheduled interest calculation!");
            log.error("Error message: {}", e.getMessage());
            log.error("Execution time before failure: {} ms", duration);
            log.error("========================================", e);
        }
    }
}
