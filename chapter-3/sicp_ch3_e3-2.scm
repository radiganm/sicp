#!/usr/bin/csi -s
;; sicp_ch3_e3-1.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

  (use sicp sicp-eval sicp-eval-anal sicp-streams)
  (load "./ch3support.scm")
; (load "./ch3.scm")


  ;; Exercise 3.2: In so\ue039ware-testing applications, it is useful
  ;; to be able to count the number of times a given procedure
  ;; is called during the course of a computation. Write a pro-
  ;; cedure make-monitored that takes as input a procedure, f ,
  ;; that itself takes one input. \ue049e result returned by make-
  ;; monitored is a third procedure, say mf , that keeps track
  ;; of the number of times it has been called by maintaining
  ;; an internal counter. If the input to mf is the special symbol
  ;; how-many-calls? , then mf returns the value of the counter.
  ;; If the input is the special symbol reset-count , then mf re-
  ;; sets the counter to zero. For any other input, mf returns the
  ;; result of calling f on that input and increments the counter.
  ;; For instance, we could make a monitored version of the
  ;; sqrt procedure:
  ;;
  ;; (define s (make-monitored sqrt))
  ;;
  ;; (s 100)
  ;; 100
  ;;
  ;; (s 'how-many-calls?)
  ;; 1

  (define (make-monitored f)
    (let ((count 0))
      (lambda (arglist)
        (cond 
          ((equal? arglist 'how-many-calls?) count)
          ((eq? arglist 'reset-count) (set! count 0))
          (else 
            (begin
              (set! count (+ count 1)) 
              (f arglist)
            )
          )
        )
      )
    )
  )

  (bar)
  (define s (make-monitored sqrt))
  (prnvar "(s 100)" (s 100))
  (hr)
  (prnvar "(s 'how-many-calls?)" (s 'how-many-calls?))
  (hr)
  (prn "(s 'reset-count?)")
  (s 'reset-count)
  (prnvar "(s 'how-many-calls?)" (s 'how-many-calls?))
  (hr)
  (bar)

;; *EOF*
