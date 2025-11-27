package com.delcapital.loanmgmt.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "loan")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Loan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "loan_id")
    private Long loanId;

    @NotBlank
    @Column(name = "customer_name", nullable = false)
    private String customerName;

    @NotNull
    @DecimalMin(value = "0.0")
    @Column(name = "original_amount", nullable = false, precision = 15, scale = 2)
    private BigDecimal originalAmount;

    @NotNull
    @DecimalMin(value = "0.0")
    @Column(name = "principal_outstanding", nullable = false, precision = 15, scale = 2)
    private BigDecimal principalOutstanding;

    @NotNull
    @DecimalMin(value = "0.0")
    @Column(name = "interest_outstanding", precision = 15, scale = 2)
    private BigDecimal interestOutstanding = BigDecimal.ZERO;

    @NotNull
    @DecimalMin(value = "0.0")
    @Column(name = "annual_interest_rate", nullable = false, precision = 5, scale = 2)
    private BigDecimal annualInterestRate;

    @NotNull
    @DecimalMin(value = "0.0")
    @Column(name = "total_interest_accrued", precision = 15, scale = 2)
    private BigDecimal totalInterestAccrued = BigDecimal.ZERO;

    @Column(name = "loan_status", length = 20)
    private String loanStatus = "ACTIVE";

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "loan", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Repayment> repayments = new ArrayList<>();

    @OneToMany(mappedBy = "loan", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<InterestHistory> interestHistory = new ArrayList<>();

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (interestOutstanding == null)
            interestOutstanding = BigDecimal.ZERO;
        if (totalInterestAccrued == null)
            totalInterestAccrued = BigDecimal.ZERO;
        if (loanStatus == null)
            loanStatus = "ACTIVE";
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
