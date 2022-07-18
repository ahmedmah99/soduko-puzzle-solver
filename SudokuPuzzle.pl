%Grid Build predicate start:
grid_build(N,Xs):-	%elpridicate deh betbny matrix fady. 
	length(Xs,N),
	helper1(N,Xs).	% elhelper method beta5od list feha N 2maken fadya we bet7ot fi kol mkan list tanya bi size N 3shan yeb2a matrix N*N
helper1(_,[]).
helper1(C,[X|XSS]):-
	length(X,C),
	helper1(C,XSS).
%Grid build predicate end.

%Grid Generation Start:
grid_gen(N,M):-
	grid_build(N,M),
	helper2(N,M).

helper2(_,[]).
helper2(N,[H|T]):-
	num_gen(1,N,LIST),
	permutation(List,Perm),


	helper3(N,N,H),
	different1(H),
	helper2(N,T).


helper3(0,_,[]).
helper3(X,N,[H|T]):-
	X > 0,
	X1 is X - 1,
	num_gen(1,N,LIST),
	member(H,LIST),
	helper3(X1,N,T).



num_gen(X,X,[X]).		%The predicate num_gen(F,L,R) should succeed 
num_gen(X,Y,[X|T1]):-	% ONLY if : [X|T1] represent a list of conse-
	X =< Y,				%-secutive numbers starting from X to Y.
	X1 is X + 1,
	num_gen(X1, Y, T1).
%Grid Generation End.

squares([],[]).
squares(SudokuGrid, X):-
	helper(SudokuGrid,3,SudokuGrid1),
	squares(SudokuGrid1,RSquares),
	first_squares(SudokuGrid,Square),
	append(Square,RSquares,X).

first_squares([[]|_],[]).
first_squares(X,[H|T]):-
	first_squares_helper(X,H,B,3),
	first_squares(B,T).

first_squares_helper([],[],[],0).
first_squares_helper([[X|Y]|_],[],[],0).
first_squares_helper([[X,Y,Z|T]|T1], [X,Y,Z|Hs], [T|Ts], N):-
	N > 0,
	N1 is N - 1,
	first_squares_helper(T1,Hs,Ts,N1).

helper(X,0,X).
helper([[H|T]|T1], N,X):-
	N > 0,
	N1 is N - 1,
	helper(T1,N1,X).


different1([]).
different1([X|T]):-
	\+member(X,T),
	different1(T).

check_squares(X):-
	squares(X,X1),
	check_squares_helper(X1).

check_squares_helper([]).
check_squares_helper([H|T]):-
	different1(H),
	check_squares_helper(T).

trans([[]|_], []).
trans(Grid,[R1|R2]):-
	transcol(Grid,R1,Rest),
	trans(Rest,R2).
transcol([], [], []).
transcol([[H|T]|Rows], [H|Hs], [T|Ts]) :- 
	transcol(Rows, Hs, Ts).


check_columns(X):-
	trans(X,X1),
	check_columns_helper(X1).

check_columns_helper([]).
check_columns_helper([H|T]):-
	different1(H),
	check_columns_helper(T).

solvepuzzle(X):-
	grid_gen(9,X),
	check_squares(X),
	check_columns(X).