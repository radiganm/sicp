#!/usr/bin/csi -s
;; y-combinator-struct.scm
;; Mac Radigan
;;
;; copied from http://mvanier.livejournal.com/2897.html

  (load "../library/util.scm")
  (import util)


  ;;; The strict (applicative-order) Y combinator

  (define Y 
    (lambda (f)
      ((lambda (x) (x x))
       (lambda (x) (f (lambda (y) ((x x) y)))))))

  (define almost-factorial
    (lambda (f)
      (lambda (n)
        (if (= n 0)
            1
            (* n (f (- n 1)))))))

  (define (part-factorial self)
     (let ((f (lambda (y) ((self self) y))))
       (lambda (n)
         (if (= n 0)
           1 
           (* n (f (- n 1)))))))

  (define factorial (Y almost-factorial))

  (prn (factorial 6)) ; 720

;; *EOF*
