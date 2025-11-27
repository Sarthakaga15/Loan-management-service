package com.delcapital.loanmgmt.controller;

import com.delcapital.loanmgmt.dto.request.RepaymentRequest;
import com.delcapital.loanmgmt.dto.response.RepaymentResponse;
import com.delcapital.loanmgmt.service.RepaymentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/loans/{loanId}/repayments")
@RequiredArgsConstructor
public class RepaymentController {

    private final RepaymentService repaymentService;

    @PostMapping
    public ResponseEntity<RepaymentResponse> addRepayment(
            @PathVariable Long loanId,
            @Valid @RequestBody RepaymentRequest request) {
        return new ResponseEntity<>(repaymentService.addRepayment(loanId, request), HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<RepaymentResponse>> getRepaymentHistory(@PathVariable Long loanId) {
        return ResponseEntity.ok(repaymentService.getRepaymentHistory(loanId));
    }
}
