package com.delcapital.loanmgmt.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InterestCalculationResult {
    private int loansProcessed;
    private BigDecimal totalInterestCalculated;
    private int errors;
}
