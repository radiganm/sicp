#!/usr/bin/csi -s
;; util.scm
;; Mac Radigan

  (module util (
      bind
      bar
      bin
      br
      but-last
      ck
      compose
      dec
      dotprod
      flatmap
      fmt
      hr
      hex
      inc
      my-iota
      join
      kron-comb
      lfsr
      mat-*
      mat-col
      mat-row
      mod
      my-last
      nth
      oct
      permute
      pr 
      prn 
      prnvar
      my-reverse
      range
      rotate-right
      rotate-left
      rotate
      square
      sum
      xor
      Y
      Y-normal
      Y2
      yeild
    )
    (import scheme chicken)
    (use extras)
    (use srfi-1)

    ;;; debug, formatted printing, and assertions
    (define (br) 
      (format #t "~%"))

    (define (pr x) 
      (format #t "~a" x))

    (define (fmt s x) 
      (format #t s x))

    (define (prn x) 
      (format #t "~a~%" x))

    (define (prnvar name value) 
      (format #t "~a := ~a~%" name value))

    (define (ck name pred? value expect) 
      (cond 
        ( (not (pred? value expect)) (format #t "~a = ~a   ; fail expected ~a~%" name value expect) )
      )
      (assert (pred? value expect))
      (format #t "~a = ~a   ; ok: expected ~a~%" name value expect)
    ) ; ck

    ;;; numeric formatting
    (define (hex x)  (format #t "~x~%" x))
    (define (bin x)  (format #t "~b~%" x))
    (define (oct x)  (format #t "~o~%" x))

    ;;; delimiters
    (define (bar)    (format #t "~a~%" (make-string 80 #\=)))
    (define (hr)     (format #t "~a~%" (make-string 80 #\-)))

    ;;; returns the nth element of list x
    (define (nth x n)
      (if (= n 1)
        (car x)
        (nth (cdr x) (- n 1))
      ) ; if last iter
    ) ; nth

    ;;; returns the inner product <u,v>
    (define (dotprod u v)
      (apply + (map * u v))
    )

    ;;; returns x mod n
    (define (mod x n)
      (- x (* n (floor (/ x n))))
    )

    ;;; the permutation x by p
    (define (permute x p)
      (map (lambda (pk) (nth x pk)) p)
    )

    ;;; circular shift (left) of x by n
    (define (rotate-left x n)
      (if (< n 1)
        x
        (rotate-left (append (cdr x) (list (car x))) (- n 1))
      ) ; if last iter
    ) ; rotate-left

    ;;; circular shift (right) of x by n
    (define (rotate-right x n)
      (if (< n 1)
        x
        (rotate-right 
          (append (list (my-last x)) (but-last x)) 
          (- n 1)
        ) ; call
      ) ; if last iter
    ) ; rotate-right

    ;;; circular shift of x by n
    (define (rotate x n)
      (cond 
        ((= n 0) x)
        ((> n 0) (rotate-right x n))
        ((< n 0) (rotate-left x (abs n)))
      )
    )

    ;;; return all but last element in list
    (define (but-last x)
      (if (null? x)
        (list)
        (if (null? (cdr x))
          (list)
          (cons (car x) (but-last (cdr x)))
        ) ; end if list contains only one element
      ) ; end if list null
    )

    ;;; return the last element in list
    (define (my-last x)
      (if (null? x)
        #f
        (if (null? (cdr x))
          (car x)
          (my-last (cdr x))
        ) ; end if list contains only one element
      ) ; end if list null
    )

    ;; composition
    (define ((compose f g) x) (f (g x)))

    ;; my-reverse
    (define (my-reverse x)
      (if (null? x)
        (list)
        (append (my-reverse (cdr x)) (list (car x)))
      )
    )

    ;; Linear Feedback Shift Register (LFSR)
    ;;   given initial state x[k-1] and coefficients a
    ;;   return next state x[k]
    (define (lfsr x a)
      (append (list (dotprod x a)) (cdr (rotate x +1)) ) ; next state x[k]
    ) ; lfsr

    ;; matrix multiplication of column-major Iverson matrices
    (define (mat-* A dimA B dimB)
      (let (
          ; A_mxn * B_nxk = C_nxk
          (M_rows (cadr dimA) ) ; M_rows
          (N_cols (cadr dimB) ) ; N_cols
        ) ; local bindings
        (map (lambda (rc) 
            (dotprod (mat-row A dimA (car rc)) (mat-col B dimB (cadr rc)) ) 
          ) 
          (kron-comb (my-iota N_cols) (my-iota M_rows))
        )
      ) ; let
    ) ; mat-*

    ;; selects the kth column from a column-major Iverson matrix
    ;;   NB:  dim is a pair ( M_rows , N_cols )
    (define (mat-col A dim k)
      (let (
          (start  k          ) ; start  := kth column
          (stride (cadr dim) ) ; stride := N_cols
          (M_rows (car dim)  ) ; M_rows
          (N_cols (cadr dim) ) ; N_cols
        ) ; local bindings
        (choose A (range start stride M_rows))
      ) ; let
    ) ; mat-col

    ;; selects the kth column from a column-major Iverson matrix
    ;;   NB:  dim is a pair ( M_rows , N_cols )
    (define (mat-row A dim k)
      (let (
          (start  (* k (cadr dim))      ) ; start  := (kth row -1) * M_rows
          (stride 1                     ) ; stride := 1
          (M_rows (car dim)             ) ; M_rows
          (N_cols (cadr dim)            ) ; N_cols
        ) ; local bindings
        (choose A (range start stride N_cols))
      ) ; let
    ) ; mat-col

    ;; flatmap (map flattened by one level)
    (define (flatmap f x)
      (apply append (map f x))
    ) ; flatmap

    ;; Kroneker combination of vectors a and b
    (define (kron-comb a b)
      (flatmap (lambda (ak) (map (lambda (bk) (list ak bk)) a)) b)
    ) ; kron-comb

    ;; returns a list with elements of x taken from positions ns
    (define (choose x ns)
      (map (lambda (k) (list-ref x k)) ns )
    )

    ;; range sequence generator
    (define (range start step n)
      (range-iter '() start step n)
    )

    ;; Iverson's iota: zero-based sequence of integers from 0..N
    (define (my-iota n)
      (range 0 1 n)
    )

    ;; local scope: range sequence generator helper
    (define (range-iter x val step n)
      (if (< n 1)
        x
        (range-iter (append x (list val)) (+ val step) step (- n 1) ) ; x << val + step
      )
    )

    ;; exclusive or
    (define (xor a b)
      (or (and (not a) b) (and a (not b)))
    )

    ;; square, sum, inc, and dec
    (define (square x) (* x x))
    (define (sum x) (apply + x) )
    (define (inc x) (+ x 1))
    (define (dec x) (- x 1))

    ;;; data transformations: bind, join, yeild
    (define (bind f x) (join (map f x)))
    (define (join x) (apply append '() x))
    (define yeild list)

    ;; Y combiner
    ;;   strict-order
    (define Y 
      (lambda (f)
        ((lambda (x) (x x))
         (lambda (x) (f (lambda (y) ((x x) y)))))))
    ;;   normal-order
    (define (Y-normal f)
       ((lambda (x) (x x))
         (lambda (x) (f (x x)))))
    (define Y2
      (lambda (h)
        (lambda args (apply (h (Y h)) args))))


  ) ; module util

  ;; hello.scm

;; *EOF*
