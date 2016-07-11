#!/usr/bin/csi -s
;; sicp_ch1_e1-7.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; 1.3.1 Section:  Procedures as Arguments

  (define (cube x) (* x x x))
  (define (succ x) (+ x 1))

;; Consider the following three procedures. The first computes the sum of the integers from a through b:

  (define (sum-integers a b)
    (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))
    )
  )

  (prn (sum-integers 0 10) ) ; 55

;; The second computes the sum of the cubes of the integers in the given range:
  (define (sum-cubes a b)
    (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))
    )
  )

  (prn (sum-cubes 0 10) )     ; 3025

;;; Once we have sum, we can use it as a building block in formulating further concepts. For instance, the definite integral of a function f between the limits a and b can be approximated numerically using the formula
;;; for small values of dx. We can express this directly as a procedure:

  (define (sum term a next b)
    (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))
    )
  )

  (prn (sum cube 0 succ 10) ) ; 3025


  (define (integral f a b dx)
    (define (add-dx x) (+ x dx))
    (* (sum f (+ a (/ dx 2.0)) add-dx b) dx)
  )

 (prn (integral cube 0 1 0.01)  ) ; .24998750000000042 
 (prn (integral cube 0 1 0.001) ) ; .249999875000001

 ; (The exact value of the integral of cube between 0 and 1 is 1/4.)

;; *EOF*
