#!/usr/bin/csi -s
;; sicp_ch2_e2-56.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 2.56.  Show how to extend the basic differentiator to handle more 
;;; kinds of expressions. For instance, implement the differentiation rule
;;;
;;;   d(u^n)           du
;;;   ------  =  nu^-1 --
;;;     dx             dx
;;;

  (define (deriv exp var)
    (cond ((number? exp) 0)
          ((variable? exp)
           (if (same-variable? exp var) 1 0))
          ((sum? exp)
           (make-sum (deriv (addend exp) var)
                     (deriv (augend exp) var)))
          ((product? exp)
           (make-sum
             (make-product (multiplier exp)
                           (deriv (multiplicand exp) var))
             (make-product (deriv (multiplier exp) var)
                           (multiplicand exp))))
          ;
          ;   d(u^n)           du
          ;   ------  =  nu^-1 --
          ;     dx             dx
          ;
          ((exponent? exp)
           (make-product 
             (make-product (power exp)
                           (make-exponent (base exp) (- (power exp) 1)))
             (deriv (base exp) var)))
          (else
           (error "unknown expression type -- DERIV" exp))))

  (define (variable? x) (symbol? x))

  (define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))
  
  (define (make-sum a1 a2) (list '+ a1 a2))

  (define (=number? exp num) (and (number? exp) (= exp num)))
  
  (define (make-product m1 m2) (list '* m1 m2))

  (define (make-exponent b p)
    (cond ((=number? p 0) 1)
          ((=number? p 1) b)
          (else '('^ b p))))

  (define (exponent? x) (eq? (car x) '^))

  (define (base x) (cadr x))
  (define (power x) (caddr x))
  
  (define (sum? x) (and (pair? x) (eq? (car x) '+)))
  
  (define (addend s) (cadr s))
  
  (define (augend s) (caddr s))
  
  (define (product? x)
    (and (pair? x) (eq? (car x) '*)))
  
  (define (multiplier p) (cadr p))
  
  (define (multiplicand p) (caddr p))
    
  (bar)
  (prnvar "d/dx (2x)^4" (deriv '(^ (* 2 x) 4) 'x))
  (bar)

;; *EOF*
