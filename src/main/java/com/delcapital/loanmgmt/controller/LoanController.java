package com.delcapital.loanmgmt.controller;

import com.delcapital.loanmgmt.dto.response.LoanDetailResponse;
import com.delcapital.loanmgmt.dto.response.LoanResponse;
import com.delcapital.loanmgmt.service.LoanService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/loans")
@RequiredArgsConstructor
public class LoanController {

    private final LoanService loanService;

    @GetMapping
    public ResponseEntity<List<LoanResponse>> getAllLoans() {
        return ResponseEntity.ok(loanService.getAllLoans());
    }

    @GetMapping("/{id}")
    public ResponseEntity<LoanDetailResponse> getLoanById(@PathVariable Long id) {
        return ResponseEntity.ok(loanService.getLoanById(id));
    }

    @GetMapping("/search")
    public ResponseEntity<List<LoanResponse>> searchLoans(@RequestParam String name) {
        return ResponseEntity.ok(loanService.searchLoansByCustomerName(name));
    }
}
