package com.delcapital.loanmgmt.dto.response;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

@Data
@EqualsAndHashCode(callSuper = true)
public class LoanDetailResponse extends LoanResponse {
    private List<RepaymentResponse> repaymentHistory;
    private List<InterestHistoryResponse> interestHistory;
}
