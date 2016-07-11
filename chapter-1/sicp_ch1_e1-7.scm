#!/usr/bin/csi -s
;; sicp_ch1_e1-7.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 1.7. The good-enough? test used in computing square roots will not be very effective for
;;; finding the square roots of very small numbers. Also, in real computers, arithmetic operations are
;;; almost always performed with limited precision. This makes our test inadequate for very large
;;; numbers. Explain these statements, with examples showing how the test fails for small and large
;;; numbers. An alternative strategy for implementing good-enough? is to watch how guess changes
;;; from one iteration to the next and to stop when the change is a very small fraction of the guess. Design
;;; a square-root procedure that uses this kind of end test. Does this work better for small and large
;;; numbers?

;;; benchmark implementation from book:

     (define (bm-sqrt-iter guess x)
       (new-if (good-enough? guess x)
       guess
       (bm-sqrt-iter (improve guess x)
       x)))
    
     (define (good-enough? guess x)
       (< (abs (- (square guess) x)) eps))
    
     (define (improve guess x)
       (average guess (/ x guess)))
    
     (define (average x y)
       (/ (+ x y) 2))
   
;;;  Many numerical methods exist for accurate square root computations 
;;;  with fast convergence.  Visit the literature for a complete survey. 
;;;  Here we are employing Newton's method for root finding, with having
;;;  "reasonable" convergence.


;;;  f(x) = x^2 - s = 0

;;;                   f(x[n])             x[n]^2 - s
;;;  x[n+1] = x[n] - ---------- = x[n] - -------------- = 1/2 (x[n] + s/x[n])
;;;                   f'(x[n])              2 x[n]

;;;     apply Newton's method:
;;;
;;;     f(x)  = x^2 - s = 0
;;;     f'(x) = 2*x
;;;
;;;     x in (a,b)
;;;     y in (f(a),f(b))
;;;
;;;     x[n+1] = x[n] - f(x)/f'(x)
;;;
;;;     initial conditions:
;;;       a = 0
;;;       b = x
;;;       c0 = (b-2)/2

;;;   C implemention:
;;;
;;;      double c = (x-0)/2;       // Choose any initial conditions
;;;                                // that satisfy Bolzano's theorem.
;;;                                // (b-a)/2 will work just fine
;;;      //
;;;      const double tol = 0.05;  // Set a convergence tolerance based
;;;                                // on your own personal tolerance for 
;;;                                // numerical error.  
;;;                                //
;;;                                // Currently I am favoring speed over 
;;;                                // precision.
;;;      //
;;;      double r = c*c - x;
;;;      while(r>tol) 
;;;      {
;;;        // x[n+1] = x[n] - f(x)/f'(x) = x[n] - (1/2) * (x[n] - s/x[n])
;;;        c = c - 0.5*(c-x/c);    // update prediction
;;;        r = c*c - x;            // find root
;;;      }
;;;      return c;

  (define tol 0.0001)

  (define (my-sqrt-iter x guess root)
    ;; x[n+1] = x[n] - f(x)/f'(x) = x[n] - (1/2) * (x[n] - s/x[n])
    (if (< root tol)
      guess ; return
      (let (
          (c (- guess (* 0.5 (- guess (/ x guess))))) ;; c = c - 0.5*(c-x/c);    // update prediction
          (r (- (* guess guess) x))                   ;; r = c*c - x;            // find root
        ) ; bind
        (my-sqrt-iter x c r) ; recursion
      ) ; let
    ) ; if
  ) ; my-sqrt-iter

  (define (my-sqrt x)
    (my-sqrt-iter x x x)
  ) ; my-sqrt

  (bar)
  (prn "intrinsic:")
  (prn (sqrt 9)                              ) ; 3.00009155413138
  (prn (sqrt (+ 100 37))                     ) ; 11.704699917758145
  (prn (sqrt (+ (sqrt 2) (sqrt 3)))          ) ; 1.7739279023207892
  (prn (square (sqrt 1000))                  ) ; 1000.000369924366
  (hr)
  (fmt "example 1-7: tolerance ~a~%" tol     ) ; tolerance 0.0001
  (prn (my-sqrt 9)                           ) ; 3.0
  (prn (my-sqrt (+ 100 37))                  ) ; 11.7046999107196
  (prn (my-sqrt (+ (my-sqrt 2) (my-sqrt 3))) ) ; 1.77377122818687
  (prn (square (my-sqrt 1000))               ) ; 1000.0
  (bar)

;; *EOF*
