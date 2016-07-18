#!/usr/bin/csi -s
;; sicp_ch2_e2-46.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 2.46.  A two-dimensional vector v running from the 
;;; origin to a point can be represented as a pair consisting 
;;; of an x-coordinate and a y-coordinate. Implement a data 
;;; abstraction for vectors by giving a constructor make-vect 
;;; and corresponding selectors xcor-vect and ycor-vect. In 
;;; terms of your selectors and constructor, implement procedures 
;;; add-vect, sub-vect, and scale-vect that perform the operations 
;;; vector addition, vector subtraction, and multiplying a vector 
;;; by a scalar:

  (define (make-vect x y)
    (cons x y))

  (define (xcor-vect v)
    (car v))

  (define (ycor-vect v)
    (cdr v))

  (define (scale-vect v s)
    (make-vect (* s (xcor-vect v)) (* s (ycor-vect v)) ) )

  (define (add-vect v1 v2)
    (make-vect 
      (+ (xcor-vect v1) (xcor-vect v2)) 
      (+ (ycor-vect v1) (ycor-vect v2)) ) )

  (define (sub-vect v1 v2)
    (make-vect 
      (- (xcor-vect v1) (xcor-vect v2)) 
      (- (ycor-vect v1) (ycor-vect v2)) ) )

;; =======================================================
;; TESTS
;; =======================================================

  (define v1 (make-vect  1  2))
  (define v2 (make-vect  1  -4))

  (prnvar "v1   " v1)
  (prnvar "v2   " v2)
  (prnvar "v1.x " (xcor-vect v1))
  (prnvar "v1.y " (ycor-vect v1))
  (prnvar "v1   " (scale-vect v1 2))
  (prnvar "v1+v2" (add-vect v1 v2))
  (prnvar "v1-v2" (sub-vect v1 v2))

;; *EOF*
