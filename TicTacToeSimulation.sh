#!/bin/bash -x
echo ********************Welcome to TicTacToe Simulation Problem********************

#CONSTANTS
readonly ROWS=3
readonly COLUMNS=3
readonly MAX_POSITION=9
readonly PLAYER=1

#VARIABLES
randomCheck=$(($RANDOM%2))
count=1

declare -A board

# to Start fresh by resetting the board
function resetBoard(){
	for ((i=1;i<=$ROWS;i++))
	do
		for ((j=1;j<=$COLUMNS;j++))
		do
			board[$i,$j]="-"
		done
	done
}

# to assign the letters to a player
function assignSymbols() {
	if [ $randomCheck -eq $PLAYER ]
	then
		sign="X"
	else
		sign="X"
	fi
}

#to check who playes first
function checkTurn(){
	if [ $randomCheck -eq $PLAYER ]
	then
		turn=player
	else
		turn=player
	fi
		echo $turn will be played first
}

#to display game board
function displayBoard(){
	for (( i=1;i<=$ROWS;i++ ))
	do
		for (( j=1;j<=$COLUMNS;j++ ))
		do
			echo -e "${board[$i,$j]} | \c"
		done
			echo
	done
}

#to take input from user and to choose valid cells
function userInput(){
	read -p "enter row & column number to insert value" rowNumber columnNumber
		if [[ ${board[$rowNumber,$columnNumber]} == "-" ]]
		then
			board[$rowNumber,$columnNumber]=$sign
			displayBoard
			((count++))
		else
			echo "OOPS! Position is occupied" 
		fi
}

#to know game status after every moves
function winConditions(){
for ((i=1;i<=$ROWS;i++))
do
	for ((j=1;j<=$COLUMNS;j++))
	do
		horizontalData=${board[$i,$j]}${board[$i,$(($j+1))]}${board[$i,$(($j+2))]}
	if [[ $horizontalData == "XXX" ]]
	then
		echo "Congrats! You Won horizontally"
		exit
	fi

		verticalData=${board[$j,$i]}${board[$(($j+1)),$i]}${board[$(($j+2)),$i]}
	if [[ $verticalData == "XXX" ]]
	then
		echo "Congrats! You Won vertically"
		exit
	fi

		firstDiagonal=${board[$i,$j]}${board[$(($i+1)),$(($j+1))]}${board[$(($i+2)),$(($j+2))]}
		secondDiagonal=${board[$i,$(($j+2))]}${board[$(($i+1)),$(($j+1))]}${board[$(($i+2)),$j]}
	if [[ $firstDiagonal == "XXX" ]] || [[ $secondDiagonal == "XXX" ]]
	then
		echo "Congrats! You Won diagonally"
		exit
	fi
	done
done
}

resetBoard
assignSymbols
checkTurn

while [[ $count -le $MAX_POSITION ]]
do
	userInput
	winConditions
done

