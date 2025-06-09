;`superpose`
;use superpose to implement the `map` function.
;
;(: map (-> $function $list Expression))

(: map (-> $function $list $transformedList))

(= (square $x) (* $x $x))

(= (map $f ()) ())
(= (map $f $x)
   (($f $x)))

;example
 (map square (:: 1 (:: 2 (:: 3 ()))))
 ! (map square (superpose (3 4 5))) 
