package com.delcapital.loanmgmt.dto.response;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class LoanResponse {
    private Long loanId;
    private String customerName;
    private BigDecimal originalAmount;
    private BigDecimal principalOutstanding;
    private BigDecimal interestOutstanding;
    private BigDecimal annualInterestRate;
    private BigDecimal totalInterestAccrued;
    private String loanStatus;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
