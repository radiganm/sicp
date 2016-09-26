#!/usr/bin/csi -s
;; sicp_ch2_e2-73.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)
  (use sicp)

;;; Exercise 2.73. Section 2.3.2 described a program that performs symbolic differentiation:
;;;
;;; (define (deriv exp var)
;;;   (cond ((number? exp) 0)
;;;     ((variable? exp) (if (same-variable? exp var) 1 0))
;;;     ((sum? exp)
;;;       (make-sum (deriv (addend exp) var)
;;;                 (deriv (augend exp) var)))
;;;       ((product? exp)
;;;          (make-sum
;;;          (make-product (multiplier exp)
;;;                        (deriv (multiplicand exp) var))
;;;          (make-product (deriv (multiplier exp) var)
;;;                        (multiplicand exp))))
;;;
;;;  <more rules can be added here>
;;;
;;;       (else (error "unknown expression type -- DERIV" exp))))


;;; We can regard this program as performing a dispatch on the type of the expression to be differentiated.
;;; In this situation the "type tag" of the datum is the algebraic operator symbol (such as +) and the
;;; operation being performed is deriv. We can transform this program into data-directed style by
;;; rewriting the basic derivative procedure as
;;;
;;;   (define (deriv exp var)
;;;    (cond ((number? exp) 0)
;;;      ((variable? exp) (if (same-variable? exp var) 1 0))
;;;      (else ((get 'deriv (operator exp)) (operands exp)
;;;        var))))
;;;   (define (operator exp) (car exp))
;;;   (define (operands exp) (cdr exp))

  (define (deriv expr var)
    (cond ((number? expr) 0)
      ((variable? expr) (if (same-variable? expr var) 1 0))
      (else ((get 'deriv (operator expr)) (operands expr) var))))

  (define (operator expr) (car expr))

  (define (operands expr) (cdr expr))


;;; a. Explain what was done above. Why can't we assimilate the predicates number? and
;;;    same-variable? into the data-directed dispatch?


;;; b. Write the procedures for derivatives of sums and products, and the auxiliary code required to install
;;;    them in the table used by the program above.

  (define (install-sum-package) 
    (define (addend expr) (car expr)) 
    (define (augend expr) (cadr expr)) 
    (define (make-sum a b) 
      (cond 
        ((eq? a 0) b) 
        ((eq? b 0) a) 
        ((and (number? a) (number? b)) (+ a b)) 
        (else (list '+ a b)) 
      ) 
    ) 
    ;; sum rule: fg = f' + g'
    (define (deriv-sum expr var) 
      (make-sum (deriv (addend expr) var) (deriv (augend expr) var)) 
    ) 
    (put 'deriv '+ deriv-sum) 
    'done
  ) 

  (define (install-product-package) 
    (define (multiplier expr) (car expr)) 
    (define (multiplicand expr) (cadr expr)) 
    (define (make-product a b) 
      (cond 
        ((or (eq? a 0) (eq? b 0)) 0) 
        ((eq? a 1) b) 
        ((eq? b 1) a) 
        ((and (number? a) (number? b)) (* a b)) 
        (else (list '* a b)) 
      ) 
    ) 
    (define (make-sum a b) 
      (cond 
        ((eq? a 0) b) 
        ((eq? b 0) a) 
        ((and (number? a) (number? b)) (+ a b)) 
        (else (list '+ a b)) 
      ) 
    ) 
    ;; product rule: fg = f g' + f' g
    (define (deriv-product expr var) 
      (make-sum 
        (make-product (multiplier expr) (deriv (multiplicand expr) var)) 
        (make-product (deriv (multiplier expr) var) (multiplicand expr) ) 
      ) 
    ) 
    (put 'deriv '* deriv-product) 
   'done
  ) 

  (install-sum-package) 
  (install-product-package) 

  (define dx 'x)

  (bar)
  (prn " b. Write the procedures for derivatives of sums and products, ")
  (prn "    and the auxiliary code required to install them in the table ")
  (prn "    used by the program above.")
  (hr)
  (define expr-1 '(* x x))
  (prn "e1 := (* x x)")
  (prnvar "d/dx e1" (deriv expr-1 dx))

  (hr)
  (define expr-2 '(+ (* x x) x))
  (prn "e2 := (+ (* x x) x)")
  (prnvar "d/dx e2" (deriv expr-2 dx))

  (hr)
  (define expr-3 '(* (+ (* x x) (* x z) ) (+ (* x y) (* x x)) ) )
  (prn "e3 := (* (+ (* x x) (* x z) ) (+ (* x y) (* x x)) )")
  (prnvar "d/dx e3" (deriv expr-3 dx))

;;; c. Choose any additional differentiation rule that you like, such as the one for exponents
;;;    (exercise 2.56), and install it in this data-directed system.

  (define (install-exponent-package) 
    (define (base expr) (car expr)) 
    (define (power expr) (cadr expr)) 
    (define (make-product a b) 
      (cond 
        ((or (eq? a 0) (eq? b 0)) 0) 
        ((eq? a 1) b) 
        ((eq? b 1) a) 
        ((and (number? a) (number? b)) (* a b)) 
        (else (list '* a b)) 
      ) 
    ) 
    (define (make-sum a b) 
      (cond 
        ((eq? a 0) b) 
        ((eq? b 0) a) 
        ((and (number? a) (number? b)) (+ a b)) 
        (else (list '+ a b)) 
      ) 
    ) 
    (define (make-exponent b p)
      (cond ((=number? p 0) 1)
        ((=number? p 1) b)
        (else (list '^ b p))
      )
    )
    ;
    ;   d(u^n)              du
    ;   ------  =  nu^(n-1) --
    ;     dx                dx
    ;
    (define (deriv-exponent expr var) 
       (make-product 
         (make-product (power expr)
                       (make-exponent (base expr) (- (power expr) 1)))
         (deriv (base expr) var)
       )
    ) 
    (put 'deriv '^ deriv-exponent) 
   'done
  ) 

  (install-exponent-package) 


  (bar)
  (prn " c. Choose any additional differentiation rule that you like, ")
  (prn "    such as the one for exponents (exercise 2.56), and install ")
  (prn "    it in this data-directed system.")
  (hr)
  (define expr-4 '(^ (* 2 x) 4) )
  (prn "e4 := (^ (* 2 x) 4) )")
  (prnvar "d/dx e4" (deriv expr-4 dx))
  (hr)
  (define expr-5 '(* 2 (^ x 4)) )
  (prn "e5 := (* 2 (^ x 4)) )")
  (prnvar "d/dx e5" (deriv expr-5 dx))

;;; d. In this simple algebraic manipulator the type of an expression is the algebraic operator that binds it
;;;    together. Suppose, however, we indexed the procedures in the opposite way, so that the dispatch line
;;;    in deriv looked like
;;;
;;;   ((get (operator exp) 'deriv) (operands exp) var)
;;;
;;; What corresponding changes to the derivative system are required? 

  (define (my-deriv expr var)
    (cond ((number? expr) 0)
      ((variable? expr) (if (same-variable? expr var) 1 0))
      (else ((get (my-operator expr) 'my-deriv) (my-operands expr) var))))

  (define (my-operator expr) (car expr))

  (define (my-operands expr) (cdr expr))

  (define (my-install-sum-package) 
    (define (addend expr) (car expr)) 
    (define (augend expr) (cadr expr)) 
    (define (make-sum a b) 
      (cond 
        ((eq? a 0) b) 
        ((eq? b 0) a) 
        ((and (number? a) (number? b)) (+ a b)) 
        (else (list '+ a b)) 
      ) 
    ) 
    ;; sum rule: fg = f' + g'
    (define (deriv-sum expr var) 
      (make-sum (my-deriv (addend expr) var) (my-deriv (augend expr) var)) 
    ) 
    (put '+ 'my-deriv deriv-sum) 
    'done
  ) 

  (define (my-install-product-package) 
    (define (multiplier expr) (car expr)) 
    (define (multiplicand expr) (cadr expr)) 
    (define (make-product a b) 
      (cond 
        ((or (eq? a 0) (eq? b 0)) 0) 
        ((eq? a 1) b) 
        ((eq? b 1) a) 
        ((and (number? a) (number? b)) (* a b)) 
        (else (list '* a b)) 
      ) 
    ) 
    (define (make-sum a b) 
      (cond 
        ((eq? a 0) b) 
        ((eq? b 0) a) 
        ((and (number? a) (number? b)) (+ a b)) 
        (else (list '+ a b)) 
      ) 
    ) 
    ;; product rule: fg = f g' + f' g
    (define (deriv-product expr var) 
      (make-sum 
        (make-product (multiplier expr) (my-deriv (multiplicand expr) var)) 
        (make-product (my-deriv (multiplier expr) var) (multiplicand expr) ) 
      ) 
    ) 
    (put '* 'my-deriv deriv-product) 
   'done
  ) 

  (bar)
  (prn " d.  Suppose, however, we indexed the procedures in the opposite")
  (prn "     way, so that the dispatch line in deriv looked like")
  (br)
  (prn "    ((get (operator exp) 'deriv) (operands exp) var)")
  (hr)
  (prn "(put '+ 'deriv deriv-sum)")
  (prn "(put '* 'deriv deriv-product)")
  (br)

; (hr)
; (prn "e1 := (* x x)")
; (prnvar "d/dx e1" (my-deriv expr-1 dx))

; (hr)
; (prn "e2 := (+ (* x x) x)")
; (prnvar "d/dx e2" (my-deriv expr-2 dx))

; (hr)
; (prn "e3 := (* (+ (* x x) (* x z) ) (+ (* x y) (* x x)) )")
; (prnvar "d/dx e3" (my-deriv expr-3 dx))
  (bar)
 
;; *EOF*
