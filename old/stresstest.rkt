#lang rosette
(require ocelot)

; ok the kodkod source should have a reference on bit blasting.
; there are two options: integers are just more atoms, or we actually understand operations on itnegers, so we have those theories. kodkod has the latter.

; lists and quotes both produce the same thing, ultimately: a syntax object. It's just that
; quotes don't cause the inner bits to be evaluated first. They stay as syntax objects.

(writeln 'Start)
(define U (universe '(n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 n16 n17 n18 n19 n0)))
(define atoms (universe-atoms U))

(define edges (declare-relation 2 "edges"))
(define tc (declare-relation 2 "tc"))

(define tc-bound (make-product-bound tc atoms atoms))
(define edges-bound (make-exact-bound edges '((n16 n6)
                                              (n16 n4)
                                              (n17 n2)
                                              (n8 n3)
                                              (n17 n15) 
                                              (n7 n13) 
                                              (n4 n4)
                                              (n4 n10) 
                                              (n9 n16) 
                                              (n0 n17) 
                                              (n15 n7)
                                              (n11 n3)
                                              (n15 n6)
                                              (n17 n13) 
                                              (n1 n14) 
                                              (n15 n19) 
                                              (n5 n2)
                                              (n10 n3)
                                              (n7 n10) 
                                              (n13 n7)
                                              (n1 n13) 
                                              (n12 n14) 
                                              (n9 n19)
                                              (n12 n15)
                                              (n12 n7)
                                              (n5 n0)
                                              (n7 n3)
                                              (n17 n17)
                                              (n13 n13)
                                              (n19 n18)
                                              (n17 n11)
                                              (n2 n6)
                                              (n6 n15)
                                              (n12 n5)
                                              (n2 n15)
                                              (n1 n11))))


;(define test (all ([a atoms] [b atoms]) '(a b)

;(define constraints (and
;                     (! (in '(n1 n2) edges))))

(define constraints (= tc (^ edges)))


(writeln "hi")
(define all-bounds (bounds U (list edges-bound tc-bound)))
(define model-bounds (instantiate-bounds all-bounds))

(interpretation->relations (evaluate model-bounds (solve (assert (interpret* constraints model-bounds)))))
;(interpretation->relations (evaluate model-bounds (solve (assert (interpret true all-bounds)))))