-module(toh).
-export([hanoi/1]).

%create an empty list if reached 1
create_tower(0) -> [];

%create the tower with the values depending on what they type in
create_tower(Discs) when Discs > 0 ->

	%append the new values to the list
	lists:append([Discs], create_tower(Discs - 1)).

%print out the values of the towers to the screen
display_towers(A, B, C) ->
	io:format("~n~s~w~n~s~w~n~s~w~n------------------------------~n", ["Tower A: ", A, "Tower B: ", B, "Tower C: ", C]).

%recursive move functions to place the new discs on the new towers
move_tower(1, TowerA, TowerB, TowerC) ->

	%display the tower as it is, move the final piece to the destination
	display_towers(TowerA, TowerB, TowerC);

move_tower(Discs, TowerA, TowerB, TowerC) when Discs > 1 ->

		%call the next moveerl
    move_tower(Discs - 1, TowerA, TowerB, TowerC),
		
		%get the last element of Tower A (The top disc)
		NewTowerB = [lists:last(TowerA)],

		%move the disc from tower B to tower C
		NewTowerC = lists:append(TowerC, NewTowerB),

		%remove the top disc from the first tower
		NewTowerA = lists:sublist(TowerA, length(TowerA) - 1),

		%display the towers with the new values
    display_towers(NewTowerA, TowerB, NewTowerC),

		%move the tower using the new values
    move_tower(Discs - 1, NewTowerA, NewTowerC, TowerB).

%check if the user enters invalid numbers
hanoi(0) ->
	io:format("number of disks cannot be 0~n");

hanoi(Discs) when Discs < 0 ->
	io:format("number of disks must be > 0~n");

%discs entered must be less than 50
hanoi(Discs) when Discs > 50 ->
	io:format("number of disks must be less than 300 in size ~n");

hanoi(Discs) ->
	%initialise the towers with their values
	TowerA = create_tower(Discs),

	%create empty lists for towerB and C
  TowerB = [],
  TowerC = [],

	%call the recursive move function to start the process
	move_tower(Discs, TowerA, TowerB, TowerC).
