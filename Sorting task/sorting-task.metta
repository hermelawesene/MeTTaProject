;; list type structure to - defined as recursive data structure
;; the Cons and Nil are conventinally used to define the recursive data struture but do not have special meaning

(Cons 1 (Cons 2 Nil))
;; We can define the type for the above data structure as follows 
;; Since Nil points the end of the list -- it has to be defined as a List it self -- list of some type
(: List (-> $a Type))
(: Nil (List $a))
(: Cons (-> $a (List $a) (List $a)))

;; so, anything that is wrapped in the Cons type maker(constructor) will qualify as (List $a) type
;; if $a is a number -- and 
! (get-type (Cons 0 Nil)) ;; (List Number)
;; We can also construct list of anything by making custom type constructors from grounded types

(: Size Type)
;; next dedine a type constructor that takes a number and returns Size type
(: mkSize (-> Number Size))

;; now if we build a list that takes Size type arguments as follows
(Cons (mkSize 1) (Cons (mkSize 2) Nil))
;; The type of the above should be (List Size)
! (get-type (Cons (mkSize 1) (Cons (mkSize 2) Nil))) ;; (List Size)

;; when defining functions that take these types as argument we do it as follows
(: len (-> (List Number) Number)) ;; for list of numbers
;; for list of Size -- by overloading the above type definition 
(: len (-> (List Size) Number))
(= (len Nil) 0)
(= (len (Cons $x $xs))
    (+ 1 (len $xs)))
! (len (Cons 1 (Cons 3 Nil))) ;; 2
! (len (Cons (mkSize 1) (Cons (mkSize 3) Nil))) ;; 2

;; An instance is just a vector of numbers
(: Instance Type)
(: mkInst (-> (List Number) Instance))

;; to make an Instance Type use the type constructor, mkInst, and pass it List of numbers
! (mkInst (Cons 5 (Cons 4 Nil)));; this is a valid Instance 
;; to verify that 
! (get-type (mkInst (Cons 5 (Cons 4 Nil))))
;; A scored instance is just a pair of instance and it's score.

;; A pair type definition
(: Pair (-> $a $b Type))
(: mkPair (-> $a $b (Pair $a $b)))

;; ScoredInstance -- takes a the type of the score -- because we can have different kinds of scores -- 
;; just like the list -- we can have list of numbers as well as other types

;; a scored instance which is represented here with ScoredInstance can be constructed using the mkSInst type maker
(: ScoredInstance (-> $score Type))
(: mkSInst (-> (Pair Instance $score) (ScoredInstance $score)))

;; a valid scored instance is sth like this
;; first lets define a score type
(: Cscore Type)
(: mkCscore (-> Number Number Cscore))

;; scored instance
! (mkSInst (mkPair (mkInst (Cons 1 Nil)) (mkCscore 1 2)))
! (get-type (mkSInst (mkPair (mkInst (Cons 1 Nil)) (mkCscore 1 2)))) ;; (ScoredInstance Cscore)
;; An instance set is a list of scored instances.

;; a scored instance set is a list of scored instances 
(: InstanceSet (-> $score Type))
(: mkSInstSet (-> (List (ScoredInstance $score)) (InstanceSet $score)))

;; a sample instance set is with just two scored instances 
! (mkSInstSet (Cons (mkSInst (mkPair (mkInst (Cons 1 Nil)) (mkCscore 1 2))) (Cons (mkSInst (mkPair (mkInst (Cons 2 Nil)) (mkCscore 2 3))) Nil)))
! (get-type (mkSInstSet (Cons (mkSInst (mkPair (mkInst (Cons 1 Nil)) (mkCscore 1 2))) (Cons (mkSInst (mkPair (mkInst (Cons 2 Nil)) (mkCscore 2 3))) Nil)))) ;; (InstanceSet Cscore)

;; So the task is to implement sorting algorithms for sored instance set in metta using the 2nd part of the Cscore value
;; Partial sort as well as full sort -- select two algorithms implement them and comparet the time complexity -- theorerical and time metta execution time

;; whenever possible, make use of builtin functions for speed of execution