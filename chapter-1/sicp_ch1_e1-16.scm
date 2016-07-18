#!/usr/bin/csi -s
;; sicp_ch1_e1-16.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)


;;; Exercise 1.16.  Design a procedure that evolves an iterative exponentiation process that uses successive squaring and uses a logarithmic number of steps, as does fast-expt.  (Hint: Using the observation that (bn/2)2 = (b2)n/2, keep, along with the exponent n and the base b, an additional state variable a, and define the state transformation in such a way that the product a bn is unchanged from state to state. At the beginning of the process a is taken to be 1, and the answer is given by the value of a at the end of the process. In general, the technique of defining an invariant quantity that remains unchanged from state to state is a powerful way to think about the design of iterative algorithms.)

;; ==============================================================================
;; benchmark from book:
;;
;;           {  1              if n is zero
;;  f(x,n) = {  f(x,n/2)^2     if n is even, nonzero
;;           {  f(x,n-1)       if n is odd
;;

  (define (even? n)
    (= (remainder n 2) 0))

  (define (ref-fast-expt b n)
    (cond ((= n 0) 1)
      ((even? n) (square (ref-fast-expt b (/ n 2)) ))
        (else (* b (ref-fast-expt b (- n 1))) )))


;; ==============================================================================
;; propagating product up through recursion:
;;
;;             {  p              if n is zero
;;  f(x,n,p) = {  f(x,n/2,p)     if n is even, nonzero
;;             {  f(x,n-1,x*p)   if n is odd
;;

  (define (fast-expt-iter b n p)
    (cond ((= n 0) p)
      ((even? n) (fast-expt-iter (* b b) (/ n 2) p) )
        (else (fast-expt-iter b (- n 1) (* b p)) )))

  (define (sep-fast-expt b n)
    (fast-expt-iter b n 1))


;; ==============================================================================
;; encapsulated as a single function

  (define (fast-expt b n)
    ;;             {  p              if n is zero
    ;;  f(x,n,p) = {  f(x,n/2,p)     if n is even, nonzero
    ;;             {  f(x,n-1,x*p)   if n is odd
    (define (f b n p)
      (cond ((= n 0) p)
        ((even? n) (f (* b b) (/ n 2) p) )
          (else (f b (- n 1) (* b p)) )))
    (f b n 1) ; call
  )


;; ==============================================================================
;; applying self-referencing lambdas

  (define (sr-fast-expt b n)
    (define f (lambda (@f)
        (lambda (b n p)
          (cond ((= n 0) p )
                ((even? n) ((f f) (* b b) (/ n 2) p) )
                (else ((f f) b (- n 1) (* b p)) ))
        ) ; f(x,n)
    )) ; self
    ((f f) b n 1)
  )


;; ==============================================================================
;; with hygenic macros

 (define-syntax call
   (syntax-rules ()
     ((_ f)
       (f f))))

  (define-syntax fn
    (syntax-rules ()
      ((_ signature self fn-base fn-iter)
        (define signature 
          (define self (lambda (@self) fn-iter)) 
          fn-base
        ) ))) 

  (fn (mac-fast-expt b n) f
    ;; f(b,n,1)
    ((call f) b n 1)
    ;; f(b,n,p)
    (lambda (b n p) 
      (cond ((= n 0) p )
            ((even? n) ((call f) (* b b) (/ n 2) p) )
            (else ((call f) b (- n 1) (* b p)) ))
    ) ; f(x,n)
  )


;; ==============================================================================
;; test:
  (define b 2)
  (define n 8)

  (bar)
  (prn "intrinsic:")
  (prn (expt b n)) ;
  (hr)
  (prn "reference:")
  (prn (ref-fast-expt b n)) ;
  (hr)
  (prn "example 1-16: (separate functions)")
  (prn (sep-fast-expt b n)) ;
  (hr)
  (prn "example 1-16: (nested functions)")
  (prn (fast-expt b n)) ;
  (hr)
  (prn "example 1-16 (self-referencing lambdas):")
  (prn (sr-fast-expt b n)) ;
  (hr)
  (prn "example 1-16 (using macros):")
  (prn (mac-fast-expt b n) )
  (bar)

;; *EOF*
