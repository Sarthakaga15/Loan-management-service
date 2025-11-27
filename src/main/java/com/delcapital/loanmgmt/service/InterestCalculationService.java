package com.delcapital.loanmgmt.service;

import com.delcapital.loanmgmt.dto.response.InterestCalculationResult;
import com.delcapital.loanmgmt.entity.InterestHistory;
import com.delcapital.loanmgmt.entity.Loan;
import com.delcapital.loanmgmt.repository.InterestHistoryRepository;
import com.delcapital.loanmgmt.repository.LoanRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class InterestCalculationService {

    private final LoanRepository loanRepository;
    private final InterestHistoryRepository interestHistoryRepository;

    public BigDecimal calculateDailyInterest(Loan loan) {
        if (loan.getPrincipalOutstanding().compareTo(BigDecimal.ZERO) <= 0 ||
                loan.getAnnualInterestRate().compareTo(BigDecimal.ZERO) <= 0) {
            return BigDecimal.ZERO;
        }

        // Formula: (principalOutstanding * annualInterestRate / 100) / 365
        BigDecimal dailyRate = loan.getAnnualInterestRate()
                .divide(BigDecimal.valueOf(100), 10, RoundingMode.HALF_UP)
                .divide(BigDecimal.valueOf(365), 10, RoundingMode.HALF_UP);

        return loan.getPrincipalOutstanding()
                .multiply(dailyRate)
                .setScale(4, RoundingMode.HALF_UP);
    }

    @Transactional
    public InterestCalculationResult processAllLoans(LocalDate date) {
        log.info("Starting interest calculation for date: {}", date);
        List<Loan> activeLoans = loanRepository.findByLoanStatus("ACTIVE");

        int processed = 0;
        int errors = 0;
        BigDecimal totalInterest = BigDecimal.ZERO;

        for (Loan loan : activeLoans) {
            try {
                if (interestHistoryRepository.existsByLoanAndInterestDate(loan, date)) {
                    log.info("Interest already calculated for loan {} on date {}", loan.getLoanId(), date);
                    continue;
                }

                BigDecimal dailyInterest = calculateDailyInterest(loan);

                if (dailyInterest.compareTo(BigDecimal.ZERO) > 0) {
                    InterestHistory history = new InterestHistory();
                    history.setLoan(loan);
                    history.setInterestDate(date);
                    history.setInterestAmount(dailyInterest);
                    interestHistoryRepository.save(history);

                    loan.setTotalInterestAccrued(loan.getTotalInterestAccrued().add(dailyInterest));
                    loan.setInterestOutstanding(loan.getInterestOutstanding().add(dailyInterest));
                    loanRepository.save(loan);

                    totalInterest = totalInterest.add(dailyInterest);
                    processed++;
                }
            } catch (Exception e) {
                log.error("Error calculating interest for loan {}: {}", loan.getLoanId(), e.getMessage());
                errors++;
            }
        }

        log.info("Interest calculation completed. Processed: {}, Total Interest: {}, Errors: {}", processed,
                totalInterest, errors);
        return new InterestCalculationResult(processed, totalInterest, errors);
    }

    public InterestCalculationResult processManually() {

        return processAllLoans(LocalDate.now().minusDays(1)); // Calculate for yesterday as per requirement
    }
}
