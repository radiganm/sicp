#!/usr/bin/csi -s
;; sicp_ch1_e1-42.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 1.42. Let f and g be two one-argument functions. The composition f after g is defined to be
;;; the function x f(g(x)). Define a procedure compose that implements composition. For example, if
;;; inc is a procedure that adds 1 to its argument,
;;; ((compose square inc) 6)

  ;;; from util.scm
  ; (define (square x) (map (lambda (x) (* x x)) x) )
  ; (define (inc x) (+ x 1))
  ; (define ((compose f g) x) (f (g x)))

  (prn ((compose square inc) 6) ) ; 49

;; *EOF*
