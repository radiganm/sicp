#!/usr/bin/csi -s
;; sicp_ch1_e1-9.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 1.9: Each of the following two procedures defines a method for adding two positive integers in terms of the procedures inc, which increments its argument by 1, and dec, which decrements its argument by 1.

  (define (my-inc x) (begin (prn "inc") (+ x 1) ) ) ; inc with side effects
  (define (my-dec x) (begin (prn "dec") (- x 1) ) ) ; dec with side effects

  (define (recursive-+ a b)
    (if (= a 0) b (my-inc (recursive-+ (my-dec a) b))))

  (define (iterative-+ a b)
    (if (= a 0) b (iterative-+ (my-dec a) (my-inc b)))) ; proper tail recursion

;;; Using the substitution model, illustrate the process gener- ated by each procedure in evaluating (+ 4 5). 
;;; Are these processes iterative or recursive?

  (define a 4)
  (define b 5)

  (prnvar "a" a )
  (prnvar "b" b )
  (prnvar "recursive" (recursive-+ a b) ) ; recursive
  (prnvar "iterative" (iterative-+ a b) ) ; iterative

;; *EOF*
