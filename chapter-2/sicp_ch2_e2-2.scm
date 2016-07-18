#!/usr/bin/csi -s
;; sicp_ch2_e2-2.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 2.2. Consider the problem of representing line segments in a plane. Each segment is
;;; represented as a pair of points: a starting point and an ending point. Define a constructor
;;; make-segment and selectors start-segment and end-segment that define the representation
;;; of segments in terms of points. Furthermore, a point can be represented as a pair of numbers: the x
;;; coordinate and the y coordinate. Accordingly, specify a constructor make-point and selectors
;;; x-point and y-point that define this representation. Finally, using your selectors and
;;; constructors, define a procedure midpoint-segment that takes a line segment as argument and
;;; returns its midpoint (the point whose coordinates are the average of the coordinates of the endpoints).
;;; To try your procedures, you'll need a way to print points:

  (define (print-point p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ",")
    (display (y-point p))
    (display ")")
    (newline)
  )

  ;; point construct
  (define (make-point x y)
    (cons x y))

  (define (x-point pt)
    (car pt))

  (define (y-point pt)
    (cdr pt))

  (define (equal-point? pt1 pt2)
    (and
      (= (x-point pt1) (x-point pt2))
      (= (y-point pt1) (y-point pt2))
    )
  )

  ;; segment construct
  (define (make-segment pt1 pt2)
    (cons pt1 pt2))

  (define (start-segment seg)
    (car seg))

  (define (end-segment seg)
    (cdr seg))

  (define (midpoint-segment seg)
    (make-point
      (/ (+ (x-point (start-segment seg)) (x-point (end-segment seg)) ) 2)
      (/ (+ (y-point (start-segment seg)) (y-point (end-segment seg)) ) 2)
    )
  )

  ;; test constructs
  (define pt-00 (make-point 0 0)) ; (0, 0) origin
  (define pt-10 (make-point 1 0)) ; (1, 0)
  (define pt-01 (make-point 0 1)) ; (0, 1)

  (define s-x  (make-segment pt-00 pt-10)) ; (0,0) -> (0,1)
  (define s-y  (make-segment pt-00 pt-01)) ; (0,0) -> (1,0)
  (define s-xy (make-segment pt-10 pt-01)) ; (1,0) -> (1,0)

  (define pt-mid (midpoint-segment s-xy)) ; (0.5,0.5)

  (print-point pt-mid)

  (ck "midpoint" equal-point? pt-mid (make-point 0.5 0.5)) ; -1/4 *  2/4 = -1/8

;; *EOF*
