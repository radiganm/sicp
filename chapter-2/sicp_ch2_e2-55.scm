#!/usr/bin/csi -s
;; sicp_ch2_e2-55.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 2.55. Eva Lu Ator types to the interpreter the expression (car 'abracadabra)
;;; To her surprise, the interpreter prints back quote. Explain.

  (bar)
  (prn (car ''abracadabra) )
  (hr)
  (prn "Quote constructs a non-modifiable list, whose contents are the literal arguments to quote.")
  (prn "The second quote is part of the literal quoted list.")
  (prn "Car returns the first element of the list, which itself is quote.")
  (bar)

;; *EOF*
