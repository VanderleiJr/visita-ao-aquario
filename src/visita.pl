%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Vanderlei Junior - XXXXXX                       %
%                      Vitor Sugaya - XXXXXX                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    https://rachacuca.com.br/logica/problemas/visita-ao-aquario/    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Auxiliares
pertence(Elem,[Elem|_]).
pertence(Elem,[_|Cauda]) :- pertence(Elem,Cauda).

%%% Estruturas
% Criamos uma lista recursiva com N elementos.
% A cada chamada o contador N é decrementado e salvo em N1
% Quando o contador chega a 0, é interrompido com um controle de retrocesso.
amigas(0, []) :- !.
amigas(N, [(_Mochila, _Nome, _Sobrenome, _Suco, _Signo, _Animal)|T]) :- N1 is N-1, amigas(N1, T).

% Aqui vamos fazendo a interação dos elemntos até encontrarmos o
% elemento ótimo, assim, quando se chega na iteração com o índice 1,
% novamente o controle de retrocesso é utilizado.
amiga(1, [Cabeca|_], Cabeca) :- !.
amiga(N, [_|Cauda], R) :- N1 is N-1, amiga(N1, Cauda, R).

%%% Regras/Requisitos
% #01 - A menina da mochila Branca tem sobrenome Andrade.
regra01([(branca, _, andrade, _, _, _)|_]).
regra01([_|Cauda]) :- regra01(Cauda).

% #02 - A garota da mochila Amarela está em algum lugar entre a da mochila Verde e a Sabrina, nessa ordem.
% A lógica dessa regra é, verificar se existe o primeiro da sequência, e logo então,
% chamar uma função auxiliar para verificar a existência do segundo elemento da sequência
% e por último, verificar o último elemento da sequência, sempre conferindo a cauda.
regra02([(verde, _, _, _, _, _)|Cauda]) :- regra02b(Cauda).
regra02([_|Cauda]) :- regra02(Cauda).

regra02b([(amarela, _, _, _, _, _)|Cauda]) :- regra02c(Cauda).
regra02b([_|Cauda]) :- regra02b(Cauda).

regra02c([(_, sabrina, _, _, _, _)|_]).
regra02c([_|Cauda]) :- regra02c(Cauda).

% #03 - A menina de Câncer está exatamente à direita da que quer ver o Peixe-boi.
regra03([(_, _, _, _, _, peixe-boi),(_, _, _, _, cancer, _)|_]).
regra03([_|Cauda]) :- regra03(Cauda).

% #04 - Milene e Sabrina estão lado a lado.
regra04([(_, milene, _, _, _, _),(_, sabrina, _, _, _, _)|_]).
regra04([(_, sabrina, _, _, _, _),(_, milene, _, _, _, _)|_]).
regra04([_|Cauda]) :- regra04(Cauda).

% #05 - A garota que quer ver a Piranha está em uma das pontas.
regra05(Amiga) :- amiga(1, Amiga, (_, _, _, _, _, piranha)); 
                 amiga(5, Amiga, (_, _, _, _, _, piranha)).

% #06 - Milene é do signo de Virgem.
regra06([(_, milene, _, _, virgem, _)|_]).
regra06([_|Cauda]) :- regra06(Cauda).

% #07 - A garota do signo de Áries está ao lado da que quer ver o Peixe-boi.
% (A Regra 03 acaba limitando esta regra, onde a garota só pode estar a esquerda)
regra07([(_, _, _, _, aries, _),(_, _, _, _, _, peixe-boi)|_]).
regra07([_|Cauda]) :- regra07(Cauda).

% #08 - Sabrina está em uma das pontas.
regra08(Amiga) :- amiga(1, Amiga, (_, sabrina, _, _, _, _));
                 amiga(5, Amiga, (_, sabrina, _, _, _, _)).

% #09 - Na terceira posição está a menina que gosta de suco de Maçã.
regra09(Amiga) :- amiga(3, Amiga, (_, _, _, maca, _, _)).

% #10 - A menina da mochila Amarela está em algum lugar entre a Regina e a garota de sobrenome Andrade, nessa ordem.
regra10([(_, regina, _, _, _, _)|Cauda]) :- regra10b(Cauda).
regra10([_|Cauda]) :- regra10(Cauda).

regra10b([(amarela, _, _, _, _, _)|Cauda]) :- regra10c(Cauda).
regra10b([_|Cauda]) :- regra10b(Cauda).

regra10c([(_, _, andrade, _, _, _)|_]).
regra10c([_|Cauda]) :- regra10c(Cauda).

% #11 - A garota que quer ver o Tubarão está exatamente à direita da garota da mochila Amarela.
regra11([(amarela, _, _, _, _, _),(_, _, _, _, _, tubarao)|_]).
regra11([_|Cauda]) :- regra11(Cauda).

% #12 - A menina de sobrenome Lima está ao lado da garota que gosta de suco de Uva.
regra12([(_, _, lima, _, _, _),(_, _, _, uva, _, _)|_]).
regra12([_|Cauda]) :- regra12(Cauda).

% #13 - Na segunda posição está a menina que nasceu em outubro.
% (Como LIBRA não consta no exercício, o a resposta é ESCORPIÃO)
regra13(Amiga) :- amiga(2, Amiga, (_, _, _, _, escorpiao, _)).

% #14 - A garota do sobrenome Santos deseja ver o Peixe-boi.
regra14([(_, _, santos, _, _, peixe-boi)|_]).
regra14([_|Cauda]) :- regra14(Cauda).

% #15 - Em uma das pontas está a menina do signo de Peixes.
regra15(Amiga) :- amiga(1, Amiga, (_, _, _, _, peixes, _));
                 amiga(5, Amiga, (_, _, _, _, peixes, _)).

% #16 - A garota do signo de Câncer tem o sobrenome Dias.
regra16([(_, _, dias, _, cancer, _)|_]).
regra16([_|Cauda]) :- regra16(Cauda).

% #17 - A menina da mochila Azul está em algum lugar à esquerda da que gosta de suco de Maracujá.
% Como a verificação é apenas para saber se está a esquerda, independente da posição
% Após encontrarmos a mochila AZUL na cabeça, perguntamos se o MARACUJA pertence a cauda
regra17([(azul, _, _, _, _, _)|Cauda]) :- pertence((_, _, _, maracuja, _, _),Cauda).
regra17([_|Cauda]) :- regra17(Cauda).

% #18 - A menina que gosta de suco de Maçã está ao lado da que quer ver o Lobo-marinho.
regra18([(_, _, _, maca, _, _),(_, _, _, _, _, lobo-marinho)|_]).
regra18([(_, _, _, _, _, lobo-marinho),(_, _, _, maca, _, _)|_]).
regra18([_|Cauda]) :- regra18(Cauda).

% #19 - A garota da mochila Amarela está em algum lugar entre a do signo de Peixes e a Cristina, nessa ordem.
regra19([(_, _, _, _, peixes, _)|Cauda]) :- regra19b(Cauda).
regra19([_|Cauda]) :- regra19(Cauda).

regra19b([(amarela, _, _, _, _, _)|Cauda]) :- regra19c(Cauda).
regra19b([_|Cauda]) :- regra19b(Cauda).

regra19c([(_, cristina, _, _, _, _)|_]).
regra19c([_|Cauda]) :- regra19c(Cauda).

% #20 - A menina que gosta de suco de Caju está em uma das pontas.
regra20(Amiga) :- amiga(1, Amiga, (_, _, _, caju, _, _));
                 amiga(5, Amiga, (_, _, _, caju, _, _)).

% #21 - Gisele é a dona da mochila Amarela.
regra21([(amarela, gisele, _, _, _, _)|_]).
regra21([_|Cauda]) :- regra21(Cauda).

% #22 - Regina está em uma das pontas.
regra22(Amiga) :- amiga(1, Amiga, (_, regina, _, _, _, _));
                 amiga(5, Amiga, (_, regina, _, _, _, _)).

% #23 - A garota que quer ver o Tubarão está em algum lugar entre a que gosta de suco de Uva e a quer ver a Arraia, nessa ordem.
regra23([(_, _, _, uva, _, _)|Cauda]) :- regra23b(Cauda).
regra23([_|Cauda]) :- regra23(Cauda).

regra23b([(_, _, _, _, _, tubarao)|Cauda]) :- regra23c(Cauda).
regra23b([_|Cauda]) :- regra23b(Cauda).

regra23c([(_, _, _, _, _, arraia)|_]).
regra23c([_|Cauda]) :- regra23c(Cauda).

%%% Regras/Requisitos Extras
% Três itens não são citados em nenhuma regra, então, não são necessários para finalizar o exercício
% porém, para preencher as váriaveis, vamos citá-los com as três regras abaixo.
% Nas regras extras, nós não passamos nenhuma posição, só dizemos que esses itens existem para o
% nosso programa descobrir onde encaixalas.
% regraExtra01
regraExtra01([(_, _, rocha, _, _, _)|_]).
regraExtra01([_|Cauda]) :- regraExtra01(Cauda).

% regraExtra02
regraExtra02([(vermelha, _, _, _, _, _)|_]).
regraExtra02([_|Cauda]) :- regraExtra02(Cauda).

% regraExtra03
regraExtra03([(_, _, _, laranja, _, _)|_]).
regraExtra03([_|Cauda]) :- regraExtra03(Cauda).

% Solução
solucao(Amigas) :-
    amigas(5, Amigas),
    regra01(Amigas),
    regra02(Amigas),
    regra03(Amigas),
    regra04(Amigas),
    regra05(Amigas),
    regra06(Amigas),
    regra07(Amigas),
    regra08(Amigas),
    regra09(Amigas),
    regra10(Amigas),
    regra11(Amigas),
    regra12(Amigas),
    regra13(Amigas),
    regra14(Amigas),
    regra15(Amigas),
    regra16(Amigas),
    regra17(Amigas),
    regra18(Amigas),
    regra19(Amigas),
    regra20(Amigas),
    regra21(Amigas),
    regra22(Amigas),
    regra23(Amigas),
    regraExtra01(Amigas),
    regraExtra02(Amigas),
    regraExtra03(Amigas).
