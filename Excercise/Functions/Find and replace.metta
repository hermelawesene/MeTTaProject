;Implement a function to find a value in a list and replace it with a new value.
;
;(: findAndReplace (-> $oldValue $newValue $list $modifiedList))

(: findAndReplace (-> $old $new $list $modifiedList))

(= (findAndReplace $old $new Nil) Nil)
(= (findAndReplace $old $new (Cons $x $xs))
   (Cons (if (== $x $old) $new $x)
         (findAndReplace $old $new $xs)))
;test case
!(findAndReplace 2 99 (Cons 1 (Cons 2 (Cons 3 Nil))))