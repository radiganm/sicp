#!/usr/bin/csi -s
;; sicp_ch2_e2-54.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

;;; Exercise 2.54. Two lists are said to be equal? if they contain equal 
;;; elements arranged in the same order. For example,
;;; 
;;; (equal? '(this is a list) '(this is a list))
;;; 
;;; is true, but
;;; 
;;; (equal? '(this is a list) '(this (is a) list))
;;; 
;;; is false. To be more precise, we can define equal? recursively in terms of 
;;; the basic eq? equality of symbols by saying that a and b are equal? if 
;;; they are both symbols and the symbols are eq?, or if they are both lists 
;;; such that (car a) is equal? to (car b) and (cdr a) is equal? to (cdr b). 
;;; Using this idea, implement equal? as a procedure. 

  ;; =======================================================
  ;; NOT TAIL-RECURSIVE
  ;; =======================================================

  ;;
  ;;          { #f                                    if    s(a) and s(b)
  ;; f(a,b) = { a =?= b                               if    s(a) xor s(b)
  ;;          { f(car(a),car(b)) ^ f(cdr(a),cdr(b))   if !( s(a) and s(b) )
  ;;
  (define (my-equal-subopt? a b)
    (cond 
      ;;
      ;; case: null(a) ^ null(b) ->  #t  (null check)
      ;;
      ( (and (null? a) (null? b)) 
        #t )
      ;;
      ;; case: s(a) ^ s(b)       ->  #t
      ;;
      ( (and (symbol?   a) (symbol?   b)) 
        #t )
      ;;
      ;; case: s(a) xor s(b)     ->  a =?= b
      ;;
      (      (xor (symbol? a) (symbol? b)) 
        (eq? a b) )
      ;;
      ;; case: !( s(a)^s(b) )    ->  f( cdr(a), cdr(b) ) 
      ;;
      ;;       i.e. (not (and (symbol? a) (symbol? b))) 
      ;;
      ( else
        (and (eq? (car a) (car b)) (my-equal-subopt? (cdr a) (cdr b))) )
    )
  )

  ;; =======================================================
  ;; TAIL-RECURSIVE
  ;; =======================================================

  ;;
  ;;               { #f                                      if    s(a) and s(b)
  ;; f(a,b,p=#t) = { p ^ a =?= b                             if    s(a) xor s(b)
  ;;               { f(cdr(a), cdr(b), f(car(a),car(a),p))   if !( s(a) and s(b) )
  ;;
  (define (my-equal? a b)
    (define (f a b p)
      (cond 
        ;;
        ;; case: null(a) ^ null(b) ->  #t  (null check)
        ;;
        (      (and (null? a) (null? b) )
          #t )
        ;;
        ;; case: s(a) ^ s(b)        ->  #t
        ;;
        (      (and (symbol? a) (symbol? b)) 
          #t )
        ;;
        ;; case: s(a) xor s(b)      ->  a =?= b
        ;;
        (      (xor (symbol? a) (symbol? b)) 
          (eq? a b) )
        ;;
        ;; case: !( s(a)^s(b) )     ->  f( cdr(a), cdr(b) )
        ;;
        ( else
          (f (cdr a) (cdr b) (f (car a) (car b) p) ) )
      ) ;; cond
    )          ;; <= recur
    (f a b #t) ;; <= base
  )

  (bar)
  (prn "intrinsic:")
  (prn (equal? '(this is a list) '(this is a list))      )
  (prn (equal? '(this is a list) '(this (is a) list))    )
  (hr)
  (prn "example 2-54: (not tail-recursive)")
  (prn (my-equal-subopt? '(this is a list) '(this is a list))   )
  (prn (my-equal-subopt? '(this is a list) '(this (is a) list)) )
; (hr)
; (prn "example 2-54: (tail-recursive)")
; (prn (my-equal? '(this is a list) '(this is a list))   )
; (prn (my-equal? '(this is a list) '(this (is a) list)) )
  (bar)

;; *EOF*
