#!/usr/bin/csi -s
;; sicp_ch1_e1-3.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 1.3. Define a procedure that takes three numbers as arguments and returns the sum of the
;;; squares of the two larger numbers.

  ;; suares and sum
  (define (my-square x) (map (lambda (x) (* x x)) x) )
  (define (my-sum x) (apply + x) )

  ;; two methods for computing the sum of squares
  (define (ss-1 x) ((compose my-sum my-square) x))
  (define (ss-2 x) (apply + (map (lambda (x) (* x x )) x) ) )

  ;; selection N elements from a list
  (define (take x N) 
    (if (> N 1)
      (cons (car x) (take (cdr x) (- N 1))) 
      (list (car x))
    )
  )

  ;; selection for top N given operand
  (define (top x pred? N) (take (sort x pred?) N) )

  ;; sum of sqares for top 2 largest elements in list
  (define (topss-1 x) ((compose ss-2 (lambda (x) (top x > 2)) ) x))
  (define (topss-2 x) (ss-2 (top x > 2)) )

  ;; test solution
  (define x '(3 5 2 9 1) )

  (prn (topss-1 x) )
  (prn (topss-2 x) )

  (assert (= (ss-1 x) (ss-2 x) ) )
  (assert (= (ss-1 x) (ss-2 x) ) )
  (assert (= (topss-1 x) (topss-2 x) ) )
  (assert (= (topss-1 x) (topss-2 x) ) )

;; *EOF*
