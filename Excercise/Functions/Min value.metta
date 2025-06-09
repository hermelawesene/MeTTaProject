;Implement max and min functions that find the maximum and minimum values in a list, respectively.

;min value from a list
(= (min ()) plus_infinity)
(= (min (Cons $x $xs))
    (let $min_rest (min $xs)
        (if (== $min_rest plus_infinity)
            $x
            (if (< $x $min_rest)
                $x
                $min_rest
            )
        )
    )
)

;test case
! (min (Cons 3 (Cons 5 (Cons 2 (Cons 8 (Cons 1 ())))))) 