#!/usr/bin/csi -s
;; sicp_ch3_e3-1.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

  (use sicp sicp-eval sicp-eval-anal sicp-streams)
  (load "./ch3support.scm")
; (load "./ch3.scm")


  ;; Exercise 3.1: An accumulator is a procedure that is called repeatedly 
  ;; with a single numeric argument and accumu- lates its arguments into a sum. 
  ;; Each time it is called, it returns the currently accumulated sum. Write a 
  ;; procedure make-accumulator that generates accumulators, each main- taining 
  ;; an independent sum. The input to make-accumulator should specify the initial 
  ;; value of the sum; for example
  ;;
  ;; (define A (make-accumulator 5))
  ;;
  ;; (A 10)
  ;; 15
  ;;
  ;; (A 10)
  ;; 25

  (define (make-accumulator n)
    (let ((acc n))
      (lambda (f) (set! acc (+ acc f)) acc)
    )
  )

  (bar)
  (define A (make-accumulator 5))
  (prnvar "acc+10" (A 10))
  (hr)
  (prnvar "acc+10" (A 10))
  (bar)
  
;; *EOF*
