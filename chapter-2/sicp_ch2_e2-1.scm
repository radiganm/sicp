#!/usr/bin/csi -s
;; sicp_ch2_e2-1.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 2.1. Define a better version of make-rat that handles both positive and negative
;;; arguments. Make-rat should normalize the sign so that if the rational number is positive, both the
;;; numerator and denominator are positive, and if the rational number is negative, only the numerator is
;;; negative.

  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
      
  (define (equal-rat? x y)
    (= (* (numer x) (denom y))
       (* (numer y) (denom x))))

  (define (signum x)
    (if (> x 0) +1 -1) )

  (define (make-rat num denom)
    (cons (* (signum (* num denom)) (abs (/ num (gcd num denom)))) (abs (/ denom (gcd num denom)))) )

  (define (numer x)
    (car x))

  (define (denom x)
    (cdr x))

  (define x1 (make-rat  1  2))  ; x1 =  1/2
  (define x2 (make-rat  1  4))  ; x2 =  1/4
  (define x3 (make-rat  2  4))  ; x3 =  2/4
  (define x4 (make-rat -1  2))  ; x4 = -1/2
  (define x5 (make-rat  1 -4))  ; x5 = -1/4
  (define x6 (make-rat -2 -4))  ; x6 =  2/4

  (prvar "x1 = 1/2 " x1)  ;  1/2
  (prvar "x2 = 1/4 " x2)  ;  1/4
  (prvar "x3 = 2/4 " x3)  ;  2/4
  (prvar "x4 = -1/2 " x4) ; -1/2
  (prvar "x5 = -1/4 " x5) ; -1/4
  (prvar "x6 = 2/4 " x6)  ;  2/4

  (ck "x1*x2" equal-rat? (mul-rat x1 x2) (make-rat 1 8))  ;  1/2 *  1/4 = 1/8
  (ck "x1*x4" equal-rat? (mul-rat x1 x4) (make-rat -1 4)) ;  1/2 * -1/2 = 1/4
  (ck "x4*x5" equal-rat? (mul-rat x4 x5) (make-rat 1 8))  ; -1/2 * -1/4 = 1/8
  (ck "x5*x6" equal-rat? (mul-rat x5 x6) (make-rat -1 8)) ; -1/4 *  2/4 = -1/8

;; *EOF*
