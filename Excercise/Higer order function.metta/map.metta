
;`map` 
;Definition
;The map function applies a given function to each element of a sequence (e.g., a list)
;and returns a new sequence with the transformed elements. It transforms data without modifying the original sequence.
;
;Signature: (: map (-> $function $list Expression))
;TODO: 
;Implement a my_map function that takes a function and a sequence and returns a new list with the function applied to each element.

(: my_map (-> $function $list $transformedList))

(= (my_map $function Nil) Nil) 
(= (my_map $function (Cons $x $xs)) 
    (Cons ($function $x) 
    (my_map $function $xs)))

;test cases
(= (double $x) (* $x 2))
!(my_map double (Cons 1 (Cons 2 (Cons 3 Nil))))

(= (add_one $x) (+ $x 1))
!(my_map add_one (Cons 1 (Cons 2 (Cons 3 Nil))))