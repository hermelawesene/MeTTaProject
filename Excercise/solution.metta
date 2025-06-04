; put you code here
(: get-cscore2 (-> (ScoredInstance Cscore) Number))
(= (get-cscore2 (mkSInst (mkPair $inst (mkCscore $x $y)))) $y)
;! (mkSInstSet (Cons (mkSInst (mkPair (mkInst (Cons 1 Nil)) (mkCscore 1 2))) (Cons (mkSInst (mkPair (mkInst (Cons 2 Nil)) (mkCscore 2 3))) Nil)))

;; Extract the second number from a Cscore
(: get-cscore-second (-> Cscore Number))
(= (get-cscore-second (mkCscore $a $b)) $b)
;========================================================;
(: Instance Type)
(: mkInst (-> (List Number) Instance))

(: Pair (-> $a $b Type))
(: mkPair (-> $a $b (Pair $a $b)))

(: ScoredInstance (-> $score Type))
(: mkSInst (-> (Pair Instance $score) (ScoredInstance $score)))

(: Cscore Type)
(: mkCscore (-> Number Number Cscore))
(mkSInst (mkPair (mkInst (Cons 1 Nil)) (mkCscore 1 2)))
!(get-cscore2 (mkSInst (mkPair (mkInst (Cons 1 Nil)) (mkCscore 1 5))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(: less-cscore (-> (ScoredInstance Cscore) (ScoredInstance Cscore) Bool))
(= (less-cscore $a $b)
   (< (get-cscore2 $a) (get-cscore2 $b)))

(: sort (-> (List (ScoredInstance Cscore)) (List (ScoredInstance Cscore))))
(= (sort Nil) Nil)
(= (sort (Cons $x $xs)) (insert $x (sort $xs)))

(: insert (-> (ScoredInstance Cscore) (List (ScoredInstance Cscore)) (List (ScoredInstance Cscore))))
(= (insert $x Nil) (Cons $x Nil))
(= (insert $x (Cons $y $ys))
   (if (less-cscore $x $y)
       (Cons $x (Cons $y $ys))
       (Cons $y (insert $x $ys))))

(: sort-inst-set (-> (InstanceSet Cscore) (InstanceSet Cscore)))
(= (sort-inst-set (mkSInstSet $xs))
   (mkSInstSet (sort $xs)))

(mkSInstSet
  (Cons (mkSInst (mkPair (mkInst (Cons 1 Nil)) (mkCscore 1 5)))
        (Cons (mkSInst (mkPair (mkInst (Cons 2 Nil)) (mkCscore 3 1)))
              (Cons (mkSInst (mkPair (mkInst (Cons 3 Nil)) (mkCscore 2 3))) Nil))))


!(sort-inst-set
  (mkSInstSet
    (Cons 
      (mkSInst (mkPair (mkInst (Cons 1 Nil)) (mkCscore 1 5)))
      (Cons 
        (mkSInst (mkPair (mkInst (Cons 2 Nil)) (mkCscore 3 1)))
        (Cons 
          (mkSInst (mkPair (mkInst (Cons 3 Nil)) (mkCscore 2 3)))
          Nil)))))

