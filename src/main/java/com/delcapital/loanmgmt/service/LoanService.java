package com.delcapital.loanmgmt.service;

import com.delcapital.loanmgmt.dto.response.InterestHistoryResponse;
import com.delcapital.loanmgmt.dto.response.LoanDetailResponse;
import com.delcapital.loanmgmt.dto.response.LoanResponse;
import com.delcapital.loanmgmt.dto.response.RepaymentResponse;
import com.delcapital.loanmgmt.entity.InterestHistory;
import com.delcapital.loanmgmt.entity.Loan;
import com.delcapital.loanmgmt.entity.Repayment;
import com.delcapital.loanmgmt.exception.ResourceNotFoundException;
import com.delcapital.loanmgmt.repository.InterestHistoryRepository;
import com.delcapital.loanmgmt.repository.LoanRepository;
import com.delcapital.loanmgmt.repository.RepaymentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class LoanService {

    private final LoanRepository loanRepository;
    private final RepaymentRepository repaymentRepository;
    private final InterestHistoryRepository interestHistoryRepository;

    public List<LoanResponse> getAllLoans() {
        return loanRepository.findAll().stream()
                .map(this::mapToLoanResponse)
                .collect(Collectors.toList());
    }

    public LoanDetailResponse getLoanById(Long id) {
        Loan loan = loanRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Loan", "id", id));

        LoanDetailResponse response = mapToLoanDetailResponse(loan);

        List<Repayment> repayments = repaymentRepository.findByLoanOrderByPaymentDateDesc(loan);
        response.setRepaymentHistory(repayments.stream()
                .map(this::mapToRepaymentResponse)
                .collect(Collectors.toList()));

        List<InterestHistory> history = interestHistoryRepository.findByLoanOrderByInterestDateDesc(loan);
        response.setInterestHistory(history.stream()
                .map(this::mapToInterestHistoryResponse)
                .collect(Collectors.toList()));

        return response;
    }

    public List<LoanResponse> searchLoansByCustomerName(String name) {
        return loanRepository.findByCustomerNameContainingIgnoreCase(name).stream()
                .map(this::mapToLoanResponse)
                .collect(Collectors.toList());
    }

    private LoanResponse mapToLoanResponse(Loan loan) {
        LoanResponse response = new LoanResponse();
        response.setLoanId(loan.getLoanId());
        response.setCustomerName(loan.getCustomerName());
        response.setOriginalAmount(loan.getOriginalAmount());
        response.setPrincipalOutstanding(loan.getPrincipalOutstanding());
        response.setInterestOutstanding(loan.getInterestOutstanding());
        response.setAnnualInterestRate(loan.getAnnualInterestRate());
        response.setTotalInterestAccrued(loan.getTotalInterestAccrued());
        response.setLoanStatus(loan.getLoanStatus());
        response.setCreatedAt(loan.getCreatedAt());
        response.setUpdatedAt(loan.getUpdatedAt());
        return response;
    }

    private LoanDetailResponse mapToLoanDetailResponse(Loan loan) {
        LoanDetailResponse response = new LoanDetailResponse();
        response.setLoanId(loan.getLoanId());
        response.setCustomerName(loan.getCustomerName());
        response.setOriginalAmount(loan.getOriginalAmount());
        response.setPrincipalOutstanding(loan.getPrincipalOutstanding());
        response.setInterestOutstanding(loan.getInterestOutstanding());
        response.setAnnualInterestRate(loan.getAnnualInterestRate());
        response.setTotalInterestAccrued(loan.getTotalInterestAccrued());
        response.setLoanStatus(loan.getLoanStatus());
        response.setCreatedAt(loan.getCreatedAt());
        response.setUpdatedAt(loan.getUpdatedAt());
        return response;
    }

    private RepaymentResponse mapToRepaymentResponse(Repayment repayment) {
        RepaymentResponse response = new RepaymentResponse();
        response.setRepaymentId(repayment.getRepaymentId());
        response.setLoanId(repayment.getLoan().getLoanId());
        response.setAmount(repayment.getAmount());
        response.setPrincipalPortion(repayment.getPrincipalPortion());
        response.setInterestPortion(repayment.getInterestPortion());
        response.setRunningBalance(repayment.getRunningBalance());
        response.setPaymentDate(repayment.getPaymentDate());
        return response;
    }

    private InterestHistoryResponse mapToInterestHistoryResponse(InterestHistory history) {
        InterestHistoryResponse response = new InterestHistoryResponse();
        response.setId(history.getId());
        response.setLoanId(history.getLoan().getLoanId());
        response.setInterestDate(history.getInterestDate());
        response.setInterestAmount(history.getInterestAmount());
        return response;
    }
}
