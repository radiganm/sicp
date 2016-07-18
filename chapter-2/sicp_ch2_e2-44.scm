#!/usr/bin/csi -s
;; sicp_ch2_e2-44.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

  (use sicp)

;;; Exercise 2.44.  Define the procedure up-split used by corner-split. 
;;; It is similar to right-split, except that it switches the roles of below ;;; and beside.

  (define (up-split painter n)
    (if (= n 0)
      painter
      (let 
        ( (subimage (up-split painter (- n 1))) )
        (below painter (beside subimage subimage))
      )
    )
  )

  ;; =======================================================
  ;; TEST
  ;; =======================================================

  (bar)
  (prnvar "up-split lena.jpg" "../figures/sicp_ch2_e2-44.png")
    (write-painter-to-png (up-split 
      (image->painter "../figures/lena.jpg") 2) 
       "../figures/sicp_ch2_e2-44.png")
  (bar)

;; *EOF*
