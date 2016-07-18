#!/usr/bin/csi -s
;; sicp_ch2_e2-17.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 2.18.  Define a procedure reverse that takes a list as 
;;; argument and returns a list of the same elements in reverse order:

  ; ;; my-reverse
  ; (define (my-reverse x)
  ;   (if (null? x)
  ;     (list)
  ;     (append (my-reverse (cdr x)) (list (car x)))
  ;   )
  ; )

;; =======================================================
;; TESTS
;; =======================================================

  (bar)
  (prnvar "(1 4 9 16 25)" (my-reverse (list 1 4 9 16 25)) ) ; (25 16 9 4 1)
  (prnvar "(           )" (my-reverse (list)) )             ; #f
  (bar)

;; *EOF*
