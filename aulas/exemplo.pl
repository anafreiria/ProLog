% maximo(X, L) - X é o maior elemento da lista L <
maximo(X, [X]) :- !.
maximo(A, [A|B]) :- maximo(C, B), A >= C.
maximo(C, [A|B]) :- maximo(C, B), A < C.

% verifica se um valor é membro da lista <
membro(X, [X|_]) :- !.
membro(X, [_|Y]) :- membro(X, Y).

% verifica o comprimento de uma lista <
comp(0, []).,
comp(C, [_|B]) :- comp(A, B), C is A + 1.

% verifica o nesimo elemento de uma lista <
nesimo(1, [A|_], A).
nesimo(N, [_|Y], X) :- N > 1, N1 is N - 1, nesimo(N1, Y, X).

% fatos sobre doações e recebimentos de sangue
doa(a,a).
doa(a,ab).
doa(b,b).
doa(b,ab).
doa(ab,ab).
doa(o,a).
doa(o,b).
doa(o,ab).
doa(o,o).

recebe(a,a).
recebe(a,o).
recebe(b,b).
recebe(b,o).
recebe(ab,ab).
recebe(ab,o).
recebe(ab,a).
recebe(o,o).

% apaga(X, L, R) - R é a lista L sem o elemento X <
apaga(X, [X|Y], Y).
apaga(X, [Y|Z], [Y|Z1]) :- apaga(X, Z, Z1).

% permutação usando o predicado seleciona

seleciona(X, [X|Y], Y).
seleciona(X, [Y|Z], [Y|W]) :- seleciona(X, Z, W).

permuta(A, [B|D]) :- seleciona(B, A, C), permuta(C, D).
permuta([], []).


% reverte uma lista usando o predicado ap
ap([], L, L) :- !.
ap([A|B], C, [A|D]) :- ap(B, C, D).

reversa([], []) :- !.
reversa([A|B], R) :- reversa(B, D), ap(D, [A], R).


soma([],0).
soma([A|B], R) :- soma(B, R1), R os R1 + A.

ultimo([A], A).
ultimo([_|B], X) :- ultimo(B, X).

todos_iguais([]).
todos_iguais([_]).
todos_iguais([X, X | Resto]) :- todos_iguais([X | Resto]).

duplicados([], []).
duplicados([X|Resto], [X, X | DuplicadoResto]) :- duplicados(Resto, DuplicadoResto).

intercala([], [], []).
intercala([X|Xs], [Y|Ys], [X, Y | Zs]) :- intercala(Xs, Ys, Zs).




