apaga(A, [A|B], B).
apaga(X,[Y|Z],[Y|W]) :- apaga(X,Z,W).

intervalo(I,I,[I]).
intervalo(I,F,[I|L]) :- I < F, I1 is I+1, intervalo(I1,F,L).

solucao(N,S) :- 
    intervalo(1,N,LC), 
    N2 is N*2,
    intervalo(2,N2,DI),
    I is -1*(N - 1),
    F is N - 1,
    intervalo(I,F,DS),
    resolve(S,LC,LC,DS,DI).



resolve([],[],_,_,_).
resolve([(L,C)|LC],[L|LL], CO,DS,DI) :-
    apaga(C,CO,CO1), 
    NS is L-C,
    NI is L+C,
    apaga(NS,DS,DS1),
    apaga(NI,DI,DI1),
    resolve(LC,LL,CO1,DS1,DI1).

