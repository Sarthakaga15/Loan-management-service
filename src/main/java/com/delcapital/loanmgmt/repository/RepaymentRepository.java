package com.delcapital.loanmgmt.repository;

import com.delcapital.loanmgmt.entity.Loan;
import com.delcapital.loanmgmt.entity.Repayment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RepaymentRepository extends JpaRepository<Repayment, Long> {
    List<Repayment> findByLoanOrderByPaymentDateDesc(Loan loan);

    List<Repayment> findByLoanLoanIdOrderByPaymentDateDesc(Long loanId);
}
