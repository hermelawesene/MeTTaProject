;`fold`
;Definition
;The fold (or reduce) function combines elements of a sequence into a single value using a binary function and an initial value. 
;It processes the sequence iteratively, accumulating a result.
;
;Signature: (: foldr (-> (-> $a $b $b) $b $c $d)) ; a function that folds from right to left.
;Signature: (: foldl (-> (-> $a $b $d) $b $c $d)) ; a function that folds from left to right.
;TODO:
;Implement a my_foldr function that takes a binary function, a sequence, and an initial value, 
;and returns the accumulated result by processing the sequence from right to left.

(: my_foldr (-> (-> $a $b $b) $b $list $result))

(= (my_foldr $binary_fn $init Nil) $init) 
(= (my_foldr $binary_fn $init (Cons $x $xs)) 
    ($binary_fn $x (my_foldr $binary_fn $init $xs)))

;test cases
(= (add $x $y) (+ $x $y))
!(my_foldr add 0 (Cons 1 (Cons 2 (Cons 3 Nil))))

(= (multiply $x $y) (* $x $y))
!(my_foldr multiply 1 (Cons 2 (Cons 3 (Cons 4 Nil))))