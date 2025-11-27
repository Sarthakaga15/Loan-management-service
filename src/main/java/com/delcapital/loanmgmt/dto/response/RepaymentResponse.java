package com.delcapital.loanmgmt.dto.response;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class RepaymentResponse {
    private Long repaymentId;
    private Long loanId;
    private BigDecimal amount;
    private BigDecimal principalPortion;
    private BigDecimal interestPortion;
    private BigDecimal runningBalance;
    private LocalDate paymentDate;
}
