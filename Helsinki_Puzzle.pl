%Build the Grid
grid_build(N,M):-
	length(M,N),
	helperBuild(M,N).

helperBuild([],_).
helperBuild([H|T],N):-
	length(H,N),
	helperBuild(T,N).
	
%generate valid valUes
grid_gen2(N,X):-
	num_gen(1,N,Numbers),
	helperGen(N,X,Numbers).

grid_gen(N,X):-
	grid_build(N,X),
	num_gen(1,N,Numbers),
	helperGen(N,X,Numbers).

helperGen(_,[],_).
helperGen(N,[H|T],Numbers):-
	row_gen(Numbers,Numbers,H),
	helperGen(N,T,Numbers).

row_gen(_,_,[]).
row_gen(Numbers,[X],[X|T]):-
	row_gen(Numbers,Numbers,T).
row_gen(Numbers,[H|T],[H1|T1]):-
	T\=[],(
	H1=H,row_gen(Numbers,Numbers,T1);
	row_gen(Numbers,T,[H1|T1])
	).


%generate numbers from F to L
num_gen(F,L,_):-F>L.
num_gen(F,F,[F]).
num_gen(F,L,[H|T]):-
	F<L,
	H=F,
	M is F+1,
	num_gen(M,L,T).	

	
check_num_grid([1]).
check_num_grid(G):-
	maxInGrid(G,X),
	check(G,1,X).
	


maxInRow([X],X).
maxInRow([H|T],M):-
	maxInRow(T,H,M).	
maxInRow([],M,M).	
maxInRow([H|T],P,M):-
	P>=H,
	maxInRow(T,P,M).
maxInRow([H|T],P,M):-
	P<H,
	maxInRow(T,H,M).
	
maxInGrid([X],X).	
maxInGrid([H|T],M):-
	maxInGrid(T,H,0,M).
maxInGrid([],R,P,M):-
	maxInRow(R,X),
	((X>P,M=X);(X=<P,M=P)).
maxInGrid([H|T],R,P,M):-
	maxInRow(R,X),
	P>=X,
	maxInGrid(T,H,P,M).
maxInGrid([H|T],R,P,M):-
	maxInRow(R,X),
	P<X,
	maxInGrid(T,H,X,M).

check(_,S,E):- %check all numbers from S to E are in  the grid
	S>E.
check(G,S,E):-
	S=<E,
	memberInGrid(G,S),
	S1 is S+1,
	check(G,S1,E).
	

memberInGrid([H|_],X):-
	contains(X,H).
memberInGrid([H|T],X):-
	\+	contains(X,H),
	memberInGrid(T,X).
contains(X,[Y|_]):-
	X==Y.

contains(X,[H|T]):-
		X\==H,contains(X,T).

acceptable_distribution([H|T]):-
	length([H|T],S),
	acd([H|T],[H|T],0,S).
acd(_,_,X,X).
acd(L1,L2,S1,S2):- % does the check
	S1\=S2,
	((S1=0,S4=0);(S1\=0,length(L2,S4))),
	delete_Coloumn(L1,0,S4,R),
	get_The_Coloumn(R,R2),
	get_The_Row(L2,0,S1,R3),
	R2\==R3,
	S3 is S1+1,
	acd(R,L2,S3,S2).

get_The_Coloumn([],[]). % gets the column
get_The_Coloumn([[H|_]|T2],[H|T3]):-
	get_The_Coloumn(T2,T3).

get_The_Row([H|_],X,X,H).
get_The_Row([_|T],S,E,R):- %gets the row
	S\=E,S1 is S+1,get_The_Row(T,S1,E,R).
delete_Coloumn(L,S,S,L). % gets the appropriate grid to work on
delete_Coloumn([[_|T1]|T2],S,E,R):-
	S<E,
	S1 is S+1,
	delete_Coloumn(T2,S1,E,U),
	R = [T1|U].
distinct_rows(M):-
	distinct_row_helper(M,[]).
distinct_row_helper([],_).
distinct_row_helper([H|T],G):-
	\+contains(H,G),X=[H|G],distinct_row_helper(T,X).

distinct_coloumn_baiza(M):-
	length(M,L),
	distinct_coloumn_helper(M,0,L,[]).
distinct_coloumn_helper(_,S,S,_).
distinct_coloumn_helper(M,S,E,G):-
	((S=0,S2=0);(S\=0,length(M,S2))),
	delete_Coloumn(M,0,S2,Grid),
	get_The_Coloumn(Grid,C),
	\+member(C,G),X=[C|G],S1 is S+1,distinct_coloumn_helper(Grid,S1,E,X).
distinct_columns(M):-
	trans(M,X),
	distinct_rows(X).
trans(X1,X):-
length(X1,L),
tran(X1,X,0,L).
tran(_,[],X,X).
tran(L1,L2,S1,S2):- % does the check
	S1\=S2,
	((S1=0,S4=0);(S1\=0,length(L1,S4))),
	delete_Coloumn(L1,0,S4,R),
	get_The_Coloumn(R,R2),
	S3 is S1+1,
	tran(R,X,S3,S2),
	L2 = [R2|X].
	
acceptable_permutation(L,R):-
			acceptable_permutationHelper(L,R,[],L).
	
acceptable_permutationHelper([],[],_,_).
acceptable_permutationHelper([H|T],[H1|T1],L,G):-
			member(H1,G),H\==H1,\+member(H1,L),append(L,[H1],NewL),acceptable_permutationHelper(T,T1,NewL,G).
				
	
row_col_match(G):-
	trans(G,X),
	helperteam(G,X,X,1,1,[]).
	

helperteam([],_,_,_,_,_).

helperteam([H|T],[H2|T2],G,Ri,Ci,CL):-
		(
		Ri\=Ci,
		\+contains(Ci,CL),
		H=H2,
		append(CL,[Ci],NewList),
		Rnew is Ri+1,
		helperteam(T,G,G,Rnew,1,NewList)
		);
		(
		Cnew is Ci+1,
		helperteam([H|T],T2,G,Ri,Cnew,CL)
		).

	
helsinki(N,G):-
	grid_build(N,G),
	row_col_match(G),
	distinct_columns(G),
	distinct_rows(G),
	grid_gen2(N,G),
	check_num_grid(G),
	acceptable_distribution(G).
	
