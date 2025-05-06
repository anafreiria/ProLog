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
