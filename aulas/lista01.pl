% Exercicio 1
analisa_lista([]) :- write('Lista vazia!'), nl.
analisa_lista([A|B]) :-
    write('A cabeça da lista é: '), write(A), nl,
    write('A cauda da lista é: '), write(B), nl,

% Exercicio 2 <
pertence(X, [X|_]).
pertence(X, [_|Y]) :- pertence(X, Y).

remove_duplicados([], []).
remove_duplicados([A|B], C) :-
    pertence(A, B),
    remove_duplicados(B, C).

% Exercicio 3 <
troca_argumentos([],_,_,[]).
troca_argumentos([A|C], A, X,[X|D]) :- troca_argumentos(C,A,X,D).
troca_argumentos([B|C], A, X, [B|D]) :- troca_argumentos(C,A,X,D).

% Exercicio 4
% O conjunto potência de uma lista vazia é uma lista contendo a lista vazia
potencia([], [[]]).

% Para cada subconjunto gerado da cauda, adiciona o elemento da cabeça
potencia([H|T], P) :-
    potencia(T, PT),
    adiciona(H, PT, PComH),
    append(PT, PComH, P).

% adiciona(Elemento, ListaDeSubconjuntos, NovosSubconjuntosComElemento)
adiciona(_, [], []).
adiciona(X, [Sub|Subs], [[X|Sub]|Resto]) :-
    adiciona(X, Subs, Resto).


% Exercicio 5 <

mais_longa([], [_|_]).
mais_longa([_|A], [_|B]) :- mais_longa(A, B).

% Exercicio 6 
distancia((X1,Y1), (X2,Y2), D) :-
    DX is X2 - X1,
    DY is Y2 - Y1,
    D is sqrt(DX*DX + DY*DY).


% Exercicio 8 <
nesimo([A|_], 1, A).
nesimo([_|Y], N, X) :- N > 1, N1 is N - 1, nesimo(Y, N1, X).

% Exercicio 9

media([], 0) :- !.

% Predicado principal
media(Lista, Media) :-
    soma_e_conta(Lista, Soma, Contador),
    Media is Soma / Contador.

% soma_e_conta(Lista, Soma, Contador) - retorna soma e número de elementos
soma_e_conta([], 0, 0).
soma_e_conta([H|T], Soma, Contador) :-
    soma_e_conta(T, Soma1, Contador1),
    Soma is Soma1 + H,
    Contador is Contador1 + 1.


% Exercicio 10 <

% Caso especial: lista vazia
minimo([], _) :-
    write('Erro: lista vazia, não há mínimo.'), nl,
    fail.

% Caso base: um único elemento
minimo([X], X).

% Caso recursivo
minimo([H|T], Min) :- minimo(T, MinT), ( H < MinT -> Min = H ; Min = MinT ).


% Exercicio 11
% Caso base: limite inferior maior que o superior → lista vazia
intervalo(Inf, Sup, []) :- Inf > Sup.

% Caso recursivo: adiciona o número atual e avança
intervalo(Inf, Sup, [Inf|Resto]) :-
    Inf =< Sup,
    Prox is Inf + 1,
    intervalo(Prox, Sup, Resto).


% Exercicio 12 <
% Caso base: se o segundo número for 0, o resultado é o primeiro
mdc(A, 0, A) :- A >= 0.

% Caso recursivo: mdc(A, B) = mdc(B, A mod B)
mdc(A, B, R) :-
    B > 0,
    Rem is A mod B,
    mdc(B, Rem, R).

% Exercicio 13  <

% Caso base: lista vazia -> 0 ocorrências
ocorrencias(_, [], 0).

% Caso recursivo: cabeça da lista é o elemento buscado
ocorrencias(Elem, [Elem|Resto], N) :-
    ocorrencias(Elem, Resto, N1),
    N is N1 + 1.

% Caso recursivo: cabeça diferente do  elemento buscado
ocorrencias(Elem, [_|Resto], N) :-
    ocorrencias(Elem, Resto, N).


% Exercicio 14 
% Gera todos os divisores de N
divisores(N, Divisores) :-
    N > 0,
    findall(D, (between(1, N, D), N mod D =:= 0), Divisores).


% Exercicios chat

ultimo([A], A). <
ultimo([_|B], X) :- ultimo(B, X).

tamanho([], 0). <
tamanho([_|B], R) :- tamanho(B, R1), R is R1 + 1.

pertence(X, [X|_]). <
pertence(X,[_|Q]) :- pertence(X, Q).

soma([], 0). <
soma([A|B], R) :- soma(B, R1), R IS R1 + A.

concatena([], L, L). <
concatena([A|B], L, [A|R]) :- concatena(B, L, R).

inverter([], []). <
inverter([A|B], L) :- inverter (B, R), concatena(R, [A], L).

mesmo_tamanho([], []). <
mesmo_tamanho([_|A], [_|B]) :- mesmo_tamanho(A, B).

% Remover elementos consecutivos remove_duplicados <

remove_duplicados([], []).
remove_duplicados([X], [X]).
remove_duplicados([X, X|Resto], Resultado) :- remove_duplicados([X|Resto], Resultado).
remove_duplicados([X, Y|Resto], [X|Resultado]) :- X \= Y, remove_duplicados([Y|Resto], Resultado).


% imprime o penultimo elemento de uma lista <

penultimo(X, [X, _]).
penultimo(X, [_|T]) :- penultimo(X, T).






