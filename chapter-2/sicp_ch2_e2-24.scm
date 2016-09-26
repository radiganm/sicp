#!/usr/bin/csi -s
;; sicp_ch2_e2-24.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 2.24. Suppose we evaluate the expression (list 1 (list 2 (list 3 4))). 
;;; Give the result printed by the interpreter, the corresponding box-and-pointer 
;;; structure, and the interpretation of this as a tree (as in figure 2.6). 


  (bar)
  (prn (list 1 (list 2 (list 3 4))))
  (bar)

;; *EOF*
