#!/usr/bin/csi -s
;; y-combinator-normal.scm
;; Mac Radigan
;;
;; copied from http://mvanier.livejournal.com/2897.html

  (load "../library/util.scm")
  (import util)


  ;;; The lazy (normal-order) Y combinator

  (define Y 
    (lambda (f)
      ((lambda (x) (f (x x)))
       (lambda (x) (f (x x))))))

  (define almost-factorial
    (lambda (f)
      (lambda (n)
        (if (= n 0)
            1
            (* n (f (- n 1)))))))

  (define factorial (Y almost-factorial))

  (prn (factorial 6)) ; infinite loop

;; *EOF*
