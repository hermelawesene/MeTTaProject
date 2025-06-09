;`filter`
;Definition
;The filter function applies a predicate function (returning True/False)
;to each element of a sequence and returns a new sequence containing only the elements for which the predicate returns True.
;
;Signature: (: filter (-> (-> $x Bool) $list $accumulator Expression))
;TODO:
;Implement a my_filter function that takes a predicate function and a sequence and returns a new 
;list containing only elements that satisfy the predicate.

; put you code here

(: my_filter (-> (-> $x Bool) $list $filteredList))

(= (my_filter $predicate Nil) Nil) 
(= (my_filter $predicate (Cons $x $xs)) 
    (if ($predicate $x) (Cons $x (my_filter $predicate $xs)) 
    (my_filter $predicate $xs)))

;test cases
(= (is_even $x) (== (% $x 2) 0))
!(my_filter is_even (Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil)))))

(= (is_positive $x) (> $x 0))
(my_filter is_positive (Cons -1 (Cons 0 (Cons 1 (Cons 2 Nil)))))