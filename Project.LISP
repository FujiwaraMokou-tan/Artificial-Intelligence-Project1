(load "E:/Project_AI/Puzzle.lisp" :if-does-not-exist nil)
(load "E:/Project_AI/Procura.lisp" :if-does-not-exist nil)

;;;Funcao Iniciar
;;;(iniciar)
(defun iniciar()
(let* ((algorithm (escolhe-algorithm)) (problem (escolhe-problem)))
	 (openfile problem algorithm)
  )
)


;;;Funcao escolhe-algorithm
;;;(escolhe-algorithm)
(defun escolhe-algorithm()
(progn
    (format t "Qual o algoritmo que pretende testar?")
    (let ((valor (read)))
      (cond
        ((or (equal valor 'BFS) (equal valor 'DFS) (equal valor 'A*) ) valor)
        (T "Please choose the right algorithm")))))


;;;Funcao escolhe-problem
;;;(escolhe-problem)
(defun escolhe-problem()
(progn
    (format t "Qual o problema que pretende testar?")
    (let ((valor (read)))
      (cond
        ((or (equal valor 1) (equal valor 2) (equal valor 3) (equal valor 4) (equal valor 5) (equal valor 6)) valor)
        (T "Please choose a problem ranging from 1 to 6") ))))


;;;Funcao openfile
;;;(openfile 3 'bfs)
;;;(openfile 3 'dfs)
(defun openfile(numbah algorithm)
  ;;Vai abrir o ficheiro de problemas
  (let* ((path1 (make-pathname :host "e" :directory '(:absolute "Project_AI") :name "problems" :type "dat")) (fileOpener (open path1 :if-does-not-exist nil)))
    (get-file fileOpener numbah algorithm)
  )
)


;;;Funcao get-file
;;;recebe um path do defun open file assim como qual o algoritmo e qual o problema que pretende testar
(defun get-file (filename numbah algorithm)
  ;;Vai ler o ficheiro aberto e extrair o problema correto
(let((problem (cond
            ((= numbah 1) (with-open-file (stream filename) (read stream)))
            ((= numbah 2) (with-open-file (stream filename) (read stream) (read stream)))
            ((= numbah 3) (with-open-file (stream filename) (read stream) (read stream) (read stream)))
            ((= numbah 4) (with-open-file (stream filename) (read stream) (read stream) (read stream) (read stream)))
            ((= numbah 5) (with-open-file (stream filename) (read stream) (read stream) (read stream) (read stream) (read stream)))
            ((= numbah 6) (with-open-file (stream filename) (read stream) (read stream) (read stream) (read stream) (read stream) (read stream)))
            (t nil)
            )))
            (cond
            ((equal problem nil) "Nao foi possivel ler o ficheiro ou nao escolheu um problema entre 1 a 6 inclusive")
            (t (run-algorithm problem algorithm)))
)
)


;;;Funcao run-algorithm
;;;recebe um tabuleiro e o algoritmo desejado
(defun run-algorithm(boardNPieces algorithm)
;;vai para a condicao certa
(cond
((equal algorithm 'bfs) (time (BFS boardNPieces)))
((equal algorithm 'dfs) (time (DFS boardNPieces)))
((equal algorithm 'a*)  (time (A-star boardNPieces)))
(t "Not the right algorithm")
)
)



