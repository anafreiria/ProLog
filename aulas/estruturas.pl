-- Pilha
empilha (A, B, [A|B]) :- !
desempilha (A, [A|B], B) :- !

empLista([A|B],X,Z) :- empilha(A,X,Y), !, empLista(B,Y,Z).
empLista([],A,A) :- !.

-- Essa linha diz: "para empilhar todos os elementos da lista [A|B] na pilha X, empilhe A em X para obter Y, e então empilhe os elementos de B em Y, produzindo Z."


-- Fila 

insere (A, B, F) :- append(B, [A], F).
retira (A, [A|B], B) :- !.

insLista([A|B],X,Z) :- insere(A,X,Y), !, insLista(B,Y,Z).
insLista([],A,A) :- !.

% Uma representaçao de árvore em Prolog
% no(raiz, esq, dir)
no(a,b,c).
no(b,d,[]).
no(d,[],[]).
no(c,e,f).
no(e,[],g).
no(f,[],[]).
no(g,[],[]).


preordem([]).
preordem(X) :- write(X), write(’ ’), no(X,E,D), preordem(E), preordem(D).

emordem([]).
emordem(X) :- no(X,E,D), emordem(E), write(X), write(’ ’), emordem(D).

posordem([]).
posordem(X) :- no(X,E,D), posordem(E), posordem(D), write(X), write(’ ’).

% Agora, representação de arvore para que o usuario possa inserir os nós

insereBin (X,[], no(X,[],[])).
insereBin (x, no(X.E.D), no(X,E,D)).
insereBin (X, no(Y,E,D), no(Y,E1,D)) :- X < Y, !, insereBin(X,E,E1).
insereBin (X, no(Y,E,D), no(Y,E,D1)) :- X > Y, !, insereBin(X,D,D1).


preordemBin([]).
preordemBin (no(I,E,D)) :- write(I), write(’ ’), preordemBin(E), preordemBin(D).

emordemBin([]).
emordemBin (no(I,E,D)) :- emordemBin(E), write(I), write(’ ’), emordemBin(D).

posordemBin([]).
posordemBin (no(I,E,D)) :- posordemBin(E), posordemBin(D), write(I), write(’ ’).