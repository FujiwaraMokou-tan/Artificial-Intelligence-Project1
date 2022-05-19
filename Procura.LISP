;;;; Projeto de IA 1o fase
;;;; Disciplina de IA - 2020 / 2021
;;;; Autores: Eduardo Ferreira, Andre Nascimento



;;;moves = ((piece) (coordinate))
;;;Funcao BFS
;;;(BFS (boardNPieces))
(defun BFS(initialNode &optional (moves nil) abertos fechados (counter 0)) 
;;"Corre o algoritmo BFS, armazenado os jogadas possiveis nos abertos_let, a jogada atual e posta nos fechados_let e o cleanlist vai removendo incrementalmente os nos que possam ser repetidos ate encontrar um que que ainda nao tenha sido analizado."
(let*((abertos_let (cond 
                   ((null abertos) (runThroughPieces initialNode)) ;para a primeira iteracao
                   (t (remove nil (abertos-BD abertos (runThroughPieces (fill-board moves initialNode) moves)))))) ;para todas as outras iteracoes(tentativas)

(fechados_let (cond
                     ((null moves) (list (car abertos_let))) ;para a primeira iteracao
                     (t (append (list moves) fechados))))    ;para todas as outras iteracoes(tentativas)

(cleanlist (remove-repeats initialNode abertos_let fechados_let))
)

(cond
((and (not (equal (car cleanlist) nil)) (solution (tabuleiro (fill-board (car cleanlist) initialNode)))) (list (car cleanlist) "Numero de iteracoes" (+ counter 1) "Penetrancia:" (/ (/ (length (car cleanlist)) 2) (+ (length (cdr abertos_let)) (length fechados_let))) "Numero de nos gerados:" (+ (length fechados_let) (length (cdr abertos_let)))))
((null abertos_let) "Couldnt find result")
(t (BFS initialNode (car cleanlist) (cdr cleanlist) fechados_let (+ counter 1))))
))


;;; Funcao remove-repeats
;;;(remove-repeats (boardNPieces) )
(defun remove-repeats(board abertos fechados)
;;"Remove todos dos abertos os que ja estao nos fechados ate encontrar um no possivel de correr"
(cond
((null fechados) abertos)
((equal (tabuleiro (fill-board (car abertos) board)) (tabuleiro (fill-board (car fechados) board))) (cdr abertos))
(t (remove-repeats board abertos (cdr fechados))))
)

;;;Funcao abertos-BD
;;;
(defun abertos-BD (abertos sucessores)
;;"Faz append dos nos anteriores com os nos novos gerados."
  (append abertos sucessores)
)


;;;moves = ((piece) (coordinate))
;;;Funcao DFS
;;;(DFS (boardNPieces))
(defun DFS(initialNode &optional (moves nil) abertos fechados (depth (length (car (cdr initialNode)))) (counter 0))
;;"Corre o algoritmo DFS, as jogadas possiveis sao armazenadas no abertos_let, a jogada atual e posta nos fechados_let e o cleanlist vai removendo incrementalmente os nos que possam ser repetidos ate encontrar um que que ainda nao tenha sido analizado."
(let*((abertos_let (cond 
                   ((null abertos) (runThroughPieces initialNode)) ;a primeira iteracao
                   ((= (/ (length moves) 2) depth) (go-back-up abertos depth)) ;caso o numero de jogadas seja igual a depth inicial (consideremos a profundidade maxima o numero de pecas que se pode usar no inicio significa que chegou a profundidade maxima e precisa de voltar para cima)
                   (t (remove nil (abertos-BD (runThroughPieces (fill-board moves initialNode) moves) abertos))))) ;para todas as outras jogadas, a ordem esta trocada para simular DFS

(fechados_let (cond
                     ((null moves) (list (car abertos_let)))
                     (t (append (list moves) fechados))))

(cleanlist (remove-repeats initialNode abertos_let fechados_let))
)

(cond
((and (not (equal (car cleanlist) nil)) (solution (tabuleiro (fill-board (car cleanlist) initialNode)))) (list (car cleanlist) "Numero de iteracoes" (+ counter 1) "Penetrancia:" (/ (/ (length (car cleanlist)) 2) (+ (length cleanlist) (length fechados_let))) "Numero de nos gerados:" (+ (length fechados_let) (length cleanlist))))
((null abertos_let) "Couldnt find result")
(t (DFS initialNode (car cleanlist) (cdr cleanlist) fechados_let depth (+ counter 1))
))  
))


;;;Funcao go-back-up
;;;
(defun go-back-up(abertos depth)
;;"Recebe os nos abertos e elimina ate encontrar um que nao tenha ultrapassado a maxima profundidade"
(cond
((null abertos) nil)
((= (/ (length (car abertos)) 2) depth) (go-back-up (cdr abertos) depth))
(t abertos)
))



;;moves = ((piece) (coordinate) value)
;;Funcao A-star
;;(A-star (boardNPieces))
(defun A-star(initialNode &optional (moves nil) abertos fechados (counter 0))
;;"Corre o algoritmo A*, as jogadas possiveis sao armazenadas no abertos_let, a jogada atual e posta nos fechados_let e o best_move vai encontrar a melhor jogada possivel."
(let*((abertos_let (cond 
                   ((null abertos) (runThroughPieces initialNode))
                   (t (remove nil (abertos-BD abertos (runThroughPieces (fill-board moves initialNode) moves))))))

      (best_move (find-best-move abertos_let initialNode))

      (fechados_let (cond
                     ((null moves) (list best_move))
                     (t (append (list best_move) fechados))))

)

(cond
((<= (car (cdr best_move)) 0) (list (car best_move) "Numero de iteracoes:" (+ counter 1) " Penetrancia:" (/ (/ (length (car best_move)) 2) (+ (length (cdr abertos_let)) (length fechados_let))) " Nos gerados:" (+ (length (cdr abertos_let)) (length fechados_let))))
((null abertos_let) "Nao foi possivel encontrar resposta.")
(t (A-star initialNode (car best_move) (remove-previous-best abertos_let best_move) fechados_let (+ counter 1))))
))


;;;Funcao how-many-color
;;;(how-many-color ((branca quadrada alta oca) (preta redonda baixa oca) (preta quadrada alta oca) (branca quadrada alta cheia)))
(defun how-many-color(line &optional (white 0) (black 0))
;;"Verifica quantas pecas de cada cor existe na linha"
(cond
((and (null line) (> white black)) (list (- 4 white) 'branca))
((and (null line) (> black white)) (list (- 4 black) 'preta))
((and (null line) (= black white)) (list (- 4 black) 'same))
((equal (car line) 0) (how-many-color (cdr line) white black))
((equal (car (car  line)) 'BRANCA) (how-many-color (cdr line) (+ white 1) black))
((equal (car (car  line)) 'PRETA) (how-many-color (cdr line) white (+ black 1)))
(t (how-many-color (cdr line) white black))
))

;;;Funcao how-many-geo
;;;(how-many-geo ((branca quadrada alta oca) (preta redonda baixa oca) (preta quadrada alta oca) (branca quadrada alta cheia)))
(defun how-many-geo(line &optional (square 0) (round 0))
;;"Verifica quantos quadrados/redondas existe na linha"
(cond
((and (null line) (> square round)) (list (- 4 square) 'quadrada))
((and (null line) (> round square)) (list (- 4 round) 'redonda))
((and (null line) (= round square)) (list (- 4 round) 'same))
((equal (car line) 0) (how-many-geo (cdr line) square round))
((equal (car (cdr (car  line))) 'QUADRADA) (how-many-geo (cdr line) (+ square 1) round))
((equal (car (cdr (car  line))) 'REDONDA) (how-many-geo (cdr line) square (+ round 1)))
(t (how-many-geo (cdr line) square round))
))

;;;Funcao how-many-height
;;;(how-many-height ((branca quadrada alta oca) (preta redonda baixa oca) (preta quadrada alta oca) (branca quadrada alta cheia)))
(defun how-many-height(line &optional (tall 0) (short 0))
;;"Verifica quantos altos/baixos existe na linha"
(cond
((and (null line) (> tall short)) (list (- 4 tall) 'alta))
((and (null line) (> short tall)) (list (- 4 short) 'baixa))
((and (null line) (= short tall)) (list (- 4 short) 'same))
((equal (car line) 0) (how-many-height (cdr line) tall short))
((equal (car (cdr (cdr (car  line)))) 'ALTA) (how-many-height (cdr line) (+ tall 1) short))
((equal (car (cdr (cdr (car  line)))) 'BAIXA) (how-many-height (cdr line) tall (+ short 1)))
(t (how-many-height (cdr line) tall short))
))

;;;Funcao how-many-fill
;;;(how-many-fill ((branca quadrada alta oca) (preta redonda baixa oca) (preta quadrada alta oca) (branca quadrada alta cheia)))
(defun how-many-fill(line &optional (full 0) (empty 0))
;;"Verifica quantos cheios/ocas existe na linha"
(cond
((and (null line) (> full empty)) (list (- 4 full) 'cheia))
((and (null line) (> empty full)) (list (- 4 empty) 'oca))
((and (null line) (= empty full)) (list (- 4 empty) 'same))
((equal (car line) 0) (how-many-height (cdr line) full empty))
((equal (car (cdr (cdr (cdr (car  line))))) 'CHEIA) (how-many-fill (cdr line) (+ full 1) empty))
((equal (car (cdr (cdr (cdr (car  line))))) 'OCA) (how-many-fill (cdr line) full (+ empty 1)))
(t (how-many-height (cdr line) full empty))
))


;;;Funcao get-all-piece-attributes
;;;(get-all-piece-attributes ((branca quadrada alta oca) (preta redonda baixa oca) (preta quadrada alta oca) (branca quadrada alta cheia)))
(defun get-all-piece-attributes(line)
;;Recebe o que existe mais de cada atributo
(let*((color (how-many-color line)) 
      (geo (how-many-geo line))
      (height (how-many-height line))
      (fill (how-many-fill line)))
(list color geo height fill)
))


;;;Funcao get-value-on-move
;;;(get-board-ready-for-ristic '((branca quadrada alta cheia) (0 0) (branca quadrada alta oca) (0 1)) (boardNPieces))
;;;(get-board-ready-for-ristic '((branca quadrada alta oca) (0 1)) (boardNPieces))
(defun get-board-ready-for-ristic(moves board)
;;"Enche o tabuleiro com as jogadas todas ate a ultima pa encontrar o valor da ultima jogada"
(cond
((= (length moves) 2) (get-heuristic-value (car (car (cdr moves))) (car (cdr (car (cdr moves)))) (operador (car (car (cdr moves))) (car (cdr (car (cdr moves)))) (car moves) board)))
(t (get-board-ready-for-ristic (cdr (cdr moves)) (operador (car (car (cdr moves))) (car (cdr (car (cdr moves)))) (car moves) board))) 
))

;;;Funcao get-heuristic-value
;;;(get-heuristic-value 2 1 (boardNPieces))
(defun get-heuristic-value(line_cor column_cor board)
(let* ((line (linha line_cor (car board)))
       (column (coluna column_cor (car board)))
)
(reduce #'min (append (get-all-piece-attributes line) (get-all-piece-attributes column)) :key #'first)
))


;;;Funcao find-best-move
;;;
(defun find-best-move(abertos board &optional (move nil) (value 4))
;;"Encontra a melhor jogada dos nos abertos (a com menor valor) para puder continuar com a sua procura"
(cond
((null abertos) (list move value))
((< (get-board-ready-for-ristic (car abertos) board) value) (find-best-move (cdr abertos) board (car abertos) (get-board-ready-for-ristic (car abertos) board))) ;se o valor de uma jogada for menor que a actual e considerado uma boa jogada
(t (find-best-move (cdr abertos) board move value))
))


;;;Funcao remove-previous-best
;;;
(defun remove-previous-best(abertos best_move)
;;"Remove o no que foi percorrido anteriormente"
(cond
((null abertos) nil)
((equal (car abertos) (car best_move)) (remove-previous-best (cdr abertos) best_move))
(t (cons (car abertos) (remove-previous-best (cdr abertos) best_move)))
))







;;(defun BFS(initialNode &optional (moves nil) abertos fechados (counter 0)) 
;;"Corre o algoritmo BFS, armazenado os jogadas possiveis nos abertos_let, a jogada atual e posta nos fechados_let e o cleanlist vai removendo incrementalmente os nos que possam ser repetidos ate encontrar um que que ainda nao tenha sido analizado."
;;(let*((abertos_let (cond 
;;                   ((null abertos) (runThroughPieces initialNode)) ;para a primeira iteracao
;;                   (t (remove nil (abertos-BD abertos (runThroughPieces (fill-board moves initialNode) moves)))))) ;para todas as outras iteracoes(tentativas)
;;
;;(fechados_let (cond
;;                     ((null moves) (list (car abertos_let))) ;para a primeira iteracao
;;                     (t (append (list moves) fechados))))    ;para todas as outras iteracoes(tentativas)
;;
;;)
;;
;;(cond
;;((and (not (equal (car abertos_let) nil)) (solution (tabuleiro (fill-board (car abertos_let) initialNode)))) (list (car abertos_let) "Numero de iteracoes" (+ counter 1) "Penetrancia:" (/ (/ (length (car abertos_let)) 2) (+ (length abertos_let) (length fechados_let))) "Numero de nos gerados:" (+ (length fechados_let) (length abertos_let))))
;;((null abertos_let) "Couldnt find result")
;;(t (BFS initialNode (car abertos_let) (cdr abertos_let) fechados_let (+ counter 1))))
;;))