#!/usr/bin/csi -s
;; sicp_ch3_e3-50.scm
;; Mac Radigan

  (load "../library/util.scm")
  (import util)

  (use sicp sicp-eval sicp-eval-anal sicp-streams)
  (load "./ch3support.scm")
  (load "./ch3.scm")

;;; Exercise 3.50.  Complete the following definition, which generalizes stream-map 
;;; to allow procedures that take multiple arguments, analogous to map in 
;;; section 2.2.3, footnote 12.

;;;   (define (stream-map proc . argstreams)
;;;     (if (<??> (car argstreams))
;;;         the-empty-stream
;;;         (<??>
;;;          (apply proc (map <??> argstreams))
;;;          (apply stream-map
;;;                 (cons proc (map <??> argstreams))))))

  (define (stream-map proc . argstreams)
    (if (stream-null? (car argstreams))
        the-empty-stream
        (cons-stream
         (apply proc (map car argstreams))
         (apply stream-map
                (cons proc (map stream-cdr argstreams))))))

;;; NB Error: unbound variable: get-new-pair
;;; (constructor for the empty list)

;; *EOF*
