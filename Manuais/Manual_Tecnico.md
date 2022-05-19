# Manual Técnico 

## Inteligência Artificial - Escola Superior de Tecnologia de Setúbal  

<br>

### 2020/2021

<br>

### Problema do Quatro


<br>
Realizado por:

André Nascimento nº160221075

Eduardo Ferreira nº110221031

<br> 

## **Arquitetura do sistema**

Para melhor organização do código correspondente ao problema, foram criados 4 ficheiros:

Procura.LISP - Implementa os algoritmos relevantes para a resolução do problema.

Project.LISP - Liga todos os ficheiros LISP e executa-os como se fossem um só, neste ficheiro, também estão as funções de input/output.

Puzzle.LISP - Implementa as funções todas para se poder movimentar e manusear o tabuleiro.

problems.dat - Contem os diversos nós iniciais que vão ser avaliados.


## **Entidades e a sua implementação**

Como entidades e tipos abstratos de dados, os alogoritmos possuem uma entidade chamada "initialNode" onde terá sempre o estado inicial do tabuleiro e das peças como forma de poder iniciar o algoritmo facilmente.

Como entidades opcionais, existe o "moves" onde basicamente vai simbolizar a jogada que está a ser verificada no momento. Esta entidade também tem a a capacidade de ter registado as jogadas que foram feitas anteriormente por aquele nó.

Temos também a entidade "abertos" onde será guardado as jogadas de todos os nós separadamente dependendo do algoritmo em questão será chamado o primeiro dos  abertos (BFS e DFS) ou a jogada que tenha melhor valor (A*).

Temos a entidade "fechados" onde vai ser armazenado todas as jogadas/nós que já foram verificados.

Temos a entidade "counter" que servirá como forma de verificar quantas vezes a função vai iterar sobre ela mesma.

Temos a entidade "depth" que pertence exclusivamente ao algoritmo "DFS" que serve para saber a profundidade maxima que pode explorar.

## **Algoritmos e a sua implementação**

(é preciso apresentar os dados referentes para cada problema e qual foi a sua solução, tambem é necessário indicar o numero de nós gerados, expandido, penetrancia, o factor de ramificação médio e o tempo de execução)

Os algoritmos que foram implementados neste projeto foram:

* BFS (Breath First Search)
* DFS (Depth First Search)
* A*

### BFS: ###

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790541254504087552/BFS-Problema_1.png)  
Figura 1: Problema 1 com BFS.

<br>

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790541255247134750/BFS-Problema_2.png)  
Figura 2: Problema 2 com BFS.

<br>

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790541256228732928/BFS-Problema_3.png)  
Figura 3: Problema 3 com BFS.

<br>

O problema 4, 5 e 6 chega ao limite da memória Heap do lispworks, isto devido ao facto que o BFS percorre os nós "horizontalmente", ou seja, ele verifica primeiro um nivel antes de descer para o proximo, devido a isso, ele vai fazer várias iterações e criar vários nós na lista de abertos, criando problemas na memória.

### DFS: ###

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790541257000353802/DFS-Problema_1.png)  
Figura 4: Problema 1 com DFS.

<br>

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790542196356939826/DFS-Problema_2.png)  
Figura 5: Problema 2 com DFS.

<br>

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790542212852613120/DFS-Problema_3.png)  
Figura 6: Problema 3 com DFS.

<br>

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790541290902126612/DFS-Problema_4.png)  
Figura 7: Problema 4 com DFS.

<br>

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790541295851798578/DFS-Problema_5.png)  
Figura 8: Problema 5 com DFS.

<br>

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790541301950447626/DFS-Problema_6.png)  
Figura 9: Problema 6 com DFS.

<br>

### A*: ###
 
![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790541247386877963/A-star-Problema_1.png)  
Figura 10: Problema 1 com A*.

<br>

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790541250289729546/A-star-Problema_3.png)  
Figura 12: Problema 3 com A*.

<br>

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790542019365306379/A-star-Problema_4.png)
Figura 13: Problema 4 com A*.

<br>

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790541252016996382/A-star-Problema_5.png)
Figura 14: Problema 5 com A*.

<br>

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790541253120229406/A-star-Problema_6.png)
Figura 15: Problema 6 com A*.

## **Descrição das opções tomadas**

(Aspectos que não tinhamos a certeza e usamos uma coisa e o porque de a usarmos)

No algoritmo BFS, o grupo teve como ideia definir uma variavel let "abertos_let" cujo o que essa variavel vai fazer é:

- Caso seja a primeira iteração, ele irá mostrar todas as jogadas possiveis do tabuleiro inicial

- Caso não seja a primeira iteração, ele irá fazer um "apend" dos nós que já estavam abertos com os nós que abriram agora no nó estado que esta a ser verificado de momento, esta ordem foi escolhida assim com o objetivo de simular o BFS, pois o BFS percorre primeiro todos os nós de um nivel antes de descer para o proximo.

Depois temos uma variavel let denominada "fechados_let" que o que vai fazer é:

- Caso seja a primeira iteração, ele irá colocar o primeiro nó dos "abertos" nos "fechados".

- Caso não seja a primeira iteração, ele irá fazer um "append" onde irá guardar a jogada (nó) atual juntamente com os nós que tinham sido previamente guardados nos "fechados", registando assim, todos os nós que foram percorridos na árvore. 

De seguida temos a variavel let chamada "cleanList" que consiste basicamente em remover dos "abertos_let" os nós repetidos que estejam mais à esquerda, embora esta variavel não seja necessária, o grupo achou correto utiliza-la por uma questão de performance, pois assim poderia-mos impedir de gerar nós que já tenham sido previamente gerados por um outro nó que possua as mesma jogadas, mas trocadas.

Por fim, temos as verificações, onde caso ele encontre uma solução, este termina e dá o resultado desejado. Caso os "abertos_let" seja null( esteja vazio), então ele irá dar uma mensagem que percorreu a árvore toda e não encontrou o resultado.

Por fim a verificação "T" chama o BFS outra vez para simular/recriar a recursividade, enviando como parametros o nó inicial, proxima jogada a ser analisada, os "abertos" sem a jogada a ser analisada, os "fechados" e um contador para saber quantas iterações foram necessárias.

No algoritmo DFS, o grupo mante-ve uma estrutura similar ao algoritmo BFS, mas com as alterações necessárias para simular corretamente o DFS, ou seja:

- O DFS possui os mesmos argumentos que o BFS mais um novo argumento chamado "depth" (profundidade), pois no DFS, é necessário possuir uma profundidade limite. O grupo optou por atribuir a essa variavel a quantidade de peças que o tabuleiro começa na reserva, pois técnicamente, é impossivel efetuar mais jogadas sequenciais do que existe peças.

- Iremos tambem ter uma variavel let chamada "abertos_let" que funciona da mesma maneira que a do BFS, com a unica diferenca de ser o "append" onde ele irá guardar os sucessores de uma jogada sempre à esquerda no lugar de estar à direita, de forma a simular-mos o descer de uma árvore, temos tambem uma nova verificação caso o número de jogadas atinja a profundidade, ele irá subir na árvore.

- Temos tambem a variavel let "fechados_let" que funciona exatamente da mesma maneira que a do BFS.

- Temos tambem uma variavel let "cleanList" que tem o mesmo objetivo que o do BFS e é utilizada pelo mesmo motivo.

- Por fim, temos as nossas condições, onde a primeira verificação é caso tenha obtido uma solução, o DFS devolverá a informação pedida. 

- Temos tambem a verificação caso o "abertos_let" seja nulo, então não existe resultado.

- E por fim, no nosso "T", ele irá invocar o DFS novamente, para funcionar de uma forma puramente recursiva.

No algoritmo A*, irá ter uma estrutura similar aos anteriores, embora funcione de uma forma muito diferente. Em termos de argumentos, ele possui o nó inicial (tabuleiro + peças que começou o jogo), a variavel "moves", onde terá as jogadas efetuadas, ou seja, os nós que vamos trabalhar.

Temos tambem o argumento dos "abertos" e dos "fechados".

O código começa com uma variavel let chamada "abertos_let", onde caso os "abertos" seja nulo, devolverá todas as jogadas possiveis que se expandem do nó inicial e caso não seja nulo, irá guarda nos "abertos_let", todas as jogadas geradas do nó verificado mais a que ainda não foram verificadas e já se encontravam previamente nos abertos. 

Depois iremos ter a varivel let chamada "best_move" onde através da heuristica a ser utilizada, ele irá, procurar nos abertos pela jogada que tenha o melhor (menor) valor.

Temos agora tambem a variavel let "fechados_let" que caso esteja na primeira iteração, irá registar o "best_move" e caso não seja a primeira iteração ele irá fazer um "append" da "best_move" atual com as que foram previamente utilizadas.

Por fim temos a nossa condição com verificações, onde a primeira é, caso tenho encontrado uma solução, ele irá devolver a informação pedida. A nossa proxima verificação é cao os "abertos" sejam nulo, então ele percorreu todas as jogadass possiveis e não encontrou uma solução.

por fim temos a nossa ultima verificação que chama o A* para criar uma recursividade enviando como argumentos o nó inicial, a "best_move" encontrada para que possa gerar os seus sucessores, os "abertos_let" sem a "best_move" pois ela vai ser verificada, os "fechados_let" e um contador para saber o número de iterações. 




## **Limitações técnicas**

Em relação ás limitações do projeto, este mostra um erro na memória Heap em certos problemas, isto acontece devido à versão grátis do lispworks é limitada. 

Tambem é necessário extender a Stack para que possa correr certos problemas em certos algoritmos, por isso aconselha-se a utilizar o comando "(extend-current-stack 1000)", embora 1000 seja um bocado exagerado e desnecessário, garante que consegue correr todos.