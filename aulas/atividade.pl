% Exercicio 1

% Caso base: lista vazia resulta em lista vazia
empacota([], []).

% Caso geral: usa o predicado auxiliar empacota_aux/3
empacota([H|T], [Grupo|Resto]) :-
    empacota_aux(H, T, Grupo, Resto1),
    empacota(Resto1, Resto).

% empacota_aux(ElementoAtual, ListaRestante, GrupoFormado, RestoNaoProcessado)
empacota_aux(H, [], [H], []). % Fim da lista

empacota_aux(H, [H|T], [H|Grupo], Resto) :- % Continua grupo com elemento igual
    empacota_aux(H, T, Grupo, Resto).

empacota_aux(H, [X|T], [H], [X|T]) :- % Elemento diferente: grupo termina
    H \= X.


% empacota/2 (mesmo do exercício anterior)
empacota([], []).
empacota([H|T], [Grupo|Resto]) :-
    empacota_aux(H, T, Grupo, Resto1),
    empacota(Resto1, Resto).

empacota_aux(H, [], [H], []).
empacota_aux(H, [H|T], [H|Grupo], Resto) :-
    empacota_aux(H, T, Grupo, Resto).
empacota_aux(H, [X|T], [H], [X|T]) :-
    H \= X.


% Exercicio 2

% codifica1/2: usa empacota/2 e codifica grupos manualmente
codifica1(Lista, Resultado) :-
    empacota(Lista, Agrupada),
    codifica_grupos(Agrupada, Resultado).

% codifica_grupos/2: percorre os grupos e aplica contagem manual
codifica_grupos([], []).
codifica_grupos([[H|T]|Resto], [[N, H]|CodificadoResto]) :-
    conta([H|T], 0, N),
    codifica_grupos(Resto, CodificadoResto).

% conta/3: conta número de elementos em uma lista
conta([], Acc, Acc).
conta([_|T], Acc, N) :-
    Acc1 is Acc + 1,
    conta(T, Acc1, N).

% Exercicio 3

% ---------- codifica2/2 ----------
codifica2(Lista, Resultado) :-
    empacota(Lista, Agrupada),
    codifica_condicional(Agrupada, Resultado).

% codifica_condicional/2: transforma [[a,a,a],[b],...] em [[3,a],b,...]
codifica_condicional([], []).
codifica_condicional([[H|T]|Resto], [[N,H]|CodificadoResto]) :-
    conta([H|T], 0, N),
    N > 1,
    codifica_condicional(Resto, CodificadoResto).
codifica_condicional([[H]|Resto], [H|CodificadoResto]) :-
    codifica_condicional(Resto, CodificadoResto).


% Exercicio 4

% decodifica2/2: trata cada elemento da lista codificada
decodifica2([], []).

decodifica2([[N, E]|T], Resultado) :-
    repete(E, N, L1),              % expande [N,E] para lista com N vezes E
    decodifica2(T, L2),            % processa o resto da lista
    append(L1, L2, Resultado).     % junta as listas

decodifica2([E|T], [E|R]) :-       % elemento simples (não empacotado)
    E \= [_,_],                    % garante que não é um [N,E]
    decodifica2(T, R).

% repete(Elemento, N, Lista): cria uma lista com N vezes o Elemento
repete(_, 0, []).
repete(E, N, [E|T]) :-
    N > 0,
    N1 is N - 1,
    repete(E, N1, T).
