#!/usr/bin/csi -s
;; sicp_ch4_e4-55.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

  (use sicp sicp-eval sicp-eval-anal sicp-streams)
  (load "./ch4-query.scm")
  (define false #f)
  (define true #t)

  (initialize-data-base microshaft-data-base)

;;; Exercise 4.55.  Give simple queries that retrieve the following information from the data base:
;;;   a. all people supervised by Ben Bitdiddle;
;;;   b. the names and jobs of all people in the accounting division;
;;;   c. the names and addresses of all people who live in Slumerville.

;; =======================================================
;; QUERY PROCESSOR
;; =======================================================

  (define (eval-query query)
    (let ((q (query-syntax-process query)))
      (cond ((assertion-to-be-added? q)
             (add-rule-or-assertion! (add-assertion-body q))
             (newline)
             (display "Assertion added to data base.")
             )
            (else
             (newline)
             (display output-prompt)
             ;; [extra newline at end] (announce-output output-prompt)
             (display-stream
              (stream-map
               (lambda (frame)
                 (instantiate q
                              frame
                              (lambda (v f)
                                (contract-question-mark v))))
               (qeval q (singleton-stream '()))))
             ))))
  
;; =======================================================
;; a. all people supervised by Ben Bitdiddle:
;; =======================================================
  (define query-a 
    '(supervisor ?person (Bitdiddle Ben)) )

;; =======================================================
;; b. the names and jobs of all people in the accounting division;
;; =======================================================
  (define query-b 
    '(job ?person (accounting . ?title)) )

;; =======================================================
;; c. the names and addresses of all people who live in Slumerville.
;; =======================================================
  (define query-c '(address ?person (Slumerville . ?address)) )

;; =======================================================
;; TESTS
;; =======================================================

  (bar)
  (prn "Query A. all people supervised by Ben Bitdiddle:")
  (eval-query query-a) (br) (hr)
  (prn "Query B. the names and jobs of all people in the accounting division:")
  (eval-query query-b) (br) (hr)
  (prn "Query C. the names and addresses of all people who live in Slumerville:")
  (eval-query query-c) (br)
  (bar)

;; *EOF*
