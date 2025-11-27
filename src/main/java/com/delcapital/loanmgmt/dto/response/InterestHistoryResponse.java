package com.delcapital.loanmgmt.dto.response;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class InterestHistoryResponse {
    private Long id;
    private Long loanId;
    private LocalDate interestDate;
    private BigDecimal interestAmount;
}
