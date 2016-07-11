#!/usr/bin/csi -s
;; sicp_ch1_e1-2.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 1.2. Translate the following expression into prefix form
;;;
;;;  5 + 1/2 + (2 - (3 - (6 + 1/5) ) )
;;;  ---------------------------------
;;;     3 * ( 6 - 2 ) * ( 2 - 7 )


  (prn
    (/ 
      (+ 5 1/2 (- 2 (- 3 (+ 6 1/5) ) ) )
      (* 3 (- 6 2) (- 2 7) )
    )
  )

;; *EOF*
