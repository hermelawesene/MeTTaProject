;Implement max and min functions that find the maximum and minimum values in a list, respectively.

;max value from a list
(= (max ()) minus_infinity)
(= (max (Cons $x $xs))
    (let $max_rest (max $xs)
        (if (== $max_rest minus_infinity)
            $x
            (if (> $x $max_rest)
                $x
                $max_rest
            )
        )
    )
)

;test case
! (max (Cons 3 (Cons 5 (Cons 2 (Cons 8 (Cons 1 ())))))) 