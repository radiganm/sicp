#!/usr/bin/csi -s
;; sicp_ch2_e2-4.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 2.4. Here is an alternative procedural representation of 
;;; pairs. For this representation, verify that (car (cons x y)) yields 
;;; x for any objects x and y.

;;; What is the corresponding definition of cdr? (Hint: To verify that 
;;; this works, make use of the substitution model of section 1.1.5.) 

  ;; alternate cons
  (define (my-cons x y)
    (lambda (m) (m x y)))

  ;; alternate cdr
  (define (my-car z)
    (z (lambda (p q) p)))

  ;; alternate car
  (define (my-cdr z)
    (z (lambda (p q) q)))

;; =======================================================
;; TESTS
;; =======================================================

  (define p (my-cons 'a 'b))

  (bar)
  (prnvar "(cons 'a 'b)" p)
  (prnvar "(car (cons 'a 'b)" (my-car p))
  (prnvar "(cdr (cons 'a 'b)" (my-cdr p))
  (bar)

;; *EOF*
