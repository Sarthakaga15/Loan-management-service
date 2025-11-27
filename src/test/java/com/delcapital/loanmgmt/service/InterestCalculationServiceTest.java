package com.delcapital.loanmgmt.service;

import com.delcapital.loanmgmt.entity.Loan;
import com.delcapital.loanmgmt.repository.InterestHistoryRepository;
import com.delcapital.loanmgmt.repository.LoanRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;

@ExtendWith(MockitoExtension.class)
class InterestCalculationServiceTest {

    @Mock
    private LoanRepository loanRepository;

    @Mock
    private InterestHistoryRepository interestHistoryRepository;

    @InjectMocks
    private InterestCalculationService interestCalculationService;

    @Test
    void calculateDailyInterest_ShouldReturnCorrectAmount() {
        // Given
        Loan loan = new Loan();
        loan.setPrincipalOutstanding(new BigDecimal("10000.00"));
        loan.setAnnualInterestRate(new BigDecimal("12.00")); // 12%

        // When
        // Daily Rate = (12/100)/365 = 0.0003287671
        // Interest = 10000 * 0.0003287671 = 3.2877
        BigDecimal interest = interestCalculationService.calculateDailyInterest(loan);

        // Then
        assertEquals(new BigDecimal("3.2877"), interest);
    }

    @Test
    void calculateDailyInterest_ShouldReturnZero_WhenPrincipalIsZero() {
        Loan loan = new Loan();
        loan.setPrincipalOutstanding(BigDecimal.ZERO);
        loan.setAnnualInterestRate(new BigDecimal("12.00"));

        BigDecimal interest = interestCalculationService.calculateDailyInterest(loan);

        assertEquals(BigDecimal.ZERO, interest);
    }
}
