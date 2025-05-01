% Exercicio 2

pertence(X, [X|_]).
pertence(X, [_|Resto]) :- pertence(X, Resto).

remove_duplicados([], []).
remove_duplicados([A|B], C) :- pertence(A,B), remove_duplicados(B,C).

% Exercicio 2

troca_argumentos([],_,_,[]).
troca_argumentos([A|C], A, X, [X|D]) :- troca_argumentos(C, A, X, D).
troca_argumentos([B|C], A, X, [B|D]) :- troca_argumentos(C, A, X, D).

% Exercicio 3

mais_longa([], [_|_]).
mais longa([_|B], [_|D]) :- mais_longa(B, D).

% Exercicio 4

nesimo([A|_], 1, A).
nesimo([_|Y], N, X) :- N>1, N1 is N-1, nesimo(Y, N1, X).

% Exercicio 5

media([], 0) :- !.
media(Lista, Media) :- soma_e_conta(Lista, Soma, Contador), Media is Soma / Contador.

soma_e_conta([], 0, 0).
soma_e_conta([A|B], Soma, Contador) :- soma_e_conta(B, Soma1, Contador1), Soma is Soma1 + A, Contador is Contador1 + 1.

% Exercicio 6

minimo([A], A).
minimo([H|T], Min) :- minimo(T, MinT), (H < MinT -> Min is H ; Min is MinT).

% Exercicio 7

intervalo(Inf, Sup, []) :- Inf > Sup.
intervalo(Inf, Sup, [Inf|Resto]) :- Inf <= Sup, NovoInf is Inf + 1, intervalo(NovoInf, Sup, Resto).

ocorrencias(_, 0, []).
ocorrencias(Elem, [Elem|Resto], N) :- ocorrencias(Elem, Resto, N1), (N is N1 + 1).
ocorrencias(Elem, [Outro|Resto], N) :- Outro \= Elem, ocorrencias(Elem, Resto, N).




 