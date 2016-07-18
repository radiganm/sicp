#!/usr/bin/csi -s
;; sicp_ch2_e2-17.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 2.17.  Define a procedure last-pair that returns the list 
;;; that contains only the last element of a given (nonempty) list:

  (define (last-pair x)
    (if (null? x)
      #f ; case empty list
      (if (null? (cdr x))
         (car x)
         (last-pair (cdr x))
      )
    )
  )

;; =======================================================
;; TESTS
;; =======================================================

  (bar)
  (prnvar "(23 72 149 34)" (last-pair (list 23 72 149 34)) ) ; 34
  (prnvar "(            )" (last-pair (list)) )              ; #f
  (bar)

;; *EOF*
