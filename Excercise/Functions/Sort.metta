;Implement a sort function that sorts a list of numbers and returns a sorted list.
;
;(: sort (-> $list $sortedList))
(: sort (-> $list $sortedList))
; recursively sort the tail of the list
; insert the head of the list to the sorted tail
(= (sort Nil) Nil)
(= (sort (Cons $x $xs)) 
    (insert $x (sort $xs))
)

(= (insert $x Nil) 
    (Cons $x Nil))

(= (insert $x (Cons $y $ys)) 
    (if (< $x $y)
        (Cons $x (Cons $y $ys)) 
        (Cons $y (insert $x $ys)) 
    )
)

;test case
! (sort (Cons 3 (Cons 1 (Cons 4 (Cons 2 Nil)))))
