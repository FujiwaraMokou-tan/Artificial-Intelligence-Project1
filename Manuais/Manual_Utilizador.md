# Manual de Utilizador

Inteligência Artificial - Escola Superior de Tecnologia de Setúbal  
2020/2021

André Nascimento nº160221075

Eduardo Ferreira nº110221031

## **Acrónimos e Conveções usadas**

BFS - Breath First Search

DFS - Depth First Search


## **Introdução**

Este manual servirá de guia para a execução e resolução do problema do Quatro, proposto ambita da unidade curricular de Inteligencia Artificial (IA).

Este é constituido por um tabuleiro de 4x4 casas, juntamente com um conjunto de peças, podendo ter até 16 peças dependendo do problema, estas podem ter algumas caracteristicas na forma de formato(cheia ou oca) e cor (brancas ou pretas).

O problema proposto tem como objetivo, a aplicação de algoritmos de procora em espaços de estado, mostrando a sequencia de estados/jogadas que são executadas de uma posição inicial até à posição final.


## **Instalação e utilização**

1. O utilizador começa por abrir o LispWorks, de seguida vai abrir no _editor_ o ficheiro _project.lisp_ e depois clica no botão _compile buffer_ que vai compilar todas as funções necessárias para correr o projeto.
2. voltar para o _listener_ e executa o comando _(iniciar).
3. Após ter sido iniciado, o programa interage com o utilizador, perguntando-lhe qual é o algoritmo que este deseja testar:

- BFS
- DFS
- A*

4. Após o utilizador ter escolhido o algoritmo, ser-lhe-á qual é o problema que este deseja testar
5. Após ter sido escolhido o problema, o código iniciará automaticamente e realizará a solução desejada para esse problema.

Nota: 

Não é aconselhável correr o _BFS_ nos problemas 4, 5 e 6 enquanto se utiliza a versão grátis do LispWorks, pois esta tem uma Heap limitada.

Caso o utilizador deseje testar o _BFS_ no problema 3, é recomendado que o utilizador aumenteo tamanho da Stack ligeiramente, efetuando o comando _(extend-current-stack *percentagem desejada para aumentar)_.
O problema 3 no _BFS_ funcionava perfeitamente quando as funções de algoritmo estavam todas no mesmo ficheiro lisp, mas após separa-las em _puzzle.lisp_ e _procura.lisp_ é necessário aumentar o tamanho da Stack um pouco mais.

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790196490579869716/unknown.png)  
Figura 1: Aumentar o tamanho da Stack.

 
## **Input/Output**

Quando o programa é executado, o utilizador insere o algoritmo que deseja executar, podendo ser o _BFS_, o _DFS_ ou o _A*_, juntamente com o problema que deseja resolver.

O programa, ao ser executado, irá mostrar a sequencia de jogadas, sendo esta lida da direita para a esquerda(a jogada mais à direita é a primeira jogada).

![Compile](https://cdn.discordapp.com/attachments/790020871858421761/790022810143293450/unknown.png)  
Figura 2: Exemplo da execução do programa.


## **Exemplo de aplicação**

Para o programa ser executado sem problema, os comandos necessários para tal são:_

1. _(iniciar)_ - Executa o programa.

2. _BFS/DFS/A*_ - Escolhe-se o algoritmos que deseja usar.

3. _1/2/3/4/5/6_ - Escolhe-se o número de problemas que deseja resolver.
