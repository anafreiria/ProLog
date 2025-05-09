% Ordenação por Inserção

insereOrd(X, [Y|L], [X,Y|L]) :- X =< Y.
insereOrd(X, [Y|L], [Y|R]) :- X > Y, !, insereOrd(X, L, R).
insereOrd(X, [], [X]).

insercao([C|Ls], So) :- insercao(Ls, So1), insereOrd(C, So1, So).
insercao([], []).

% Ordenação por Seleção
min([X], X).
min([X|Xs], M) :- min(Xs, M1), (X < M1 -> M = X ; M = M1).

apaga(X, [X|Xs], Xs).
apaga(X, [Y|Xs], [Y|Ys]) :- apaga(X, Xs, Ys).

removeMin(M, L, Lo) :- min(L, M), apaga(M, L, Lo).

ordenaSelecao(L, [M|S]) :- removeMin(M, L, Lo), ordenaSelecao(Lo, S).
ordenaSelecao([], []).

% Ordenação por Troca

troca (L, S) :-append(Ord, [A,B|Ls], L), A > B, !, append(Ord, [B,A|Ls], Li), troca(Li, S).
troca (L, L).


% Ordenação por quickSort = particiona e ordena

% Caso 1: X < Pivo, adiciona X à lista de Menores
particao([X|L], Pivo, [X|Menores], Maiores) :-
    X < Pivo, !,
    particao(L, Pivo, Menores, Maiores).

% Caso 2: X >= Pivo, adiciona X à lista de Maiores
particao([X|L], Pivo, Menores, [X|Maiores]) :-
    X >= Pivo, !,
    particao(L, Pivo, Menores, Maiores).

% Caso base: lista vazia
particao([], _, [], []).

% QuickSort principal
quickSort([X|Xs], S) :-
    particao(Xs, X, Menores, Maiores),
    quickSort(Menores, SMenores),
    quickSort(Maiores, SMaiores),
    append(SMenores, [X|SMaiores], S).

% Caso base: lista vazia já está ordenada
quickSort([], []).
