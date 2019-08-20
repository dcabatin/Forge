#lang racket

(require "sigs.rkt")

(declare-sig node ([edges node]))

(define constraints
  (list
   (in node node)
   (no (& iden edges))
   (in node (join node (^ edges)))))