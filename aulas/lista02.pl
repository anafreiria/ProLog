% Exercicio 1
% Qual é o resultado das seguintes consultas em Prolog?
% ?- forall(member(X,[1,2,3]),write(X)). Ele vai escrever todos os elementos da lista [1,2,3] um por um.
% ?- forall(between(1,5,I),(write(I*I),write(’ ’))). Ele vai escrever na tela 1*1, 2*2, 3*3, 4*4, 5*5, cada um seguido de um espaço.
% ?- forall(between(10,20,I),write(I:’ ’)). Vai escrever 10: 11: 12: 13: 14: 15: 16: 17: 18: 19: 20:
% ?- forall(between(1,5,I), (Q is I*I, write(Q), write(' '))). Aqui ele escreveria o quadrado de cada número de 1 a 5, ou seja, 1 4 9 16 25.

/*Exercício 2:
Considere o seguinte programa Prolog:
a:-a(0).
a(X):- X>10,!.
a(X):- write(X),write(’ ’), X1 is X+1,a(X1).
Qual será o resultado da seguinte consulta Prolog:
?- a.
Ao chamar a., o programa Prolog irá iniciar a execução do predicado `a` com o argumento 0. O predicado `a(0)` será chamado, e como a primeira cláusula de `a` não tem corpo, ele irá chamar `a(X)` com `X = 0`.
O predicado `a(X)` será executado com `X = 0`, e como `0` não é maior que `10`, ele não irá satisfazer a primeira cláusula do predicado `a(X)`. Então, ele irá escrever `0` na tela e incrementará `X` para `1`, chamando `a(1)`. Esse processo continuará até que `X` atinja o valor de `11`, momento em que a cláusula `X > 10` será satisfeita, e a execução do predicado será interrompida devido ao corte (`!`). Portanto, o resultado final será a impressão dos números de `0` a `10`, cada um seguido por um espaço.
*/

a :- a(0).

a(X) :- X > 10, !.
a(X) :- write(X), write(' '), X1 is X + 1, a(X1).

/* Exercicio 3:
Faça um predicado que gere a pirâmide abaixo. Use o predicado wN/1.
wN(0):-write(0),!.
wN(N):-write(N),N1 is N-1, wN(N1),write(N).
Exemplo de uso:
?- xxx(3).
0
101
21012
3210123
*/

wN(0) :- write(0), !.
wN(N) :- write(N), N1 is N - 1, wN(N1), write(N).

xxx(N) :- xxx_linhas(0, N).

xxx_linhas(I, N) :- I =< N, wN(I), nl, I1 is I + 1, xxx_linhas(I1, N).
xxx_linhas(I, N) :- I > N.

/*Exercicio 4:
Usando um acumulador, e somente as operações (+)(-)(*), desenvolva um predicado
Prolog para calcular X elevado a Y. Assuma X e Y inteiros.*/

% Caso base: qualquer número elevado a 0 é 1
potencia(_, 0, 1) :- !.

% Caso geral: chama auxiliar com acumulador
potencia(X, Y, Resultado) :- Y > 0, potencia_aux(X, Y, 1, Resultado).

% Auxiliar com acumulador
% potencia_aux(Base, Expoente, AcumuladorAtual, ResultadoFinal)
potencia_aux(_, 0, Acc, Acc) :- !.
potencia_aux(X, Y, Acc, R) :- Y > 0, NewAcc is Acc * X, NewY is Y - 1, potencia_aux(X, NewY, NewAcc, R).

/*Exercício 5:
Dados os fatos:
d(0).
d(1).
Qual é o resultado da seguinte consulta Prolog:
?- findall([A,B],(d(A),d(B)),L)
*/ 
% A consulta irá gerar todas as combinações possíveis de A e B, onde A e B podem ser 0 ou 1, resultando em uma lista de listas.

d(0).
d(1).

/*Exercício 6:
Defina o predicado palindromo/1, que é verdadeiro se a lista é um palı́ndromo,
por exemplo, [a,b,c,d,c,b,a].
*/
reverse(L, R) :- reverse_aux(L, [], R).
reverse_aux([], Acc, Acc).
reverse_aux([H|T], Acc, R) :-
    reverse_aux(T, [H|Acc], R).

palindromo(L) :- reverse(L, L).

/*Exercício 7:
Defina um predicado metIguais/1, que é verdadeiro se uma lista é formada por
duas metades iguais. Use o append. Seguem dois exemplos de uso.
?-metIguais([a,b,c, a,b,c]).
Yes
?-metIguais([a,b,c, a,b,d]).
No
*/

metIguais(L) :- append(L1, L2, L), same_length(L1, L2), L1 = L2.
% o appendaqui funciona de froma contraria, dividindo a lista em varias sublistas, e o same_length garante que as duas metades tenham o mesmo tamanho, e por fim, L1 = L2 garante que as duas metades sejam iguais.

/*
Faça um predicado insOrd/3, que insere um elemento numa lista mantendo-a ordenada.
Faça duas regras: uma base e uma recursiva.
*/
% Caso base: inserir na frente se a lista estiver vazia ou o elemento for menor ou igual ao primeiro
insOrd(Elem, [], [Elem]).
insOrd(Elem, [H|T], [Elem,H|T]) :- Elem =< H.

% Caso recursivo: manter o primeiro elemento e continuar na cauda
insOrd(Elem, [H|T], [H|R]) :- Elem > H, insOrd(Elem, T, R).


/*
Exercício 9:
Faça um predicado que particiona/3 uma lista em duas, de tamanho igual se o número de
elementos for par, senão uma delas terá um elemento a mais. Tire dois elementos de uma
lista (se possı́vel) e ponha cada um em uma lista resultado.
*/
% Caso base: lista vazia gera duas listas vazias
particiona([], [], []).

% Caso base: um elemento só vai para a primeira lista
particiona([X], [X], []).

% Caso recursivo: tira dois da lista e distribui entre as duas listas resultantes
particiona([X,Y|Resto], [X|L1], [Y|L2]) :-
    particiona(Resto, L1, L2).

/*
Exercicio 10
Faça o predicado merge/3, que junta duas listas ordenadas em uma terceira, mantendo a
ordem. Como segue:
?- merge([a,b,b,k,z], [c,m,n,o], X).
X=[a,b,b,c,k,,m,n,o,z], yes*/

% Caso base: se a primeira lista está vazia, o resultado é a segunda
merge([], L, L).

% Caso base: se a segunda lista está vazia, o resultado é a primeira
merge(L, [], L).

% Caso recursivo: H1 vem antes ou é igual a H2
merge([H1|T1], [H2|T2], [H1|R]) :-
    H1 @=< H2,
    merge(T1, [H2|T2], R).

% Caso recursivo: H2 vem antes de H1
merge([H1|T1], [H2|T2], [H2|R]) :-
    H1 @> H2,
    merge([H1|T1], T2, R).

% @=< e @> são usados para comparar elementos alfabeticos de listas, garantindo que a ordem seja mantida.

/*Exercício 13:
Usando findall, defina e teste os predicados pred1/2, pred2/2 e pred3/2 que modificam
uma lista, conforme ilustrado nos seguintes exemplos:
*/

pred1(L, R) :-
    findall([X], member(X, L), R).

pred2(L, R) :-
    findall(pred([X], X), member(X, L), R).

pred3(L, R) :-
    findall([element, X], member(X, L), R).

% findall(Elemento, Geração, Lista).


/*Exercício 14:
Considere o seguinte problema: “Há dois jarros com capacidades de 3 e 4 litros,
respectivamente. Nenhum dos jarros contém qualquer medida ou escala, de modo que só
se pode saber o conteúdo exato quando eles estão cheios. Sabendo-se que podemos
encher ou esvaziar um jarro, bem como transferir água de um jarro para outro, encontre
uma sequência de passos que deixe o jarro de 4 litros com exatamente 2 litros de água”.
Considere que o estado inicial pode ser representado pela lista [0,0], indicando que os
jarros de 3 e 4 litros estão vazios inicialmente e a meta é [_,2]. Complete os predicados
transforma abaixo para descrever todas as transformações possíveis de estados desse
problema.
transforma('encher o jarro 1', [X,Y], [3,Y]) :- X < 3.
transforma('enchar o jarro 2', [X,Y], [X,4]) :- Y < 4.
transforma('esvaziar o jarro 1', [X,Y], [0,Y]) :- X > 0.
transforma('esvaziar o jarro 2', [X,Y], [X,0]) :- Y > 0.
transforma('transferir do jarro 1 para o 2',[X,Y], [0, Y+X] :- X>O, Y<4
transforma('transferir do jarro 2 para o 1', [X,Y], [X+Y, 0]) :- Y>0, X<3.
%--- considerando que ainda restara agua no jarro de origem
transforma('transferir do jarro 1 para o 2', [X,Y], [X1,Y1]) :-
    X > 0,
    Y < 4,
    Transfer is min(X, 4 - Y),
    X1 is X - Transfer,
    Y1 is Y + Transfer.
transforma('transferir do jarro 2 para o 1', [X,Y], [X1,Y1]) :-
    Y > 0,
    X < 3,
    Transfer is min(Y, 3 - X),
    X1 is X + Transfer,
    Y1 is Y - Transfer.
*/

/*Altere o predicado emordem para representar somente os nós folhas da arvore
Estado antes:
emordem ([]).
emordem(no(I,E,D)) :- emordem(E), write(I), nl, em ordem(D).
*/

insere(X, [], no(X, [], [])) :- !.  % Caso base: insere em uma árvore vazia
insere(X, no(X, E, D), no(X, E, D)) :- !.  % Caso: já existe o elemento
insere(X, no(I, E, D), no(I, E1, D)) :- X < I, !, insere(X, E, E1).  % Insere na subárvore esquerda
insere(X, no(I, E, D), no(I, E, D1)) :- X > I, insere(X, D, D1).  % Insere na subárvore direita


emordem([]).
emordem(no(I, [], [])) :-         % nó folha
    write(I), nl.
emordem(no(_, E, D)) :-           % nó interno
    emordem(E),
    emordem(D).

/* Esse exercício define um predicado que encontra pontos em quadrantes específicos de um plano cartesiano.
*/
% fatos
pto(1,3).
pto(-1,5).
pto(-1,-2).
pto(3,-1).
pto(2,4).
pto(4,-5).

% regra principal
quadrante(N, L) :-
    findall(pto(X,Y), ponto_quadrante(N, X, Y), L).

% condições por quadrante
ponto_quadrante(1, X, Y) :- X > 0, Y > 0.
ponto_quadrante(2, X, Y) :- X < 0, Y > 0.
ponto_quadrante(3, X, Y) :- X < 0, Y < 0.
ponto_quadrante(4, X, Y) :- X > 0, Y < 0.

/**/
carro(fusca, branco, 1974).
carro(gol, vermelho, 1980).
carro(voyage, preto, 1978).
carro(gol, branco, 2001).
carro(uno, branco, 2004).

% ?- findall(Marca-Ano, carro(Marca, branco, Ano), L).
% Consulta que deve retornar uma lista de pares Marca-Ano para carros brancos.

/*Objetivo: Implementar o predicado pares/2 que filtra os números pares de uma lista.*/

pares([], []).
pares([H|T], [H|R]) :- H mod 2 =:= 0, pares(T, R).
pares([H|T], R) :- H mod 2 =\= 0, pares(T, R).

/*Objetivo: Implementar trunca/3 para cortar a lista após N elementos.
*/

trunca(_, 0, []) :- !.
trunca([], _, []) :- !.
trunca([H|T], N, [H|R]) :-
    N1 is N - 1,
    trunca(T, N1, R).

