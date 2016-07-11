#!/usr/bin/csi -s
;; sicp_ch1_e1-1.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 1.1. Below is a sequence of expressions. What is the result printed by the interpreter in
;;; response to each expression? Assume that the sequence is to be evaluated in the order in which it is
;;; presented.

   (prn 10 )
   (prn (+ 5 3 4) )
   (prn (- 9 1) )
   (prn (/ 6 2) )
   (prn (+ (* 2 4) (- 4 6)) )

   (define a 3)
   (define b (+ a 1))

   (prn (+ a b (* a b)) )
   (prn (= a b) )

   (prn (if (and (> b a) (< b (* a b)))
     b
     a) )

   (prn (cond ((= a 4) 6)
     ((= b 4) (+ 6 7 a))
     (else 25)) )

   (prn (+ 2 (if (> b a) b a)) )

   (prn (* (cond ((> a b) a)
     ((< a b) b)
     (else -1))
     (+ a 1)) )
   
;; *EOF*
