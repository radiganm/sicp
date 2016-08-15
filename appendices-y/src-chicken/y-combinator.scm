#!/usr/bin/csi -s
;; y-combinator.scm
;; Mac Radigan
;;
;; copied from http://mvanier.livejournal.com/2897.html

  (load "../library/util.scm")
  (import util)


  ;;; Eliminating (most) explicit recursion (lazy version)

  (define Y
    (lambda (f)
      (f (Y f))))

  (define almost-factorial
    (lambda (f)
      (lambda (n)
        (if (= n 0)
            1
            (* n (f (- n 1)))))))

  (define factorial (Y almost-factorial))

  (prn (factorial 6)) ; infinite loop

;; *EOF*
