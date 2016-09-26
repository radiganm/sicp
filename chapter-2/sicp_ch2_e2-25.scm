#!/usr/bin/csi -s
;; sicp_ch2_e2-25.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 2.25. Give combinations of cars and cdrs that will pick 7 from 
;;; each of the following lists:
;;;
;;;   (1 3 (5 7) 9)
;;;   ((7))
;;;   (1 (2 (3 (4 (5 (6 7))))))

  (define L1 '(1 3 (5 7) 9) )
  (define L2 '((7)) )
  (define L3 '(1 (2 (3 (4 (5 (6 7)))))) )

  (bar)
  (prnvar "L1" (car (cdaddr L1)))
  (prnvar "L2" (caar L2))
  (prnvar "L3" (car (cdr (cadr (cadr (cadr (cadr (cadr L3))))))))
  (br)
  (bar)

;; *EOF*
