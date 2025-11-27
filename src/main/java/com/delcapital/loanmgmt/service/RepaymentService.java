package com.delcapital.loanmgmt.service;

import com.delcapital.loanmgmt.dto.request.RepaymentRequest;
import com.delcapital.loanmgmt.dto.response.RepaymentResponse;
import com.delcapital.loanmgmt.entity.Loan;
import com.delcapital.loanmgmt.entity.Repayment;
import com.delcapital.loanmgmt.exception.ResourceNotFoundException;
import com.delcapital.loanmgmt.repository.LoanRepository;
import com.delcapital.loanmgmt.repository.RepaymentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RepaymentService {

    private final RepaymentRepository repaymentRepository;
    private final LoanRepository loanRepository;

    @Transactional
    public RepaymentResponse addRepayment(Long loanId, RepaymentRequest request) {
        Loan loan = loanRepository.findById(loanId)
                .orElseThrow(() -> new ResourceNotFoundException("Loan", "id", loanId));

        if (request.getAmount().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Repayment amount must be positive");
        }
        if (request.getPaymentDate().isAfter(LocalDate.now())) {
            throw new IllegalArgumentException("Payment date cannot be in the future");
        }

        BigDecimal amount = request.getAmount();
        BigDecimal interestOutstanding = loan.getInterestOutstanding();
        BigDecimal principalOutstanding = loan.getPrincipalOutstanding();

        // 1. Pay off interest first
        BigDecimal interestPortion = amount.min(interestOutstanding);
        BigDecimal remainingAmount = amount.subtract(interestPortion);

        // 2. Pay off principal with remainder
        BigDecimal principalPortion = remainingAmount.min(principalOutstanding);

        // 3. Update Loan
        BigDecimal newInterestOutstanding = interestOutstanding.subtract(interestPortion);
        BigDecimal newPrincipalOutstanding = principalOutstanding.subtract(principalPortion);

        loan.setInterestOutstanding(newInterestOutstanding);
        loan.setPrincipalOutstanding(newPrincipalOutstanding);

        if (newPrincipalOutstanding.compareTo(BigDecimal.ZERO) == 0
                && newInterestOutstanding.compareTo(BigDecimal.ZERO) == 0) {
            loan.setLoanStatus("CLOSED");
        }

        loanRepository.save(loan);

        // 4. Create Repayment
        Repayment repayment = new Repayment();
        repayment.setLoan(loan);
        repayment.setAmount(amount);
        repayment.setPrincipalPortion(principalPortion);
        repayment.setInterestPortion(interestPortion);
        repayment.setRunningBalance(newPrincipalOutstanding); // Running balance usually refers to principal outstanding
        repayment.setPaymentDate(request.getPaymentDate());

        repaymentRepository.save(repayment);

        return mapToRepaymentResponse(repayment);
    }

    public List<RepaymentResponse> getRepaymentHistory(Long loanId) {
        if (!loanRepository.existsById(loanId)) {
            throw new ResourceNotFoundException("Loan", "id", loanId);
        }
        return repaymentRepository.findByLoanLoanIdOrderByPaymentDateDesc(loanId).stream()
                .map(this::mapToRepaymentResponse)
                .collect(Collectors.toList());
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
}
