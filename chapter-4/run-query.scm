#!/usr/bin/csi -s
;; run-query.scm
;; Mac Radigan

  (use sicp sicp-eval sicp-eval-anal sicp-streams)
  (load "./ch4-query.scm")
  (define false #f)
  (define true #t)
  (initialize-data-base microshaft-data-base)
  (query-driver-loop)

;; *EOF*
