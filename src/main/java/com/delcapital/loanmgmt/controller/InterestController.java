package com.delcapital.loanmgmt.controller;

import com.delcapital.loanmgmt.dto.response.InterestCalculationResult;
import com.delcapital.loanmgmt.dto.response.InterestHistoryResponse;
import com.delcapital.loanmgmt.entity.InterestHistory;
import com.delcapital.loanmgmt.repository.InterestHistoryRepository;
import com.delcapital.loanmgmt.service.InterestCalculationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class InterestController {

    private final InterestCalculationService interestCalculationService;
    private final InterestHistoryRepository interestHistoryRepository;

    @PostMapping("/interest/run")
    public ResponseEntity<InterestCalculationResult> runInterestCalculation() {
        return ResponseEntity.ok(interestCalculationService.processManually());
    }

    @GetMapping("/loans/{loanId}/interest-history")
    public ResponseEntity<List<InterestHistoryResponse>> getInterestHistory(@PathVariable Long loanId) {
        List<InterestHistory> history = interestHistoryRepository.findByLoanLoanIdOrderByInterestDateDesc(loanId);
        List<InterestHistoryResponse> response = history.stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }

    private InterestHistoryResponse mapToResponse(InterestHistory history) {
        InterestHistoryResponse response = new InterestHistoryResponse();
        response.setId(history.getId());
        response.setLoanId(history.getLoan().getLoanId());
        response.setInterestDate(history.getInterestDate());
        response.setInterestAmount(history.getInterestAmount());
        return response;
    }
}
