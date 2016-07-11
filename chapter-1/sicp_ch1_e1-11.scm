#!/usr/bin/csi -s
;; sicp_ch1_e1-1.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 1.11: A function f is defined by the rule that 
;;;
;;;      { n                      if n<3,
;;; f(n)={ f(n−1)+2f(n−2)+3f(n−3) if n≥3
;;;
;;; Write a procedure that computes f by means of a recursive process. Write a procedure that computes f by means of an iterative process.
;;; 

  ;; =======================================================
  ;; RECURSIVE
  ;; =======================================================

 ;;      { n                            if n<3
 ;; f(n)={ 
 ;;      { f(n−1) + 2f(n−2) + 3f(n−3)   otherwise

  ;; f(n) recursive form
  (define (f-recursive n)
    (if (< n 3) 
      n 
      (+ (f-recursive (- n 1)) (* 2 (f-recursive (- n 2)) ) (* 3 (f-recursive (- n 3)) ) )
    )
  )

  ;; =======================================================
  ;; DIRECT ITERATIVE
  ;; =======================================================

  ;; NB: f(n) = 1*f(n-1) + 2*f(n-2) + 3*f(n-3)
  ;;
  ;;       f(n) = s0
  ;;         state transition
  ;;           s0 <- s0 + 2*s1 + 3*s2
  ;;           s1 <- s0
  ;;           s2 <- s1


  ;; f(n) direct form
  (define (f-direct n)
    (f-direct-iter 2 1 0 n) ; initial state vector [ 0 1 2 ]
  )

  ;; f(n) direct form iteration step
  (define (f-direct-iter s0 s1 s2 n)
     (if (< n 3) 
       s0
       (f-direct-iter 
         (+ (* 1 s0) (* 2 s1) (* 3 s2) )
         s0 
         s1 
         (- n 1)
       ) ; next
     ) ; iteration test
  ) ; direct form

  ;; however, in general, f(n) can be thought of as:

  ;; =======================================================
  ;; Linear Feedback Shift Register (LFSR)
  ;; =======================================================

  ;; 1) Linear Feedback Shift Register (LFSR)
  ;;
  ;;   f[n] is a Linear Feedback Shift Register (LFSR) operating on the sequence of 
  ;;           previous integers up to n with initial register state x0 := [ 0 1 2 ]
  ;;           and polynomial coefficients given by a := [ 1 2 3 ]
  ;;
  ;;    x[k] = LFSR(x[k-1], a)
  ;;         = program { circshift(x), x_0 = <x,a> }
  ;;
  ;;    f(n) = CAR of x[n]
  ;;
  ;;   where
  ;;
  ;;     x[0] := [ 0 1 2 ]
  ;;
  ;;        a := [ 1 2 3 ]
  ;;


  ;; f(n) LFSR form
  (define (f-lfsr n)
    (let (
        (a  '(1 2 3)) ; coefficients    a := [ 1 2 3 ]
        (x0 '(2 1 0)) ; initial state  x0 := [ 0 1 2 ]
        (k  (- n 2))  ; k transitions   k := n - 2
      ) ; bindings
      (f-lfsr-iter x0 a k)
    ) ; let
  )

  ;; f(n) LFSR form iteration step
  (define (f-lfsr-iter x a k)
     (if (= k 0) 
       (car x)
       (f-lfsr-iter (lfsr x a) a (- k 1))
     )
  )

  ;; =======================================================
  ;; State Space Representation
  ;; =======================================================

  ;; 2) State Space Representaiton
  ;;
  ;;   f[n] is the effect of a system up to time n with a given state space
  ;;           representation F := [ 0 1 0 ; 0 0 1 ; 1  2 3 ], and with 
  ;;           initial conditions x0 := [ 0 1 2 ]
  ;;
  ;;    x[k] = F * x[k-1]
  ;;         = F * ( F * x[k-2] )
  ;;         = F * ( F * ( F * x[k-3] ) )
  ;;         = ...
  ;;         = F^n * x0
  ;;
  ;;    f(n) = x[n]
  ;;
  ;;   where
  ;;
  ;;     x[0] := [ 2 1 0 ]'
  ;;
  ;;             [ 1 2 3 ]
  ;;        F := [ 1 0 0 ]
  ;;             [ 0 1 0 ]
  ;;

  ;; version #1, using Iverson matrix representation

  (define (f-ss n)
    (let (
        (t_ref 2)     ; reference time relative to state space
        (x0 '(2 1 0)) ; initial state x0
        (F  '(1 2 3   
              1 0 0   
              0 1 0 ) 
        ) ; state transition matrix F
        (dimF '(3 3)) ; F is MxN = 3x3
        (dimX '(3 1)) ; X is Nx1 = 3x1
      ) ; bindings
      (car (f-ss-iter F dimF x0 dimX (- n t_ref)) )
    ) ; let
  )

  (define (f-ss-iter F dimF x dimX k)
    (if (< k 1) 
      x
      ;; x[k] = F * x[k-1]
      (f-ss-iter F dimF (mat-* F dimF x dimX) dimX (- k 1)) 
    ) ; each
  ) ; ff-ss-iter

  (define n 12)

  (prnvar "recursive f(n)" (f-recursive n) )  ; recursive
  (prnvar "   direct f(n)" (f-direct n) )     ; direct
  (prnvar "     LFSR f(n)" (f-lfsr n) )       ; LFSR
  (prnvar "       SS f(n)" (f-ss n) )         ; state space

;; *EOF*
