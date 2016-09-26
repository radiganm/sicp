#!/usr/bin/csi -s
;; sicp_ch2_e2-4.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 2.5. Show that we can represent pairs of nonnegative integers 
;;; using only numbers and arithmetic operations if we represent the pair 
;;; a and b as the integer that is the product 2^a*3^b. Give the
;;; corresponding definitions of the procedures cons, car, and cdr. 

  (define (log2 x)
    (/ (log x) (log 2)))

  (define (log3 x)
    (/ (log x) (log 3)))

  ;; alternate cons
  (define (my-cons a b)
    (* (expt 2 a) (expt 3 b)))

;; =======================================================
;; TESTS
;; =======================================================

  (define a 4)
  (define b 5)
  (define p (my-cons a b))

  (bar)
  (prnvar "a" a)
  (prnvar "b" b)
  (prnvar "(cons 'a 'b)" p)
; (prnvar "(car (cons 'a 'b)" (my-car p))
; (prnvar "(cdr (cons 'a 'b)" (my-cdr p))
  (bar)

;; *EOF*
