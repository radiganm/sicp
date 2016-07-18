#!/usr/bin/csi -s
;; sicp_ch4_e4-56.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

  (use sicp sicp-eval sicp-eval-anal sicp-streams)
  (load "./ch4-query.scm")
  (define false #f)
  (define true #t)

  (initialize-data-base microshaft-data-base)

;;; Exercise 4.56.  Formulate compound queries that retrieve the following information:
;;;       a. the names of all people who are supervised by Ben Bitdiddle, together with their addresses;
;;;       b. all people whose salary is less than Ben Bitdiddle's, together with their salary and Ben Bitdiddle's salary;
;;;       c. all people who are supervised by someone who is not in the computer division, together with the supervisor's name and job.

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
;; a. the names of all people who are supervised by 
;;    Ben Bitdiddle, together with their addresses
;; =======================================================
  (define query-a 
    '(and (supervisor (Bitdiddle Ben) ?person) 
          (address ?person ?address)
     ) ; conjunction
  ) ; query A

;; =======================================================
;; b. all people whose salary is less than Ben Bitdiddle's, 
;;    together with their salary and Ben Bitdiddle's salary
;; =======================================================

;;; TODO

  (define query-b 
    '(and (salary (Bitdiddle Ben) ?max-salary) 
          (salary ?person ?salary) 
     ) ; conjunction
  ) ; query B

; (define query-b 
;   '(and (salary (Bitdiddle Ben) ?max-salary) 
;         (salary ?person ?salary) 
;         (lisp-value < ?salary ?max-salary)
;    ) ; conjunction
; ) ; query B
;
;; =======================================================
;; c. all people who are supervised by someone who is not 
;;    in the computer division, together with the 
;;    supervisor's name and job.
;; =======================================================
  (define query-c 
    '(and (supervisor ?supervisor ?person) 
          (not (job ?supervisor (computer . ?supervisor-title)))
          (job ?supervisor ?supervisor-job)
     ) ; conjunction
  ) ; query C

;; =======================================================
;; TESTS
;; =======================================================

  (bar)
  (prn "Query A. the names of all people who are supervised by Ben Bitdiddle, together with their addresses")
  (eval-query query-a) (br) (hr)
  (prn "[TODO] Query B. all people whose salary is less than Ben Bitdiddle's, together with their salary and Ben Bitdiddle's salary")
  (eval-query query-b) (br) (hr)
  (prn "Query C. all people who are supervised by someone who is not in the computer division, together with the supervisor's name and job.")
  (eval-query query-c) (br)
  (bar)

;; *EOF*
