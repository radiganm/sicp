#!/usr/bin/csi -s
;; sicp_ch2_e2-21.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)
  (use sicp)

;;; Exercise 2.21. The procedure square-list takes a list of numbers as argument and returns a list
;;; of the squares of those numbers.
;;;
;;;   (square-list (list 1 2 3 4))
;;;     (1 4 9 16)
;;;
;;; Here are two different definitions of square-list. Complete both of them by filling in the missing
;;; expressions:
;;;
;;;   (define (square-list items)
;;;     (if (null? items)
;;;       nil
;;;     (cons <??> <??>)))
;;;
;;;   (define (square-list items)
;;;     (map <??> <??>))

  (define (square-list-1 items)
    (if (null? items)
      nil
      (cons (expt (car items) 2) (square-list-1 (cdr items)))
    )
  )

  (define (square-list-2 items)
    (map (lambda (x) (expt x 2)) items)
  )

  (define x (list 1 2 3 4))

  (bar)
  (prnvar "x" x)
  (hr)
  (prnvar "(square-list-1 x)" (square-list-1 x))
  (br)
  (prnvar "(square-list-2 x)" (square-list-2 x))
  (bar)

;; *EOF*
