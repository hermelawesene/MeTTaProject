;---------------------- TYPE DEFINITIONS --------------------------
(: Instance Type)
(: mkInst (-> (List Number) Instance))

(: Pair (-> $a $b Type))
(: mkPair (-> $a $b (Pair $a $b)))

(: Cscore Type)
(: mkCscore (-> Number Number Cscore))

(: ScoredInstance (-> $score Type))
(: mkSInst (-> (Pair Instance $score) (ScoredInstance $score)))

(: InstanceSet (-> (List (ScoredInstance Cscore)) Type))
(: mkSInstSet (-> (List (ScoredInstance Cscore)) (InstanceSet Cscore)))

(: get-cscore2 (-> (ScoredInstance Cscore) Number))
(= (get-cscore2 (mkSInst (mkPair (mkInst $x) (mkCscore $a $b)))) $b)

;---------------------- QUICKSORT HELPERS --------------------------
(: filter-less (-> (ScoredInstance Cscore) (List (ScoredInstance Cscore)) (List (ScoredInstance Cscore))))
(= (filter-less $pivot Nil) Nil)
(= (filter-less $pivot (Cons $x $xs))
   (if (< (get-cscore2 $x) (get-cscore2 $pivot))
       (Cons $x (filter-less $pivot $xs))
       (filter-less $pivot $xs)))

(: filter-greater-eq (-> (ScoredInstance Cscore) (List (ScoredInstance Cscore)) (List (ScoredInstance Cscore))))
(= (filter-greater-eq $pivot Nil) Nil)
(= (filter-greater-eq $pivot (Cons $x $xs))
   (if (>= (get-cscore2 $x) (get-cscore2 $pivot))
       (Cons $x (filter-greater-eq $pivot $xs))
       (filter-greater-eq $pivot $xs)))

(: concat (-> (List (ScoredInstance Cscore)) (List (ScoredInstance Cscore)) (List (ScoredInstance Cscore))))
(= (concat Nil $ys) $ys)
(= (concat (Cons $x $xs) $ys) (Cons $x (concat $xs $ys)))

;---------------------- QUICKSORT --------------------------
(: quicksort (-> (List (ScoredInstance Cscore)) (List (ScoredInstance Cscore))))
(= (quicksort Nil) Nil)
(= (quicksort (Cons $pivot $rest))
   (let $less (quicksort (filter-less $pivot $rest))
     (let $greater-eq (quicksort (filter-greater-eq $pivot $rest))
       (concat $less (Cons $pivot $greater-eq)))))

;---------------------- TAKE TOP N --------------------------
(: take (-> Number (List $a) (List $a)))
(= (take 0 $xs) Nil)
(= (take $n Nil) Nil)
(= (take $n (Cons $x $xs))
   (Cons $x (take (- $n 1) $xs)))

(: partial-sort-inst-set (-> Number (InstanceSet Cscore) (InstanceSet Cscore)))
(= (partial-sort-inst-set $n (mkSInstSet $xs))
   (mkSInstSet (take $n (quicksort $xs))))

;---------------------- SINGLE TEST CALL --------------------------
!(partial-sort-inst-set 2
  (mkSInstSet
    (Cons 
      (mkSInst (mkPair (mkInst (Cons 1 Nil)) (mkCscore 1 5)))
      (Cons 
        (mkSInst (mkPair (mkInst (Cons 2 Nil)) (mkCscore 3 1)))
        (Cons 
          (mkSInst (mkPair (mkInst (Cons 3 Nil)) (mkCscore 2 3)))
          Nil)))))
