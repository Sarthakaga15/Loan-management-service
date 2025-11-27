package com.delcapital.loanmgmt.repository;

import com.delcapital.loanmgmt.entity.InterestHistory;
import com.delcapital.loanmgmt.entity.Loan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface InterestHistoryRepository extends JpaRepository<InterestHistory, Long> {
    List<InterestHistory> findByLoanOrderByInterestDateDesc(Loan loan);

    List<InterestHistory> findByLoanLoanIdOrderByInterestDateDesc(Long loanId);

    boolean existsByLoanAndInterestDate(Loan loan, LocalDate date);

    Optional<InterestHistory> findByLoanAndInterestDate(Loan loan, LocalDate date);
}
