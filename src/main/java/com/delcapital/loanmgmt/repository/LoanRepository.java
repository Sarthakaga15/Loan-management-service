package com.delcapital.loanmgmt.repository;

import com.delcapital.loanmgmt.entity.Loan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LoanRepository extends JpaRepository<Loan, Long> {
    List<Loan> findByLoanStatus(String status);

    List<Loan> findByCustomerNameContainingIgnoreCase(String name);

    List<Loan> findByLoanStatusAndCustomerNameContainingIgnoreCase(String status, String name);
}
