#!/usr/bin/env swipl
/*  Author:     Craig Opie
    Email:      opieca@hawaii.edu
    Assignment: No. 4
    References: https://www.swi-prolog.org/pldoc/doc_for?object=dif/2
*/

% Create a recursive Prolog predicate listlength/2 that has a list as its first argument, and the length of that list 
% as its second argument.
listlength([], 0).
listlength([_|T],L) :- listlength(T,I), L is I + 1.

% listlength(L, 3). 
% Results: L = [_, _, _].
% Reason: Because prolog operates as "predicate(in, out) :- definition of what out is".  We passed L to the input which
% is defining the atom L and since L is not a list, it returns an empty list.  However, we are performing a recursive
% predicate so the returned value is recursed the number of times specified in the output.  If we were to pass this:
% listlength(L, 4). the result would be L = [_, _, _, _].

% Write predicates that will find solutions for each of the following colored-balls-in-a-row problems with different 
% sets of constraints.
% ?- sitN(X).
% X = [yellow, white, yellow, pink, white, pink]
% Hint: Try to think as declaratively as possible, and write a test predicate for each constraint type. For example:
% can you write a predicate COUNT/3 which has a symbol (e.g. white) as its first argument, a list as its second
% argument, and an integer (the number of times the symbol appears in the list) as its third argument? Could that be
% useful?
count([], _, 0).
count([H|T], H, C) :- count(T, H, I), C is I + 1.
% count([_|T], H2, J) :- count(T, H2, J), !. % This is the solution with backtracking as demonstrated in class.
count([_|T], H2, J) :- dif(_, H2), count(T, H2, J). % This solution removes the backtracking without using a cut.

shuffle([], X, X).
shuffle([H|Y], X, [H|Z]) :- shuffle(X, Y, Z).

concat([], X, X).
concat([H|X], Y, [H|Z]) :- concat(X, Y, Z).
shift_left([H|T], S) :- concat(T, [H], S).

reverse([], []).
reverse([H|T], R) :- reverse(T, Z), concat(Z, [H], R).

list_delete(X,[X|L1], L1).
list_delete(X, [Y|L2], [Y|L1]) :- list_delete(X,L2,L1).

list_perm([],[]).
list_perm(L,[X|P]) :- list_delete(X,L,L1),list_perm(L1,P).

sit1(Z) :- count(A, green, 49), count(B, black, 1), 
    append(A, B, Z), listlength(Z, 50).
sit2(Z) :- count(A, yellow, 2), count(B, white, 2), count(C, pink, 2), 
    shuffle(A, B, Y), shuffle(Y, C, Z), listlength(Z, 6).
sit3(Z) :- count(A, blue, 4), count(B, white, 1), count(C, green, 1), 
    append(B, C, Y), shuffle(A, Y, Z), listlength(Z, 6).
sit4(Z) :- count(A, blue, 1), count(B, orange, 2), count(C, green, 2), count(D, yellow, 3), 
    shuffle(C, D, O), reverse(O, P), append(P, B, Q), shift_left(Q, R),  shift_left(R, S), shift_left(S, T), 
    append(A, T, U), shift_left(U, V), shift_left(V, W), shift_left(W, X), shift_left(X, Y), shift_left(Y, J), 
    shift_left(J, Z), listlength(Z, 8).

%split3(0, []).