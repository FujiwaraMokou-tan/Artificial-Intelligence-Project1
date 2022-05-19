;;;; Projeto de IA 1o fase
;;;; Disciplina de IA - 2020 / 2021
;;;; Autores: Eduardo Ferreira, Andre Nascimento

(defun boardNPieces ()
;;"Representa um tabuleiro de teste"
  '(((0 0 0 0) (0 0 0 0) (0 0 0 0) (0 0 0 0))
((branca quadrada alta cheia)
(branca quadrada alta oca)
(branca quadrada baixa oca)
(branca quadrada baixa cheia)
(preta quadrada alta cheia)
(preta quadrada alta oca)
(preta quadrada baixa oca)
(preta quadrada baixa cheia)
(branca redonda alta cheia)
(branca redonda alta oca)
(branca redonda baixa cheia)
(branca redonda baixa oca)
(preta redonda alta cheia)
(preta redonda alta oca)
(preta redonda baixa cheia)
(preta redonda baixa oca)
))
)

;;;Funcao para o tabuleiro
;;;(tabuleiro (boardNPieces))
(defun tabuleiro(listah)
;;"Mostra o tabuleiro do projeto"
(car listah)
)


;;;Funcao para as pecas
;;;(reserva (boardNPieces))
(defun reserva(listah)
;;"Mostra as pecas que faltam jogar"
(car (cdr listah))
)


;;Funcao linha de uma tabela
;;(linha 0 (tabuleiro (boardNPieces)))
(defun linha(line listahTabuleiro)
;;"Mostra a linha de um tabuleiro"
(cond
((= line 0) (car listahTabuleiro))
(t (linha (1- line) (cdr listahTabuleiro)))
))


;;;Funcao coluna de uma tabela
;;;(coluna 1 (tabuleiro (boardNPieces)))
(defun coluna(column listahTabuleiro)
;;"Mostra a coluna de um tabuleiro"
(cond
((or (null listahTabuleiro) ) nil)
(t (cons (linha column (car listahTabuleiro)) (coluna column (cdr listahTabuleiro))))
))


;;;Funcao celula de uma tabela
;;;(celula 0 0 (tabuleiro (boardNPieces)))
(defun celula(line column listahTabuleiro)
(linha line (coluna column listahTabuleiro)) ;a coluna torna-se uma "linha" de certa forma e depois a funcao linha encontra a coordenada
)


;;;Funcao diagonal de uma tabela
;;;(diagonal-1 (tabuleiro (boardNPieces)))
(defun diagonal-1(listahTabuleiro &optional (line -1) (column -1)) ;a tabela comeca em 0 0, e como e um quadrado pode-se incrementar de forma a obter a diagonal (0 0) (1 1) (2 2) (3 3)
;;"Mostra a diagonal de cima para baixo"
(let*((nextLine (+ 1 line)) (nextColumn (+ 1 column)))  
(cond
((= nextLine 4) nil)                                               ;tabuleiro termina em 3 e comeca em 0
(t (cons (celula nextLine nextColumn listahTabuleiro) (diagonal-1 listahTabuleiro nextLine nextColumn))))
))


;;;Funcao diagonal de uma tabela
;;;(diagonal-2 (tabuleiro (boardNPieces)))
(defun diagonal-2 (listahTabuleiro &optional (line (length listahTabuleiro)) (column -1)) ;a tabela comeca em 3 0, e como e um quadrado pode-se incrementar de forma a obter a diagonal (3 0) (2 1) (1 2) (0 3)
;;"Mostra a diagonal de cima para baixo"
(let*((nextLine (- line 1)) (nextColumn (+ 1 column)))
(cond
((= nextLine -1) nil)
(t (cons (celula nextLine nextColumn listahTabuleiro) (diagonal-2 listahTabuleiro nextLine nextColumn)))
)))


;;;Funcao casa-vaziap de um tabuleiro
;;;(casa-vaziap 0 0 (tabuleiro (boardNPieces)))
(defun casa-vaziap(line column listahTabuleiro)
;;"verifica se uma das casas do tabuleiro esta vazia"
(cond
((equal (celula line column listahTabuleiro) 0) T) ;se for 0 numa localizacao nao existe peca
(t nil)
))


;;;Funcao remover-peca de um tabuleiro
;;;(remover-peca '(preta redonda baixa oca) (reserva (boardNPieces)))
(defun remover-peca(piece listahPieces)
;;"Remove uma peca das pecas que estao na reserva"
(cond
((null listahPieces) nil)
((equal piece (car listahPieces)) (remover-peca piece (cdr listahPieces))) ;se a peca existir na reserva e "retirada"
(t (cons (car listahPieces) (remover-peca piece (cdr listahPieces))))
))


;;;Funcao existe-peca
;;;(existe-peca '(preta redonda baixa oca) (reserva (boardNPieces)))
(defun existe-peca(piece listahPieces)
;;"Verifica se a peca existe na reserva"
(cond
((null listahPieces) nil)
((equal piece (car listahPieces)) t)
(t (existe-peca piece (cdr listahPieces)))
))


;;;Funcao substituir-posicao
;;;(substituir-posicao 1 '(preta redonda baixa oca) (linha 0 (tabuleiro(boardNPieces))))
(defun substituir-posicao(index piece line)
;;"Substitui uma posicao de uma linha por uma peca"
(cond
((null line) nil)
((= index -1) (append (cons (car line) nil) (substituir-posicao index piece (cdr line))))
((= index 0) (append (cons piece nil) (substituir-posicao (1- index) piece (cdr line))))
(t (append (cons (car line) nil) (substituir-posicao (1- index) piece (cdr line))))
))


;;;Funcao substituir
;;;(substituir 0 1 '(preta redonda baixa oca) (tabuleiro (boardNPieces)))
(defun substituir(line column piece listahTabuleiro)
;;"Retorna o tabuleiro com a peca substituida"
(cond
((null listahTabuleiro) nil)
((= line 0) (cons (substituir-posicao column piece (car listahTabuleiro)) (substituir (1- line) column piece (cdr listahTabuleiro))))
(t (cons (car listahTabuleiro) (substituir (1- line) column piece (cdr listahTabuleiro))))
))


;;;Funcao Operador
;;;(operador 1 0 '(preta quadrada baixa oca) (boardNPieces))
(defun operador(line column piece listahEverything)
;;"Ira colocar uma peca no tabuleiro se possivel e retorna tudo (tabuleiro + pecas que faltam)"
(cond
((not (equal (celula line column (tabuleiro listahEverything)) 0)) nil)
((and (= (celula line column (tabuleiro listahEverything)) 0) (equal (existe-peca piece (reserva listahEverything)) t)) (cons (substituir line column piece (tabuleiro listahEverything)) (cons (remover-peca piece (reserva listahEverything)) nil)))
(t nil)
))


;;;Funcao fill-board
;;;(fill-board '((branca quadrada alta cheia) (0 0) (branca quadrada alta oca) (0 1)) (boardNPieces))
(defun fill-board(moves board)
;;"cumpre todas a jogadas que recebe / coloca no tabuleiro"
(cond
((null moves) board)
(t (fill-board (cdr (cdr moves)) (operador (car (car (cdr moves))) (car (cdr (car (cdr moves)))) (car moves) board))) ;coloca as moves no tabuleiro e remove da reserva
))


;;;Funcao select-piece
;;;
(defun select-piece(board counter)
;;"Escolhe uma peca do tabuleiro"
(cond
((= counter 0) (car board)) ;escolhe a peca da posicao desejada
(t (select-piece (cdr board) (- counter 1)))
))


;;;Funcao runThroughPieces
;;;(runThroughPieces (boardNPieces))
(defun runThroughPieces(board &optional (moveDone nil) (counter 0))
;;
(cond
((<= (length (reserva board)) counter) nil)
(t (append (runThroughBoardMoves board (select-piece(reserva board) counter) moveDone) (runThroughPieces board moveDone (+ counter 1)))) ;corre todas as pecas de reserva
))


;;;Funcao runThroughBoardMoves 
;;;(runThroughBoardMoves (boardNPieces) (car (reserva (boardNPieces))))
(defun runThroughBoardMoves (board piece &optional (previousMoves nil) (line 0) (column 0))
;;"Recebe uma peca e calcula todas as possibilidades em que pode ser colocada no tabuleiro"
(cond
((and (= column 4) (= line 3)) nil)
((= column 4) (runThroughBoardMoves board piece previousMoves (+ line 1) 0)) ;desce uma linha e faz reset a posicao das colunas
((and (casa-vaziap line column (tabuleiro board)) (not (equal previousMoves nil)))  (cons (cons piece (cons (cons line (cons column nil)) previousMoves)) (runThroughBoardMoves board piece previousMoves line (+ column 1))))
((casa-vaziap line column (tabuleiro board))    (cons (cons piece (cons (cons line (cons column nil)) nil)) (runThroughBoardMoves board piece nil line (+ column 1))))
(t (runThroughBoardMoves board piece previousMoves line (+ column 1)))   ;incrementa para proxima posicao de uma coluna do tabuleiro
)) 


;;;Funcao Solution
;;;(solution (tabuleiro (boardNPieces)))
(defun solution(board)
;;"Procura se existe uma solucao nas linhas / colunas e diagonais"
(cond 
((diagonalSol board) t)
((lineSol board) t)
((columnSol board) t)
(t nil)
))


;;;Funcao lineSol
;;;(lineSol (tabuleiro (boardNPieces)))
(defun lineSol(board &optional (countah 0))
;;"Executa todas as verificacoes para as linhas caso true o jogo acaba"
(cond
((or (null board) (= countah 4)) nil)
((allBlackOrWhite (linha countah board)) t)
((allRoundOrSquare (linha countah board)) t)
((allTallOrShort (linha countah board)) t)
((allFullOrEmpty (linha countah board)) t)
(t (lineSol board (1+ countah)))
))


;;;Funcao columnSol
;;;(columnSol (tabuleiro (boardNPieces)))
(defun columnSol(board &optional (countah 0))
;;"Executa todas as verificacoes para as colunas caso true o jogo acaba"
(cond
((or (null board) (= countah 4)) nil)
((allBlackOrWhite (coluna countah board)) t)
((allRoundOrSquare (coluna countah board)) t)
((allTallOrShort (coluna countah board)) t)
((allFullOrEmpty (coluna countah board)) t)
(t (columnSol board (1+ countah)))
))


;;;Funcao diagonalSol
;;;(diagonalSol (tabuleiro (boardNPieces)))
(defun diagonalSol(board)
;;"Executa todas as verificacoes para as diagonais caso true o jogo acaba"
(let((diag1 (diagonal-1 board)) (diag2 (diagonal-2 board)))
(cond
((allBlackOrWhite diag1) t)
((allRoundOrSquare diag1) t)
((allTallOrShort diag1) t)
((allFullOrEmpty diag1) t)
((allBlackOrWhite diag2) t)
((allRoundOrSquare diag2) t)
((allTallOrShort diag2) t)
((allFullOrEmpty diag2) t)
(t nil))
))


;;Funcao allBlackOrWhite
;;;(allBlackOrWhite '((preta redonda alta oca) (preta redonda baixa oca) (preta redonda alta cheia) (preta quadrada alta cheia))) T
;;;(allBlackOrWhite '((preta redonda alta oca) (preta quadrada alta oca) (branca redonda alta oca) (preta redonda baixa oca)))  NIL
(defun allBlackOrWhite(line)
(cond
;;"Verifica se uma linha possui 4 pretas ou 4 brancos"
((and (not (equal (car line) 0)) (not (equal (car (cdr line) ) 0)) (not (equal (car (cdr (cdr line)))  0)) (not (equal (car (cdr (cdr (cdr line))))  0)) (equal (car (car line)) 'branca) (equal (car (car (cdr line))) 'branca) (equal (car (car (cdr (cdr line)))) 'branca) (equal (car (car (cdr (cdr (cdr line))))) 'branca)) t)
((and (not (equal (car line) 0)) (not (equal (car (cdr line) ) 0)) (not (equal (car (cdr (cdr line)))  0)) (not (equal (car (cdr (cdr (cdr line))))  0)) (equal (car (car line)) 'preta) (equal (car (car (cdr line))) 'preta) (equal (car (car (cdr (cdr line)))) 'preta) (equal (car (car (cdr (cdr (cdr line))))) 'preta)) t)
(t nil)
))

;;;Funcao allRoundOrSquare
;;;(allRoundOrSquare '((preta redonda alta oca) (preta redonda baixa oca) (branca redonda alta cheia) (preta redonda alta cheia))) T
;;;(allRoundOrSquare '((preta redonda alta oca) (preta quadrada alta oca) (branca redonda alta oca) (preta redonda baixa oca)))  NIL
(defun allRoundOrSquare(line)
;;"Verifica se uma linha possui 4 redondos ou 4 quadrados"
(cond
((and (not (equal (car line) 0)) (not (equal (car (cdr line) ) 0)) (not (equal (car (cdr (cdr line)))  0)) (not (equal (car (cdr (cdr (cdr line)))) 0)) (equal (cadar line) 'redonda) (equal (cadar (cdr line)) 'redonda) (equal (cadar (cdr (cdr line))) 'redonda) (equal (cadar (cdr (cdr (cdr line)))) 'redonda)) t)
((and (not (equal (car line) 0)) (not (equal (car (cdr line) ) 0)) (not (equal (car (cdr (cdr line)))  0)) (not (equal (car (cdr (cdr (cdr line)))) 0)) (equal (cadar line) 'quadrada) (equal (cadar (cdr line)) 'quadrada) (equal (cadar (cdr (cdr line))) 'quadrada) (equal (cadar (cdr (cdr (cdr line)))) 'quadrada)) t)
(t nil)
))

;;;Funcao allTallOrShort
;;;(allTallOrShort '((preta redonda alta oca) (preta quadrada alta oca) (branca redonda alta oca) (preta redonda alta cheia))) T
;;;(allTallOrShort '((preta redonda alta oca) (preta quadrada alta oca) (branca redonda alta oca) (preta redonda baixa oca)))  NIL
(defun allTallOrShort(line)
;;"Verifica se uma linha possui 4 altos ou 4 baixos"
(cond
((and (not (equal (car line) 0)) (not (equal (car (cdr line) ) 0)) (not (equal (car (cdr (cdr line)))  0)) (not (equal (car (cdr (cdr (cdr line)))) 0)) (equal (caddar line) 'alta) (equal (caddar (cdr line)) 'alta) (equal (caddar (cdr (cdr line))) 'alta) (equal (caddar (cdr (cdr (cdr line)))) 'alta)) t)
((and (not (equal (car line) 0)) (not (equal (car (cdr line) ) 0)) (not (equal (car (cdr (cdr line)))  0)) (not (equal (car (cdr (cdr (cdr line)))) 0)) (equal (caddar line) 'baixa) (equal (caddar (cdr line)) 'baixa) (equal (caddar (cdr (cdr line))) 'baixa) (equal (caddar (cdr (cdr (cdr line)))) 'baixa)) t)
(t nil)
))

;;;Funcao allFullOrEmpty
;;;(allFullOrEmpty '((preta redonda alta oca) (preta quadrada alta oca) (branca redonda alta oca) (preta redonda baixa oca)))   T
;;;(allFullOrEmpty '((preta redonda alta oca) (preta quadrada alta oca) (branca redonda alta oca) (preta redonda baixa cheia))) NIL
(defun allFullOrEmpty(line)
;;"Verifica se uma linha possui 4 cheios ou 4 vazios"
(cond
((and (not (equal (car line) 0)) (not (equal (car (cdr line) ) 0)) (not (equal (car (cdr (cdr line)))  0)) (not (equal (car (cdr (cdr (cdr line)))) 0)) (equal (car (cdr (cddar line))) 'cheia) (equal (car (cdr (cddar (cdr line)))) 'cheia) (equal (car (cdr (cddar (cdr (cdr line))))) 'cheia) (equal (car (cdr (cddar (cdr (cdr (cdr line)))))) 'cheia)) t)
((and (not (equal (car line) 0)) (not (equal (car (cdr line) ) 0)) (not (equal (car (cdr (cdr line)))  0)) (not (equal (car (cdr (cdr (cdr line)))) 0)) (equal (car (cdr (cddar line))) 'oca) (equal (car (cdr (cddar (cdr line)))) 'oca) (equal (car (cdr (cddar (cdr (cdr line))))) 'oca) (equal (car (cdr (cddar (cdr (cdr (cdr line)))))) 'oca)) t)
(t nil)
))







