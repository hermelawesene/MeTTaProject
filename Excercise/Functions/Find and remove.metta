;Implement a function to find and remove a value from a list.
;
;(: findAndRemove (-> $value $list $modifiedList))
(: findAndRemove (-> $value $list $modifiedList))

(= (findAndRemove $value Nil) Nil) 
(= (findAndRemove $value (Cons $x $xs)) 
    (if (== $x $value) (findAndRemove $value $xs) 
    (Cons $x (findAndRemove $value $xs))))

;test case
!(findAndRemove 2 (Cons 1 (Cons 2 (Cons 3 Nil))))
