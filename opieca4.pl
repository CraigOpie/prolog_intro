/*  Author:     Craig Opie
    Assignment: 4
    References: d
*/

% Create a recursive Prolog predicate listlength/2 that has a list as its first argument, and the length of that list 
% as its second argument.
listlength([], 0).
listlength([_|T],L) :- listlength(T,I), L is I + 1.

% Write predicates that will find solutions for each of the following colored-balls-in-a-row problems with different 
% sets of constraints.
