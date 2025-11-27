package com.delcapital.loanmgmt.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "interest_history", uniqueConstraints = {
        @UniqueConstraint(columnNames = { "loan_id", "interest_date" })
})
@Data
@NoArgsConstructor
@AllArgsConstructor
public class InterestHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "loan_id", nullable = false)
    private Loan loan;

    @NotNull
    @Column(name = "interest_date", nullable = false)
    private LocalDate interestDate;

    @NotNull
    @Column(name = "interest_amount", nullable = false, precision = 15, scale = 4)
    private BigDecimal interestAmount;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
