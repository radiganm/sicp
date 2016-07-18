#!/usr/bin/csi -s
;; sicp_ch2_e2-45.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

  (use sicp)

;;; Exercise 2.45.  Right-split and up-split can be expressed as 
;;; instances of a general splitting operation. Define a procedure 
;;; split with the property that evaluating
;;;
;;;   (define right-split (split beside below))
;;;   (define up-split (split below beside))
;;;
;;; produces procedures right-split and up-split with the same 
;;; behaviors as the ones already defined.

  (define (split dir1 dir2)
    (lambda (painter n)
      (if (= n 0)
        painter
        (let 
          ( (subimage ((split dir1 dir2) painter (- n 1))) )
          (dir1 painter (dir2 subimage subimage))
        ) ; let
      ) ; if
    ) ; lambda
  ) ; split

  (define right-split (split beside below))

  (define up-split (split below beside))

  ;; =======================================================
  ;; TEST
  ;; =======================================================

  (bar)
  (prnvar "right-split lena.jpg" "../figures/sicp_ch2_e2-45_right.png")
    (write-painter-to-png (right-split 
      (image->painter "../figures/lena.jpg") 2) 
       "../figures/sicp_ch2_e2-45_right.png")
  (hr)
  (prnvar "up-split lena.jpg" "../figures/sicp_ch2_e2-45_up.png")
    (write-painter-to-png (up-split 
      (image->painter "../figures/lena.jpg") 2) 
       "../figures/sicp_ch2_e2-45_up.png")
  (bar)

;; *EOF*
