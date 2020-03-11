#!/bin/bash
echo "********************Welcome to TicTacToe Simulation Problem********************"

#CONSTANTS
readonly ROW=3
readonly COLUMN=3
readonly MAX_POSITION=9

#VARIABLES
randomCheck=$(($RANDOM%2))
count=1

declare -A board

# to Start fresh by resetting the board
function resetBoard(){
	for ((i=1;i<=$ROW;i++))
	do
		for ((j=1;j<=$COLUMN;j++))
		do
			board[$i,$j]="-"
		done
	done
}

# to assign the letters to a player
function assignSymbols() {
	if [[ $randomCheck -eq 1 ]]
	then
		player="X"
		computer="O"
	else
		computer="X"
		player="O"
	fi
		echo player sign is $player
		echo computer sign is $computer
}

#to check who playes first
function checkTurn(){
	if [ $player == "X" ]
	then
		turn=player
		userInput
	else
		turn=computer
		computerInput
	fi
	echo $turn will be played first
}

#to display game board
function displayBoard(){
	for (( i=1;i<=$ROW;i++ ))
	do
		for (( j=1;j<=$COLUMN;j++ ))
		do
			echo -e "${board[$i,$j]} | \c"
		done
			echo
	done
}

#to display condition when game gets tie
function tieCondition() {
	if [[ $count -eq $MAX_POSITION ]]
	then
		echo "Game have tie"
		exit
	fi
}

#to display the board,check win conditions and tie conditions and increase the count by 1
function boardConditions(){
	displayBoard
	winConditions
	tieCondition
	((count++))
}

#to take input from user and to choose valid cells
function userInput(){
read -p "enter row & column number to insert value" rowNumber columnNumber
	if [[ ${board[$rowNumber,$columnNumber]} == "-" ]]
	then
		board[$rowNumber,$columnNumber]=$player
		boardConditions
		computerInput
	else
		echo "OOPS! Position is occupied"
		userInput
   fi
}

#to take input from computer and to choose valid cells
function computerInput(){
	rowNumber2=$(($RANDOM%3+1))
	columnNumber2=$(($RANDOM%3+1))
		echo "Computer will be played"
	if [[ ${board[$rowNumber2,$columnNumber2]} == "-" ]]
	then
		board[$rowNumber2,$columnNumber2]=$computer
		boardConditions
		userInput
	else
		echo "OOPS! Position is occupied"
		computerInput
   fi
}

#function is used to check win conditions of game
function winConditions(){
for ((i=1;i<=$ROW;i++))
do
	for ((j=1;j<=$COLUMN;j++))
	do
		horizontalData=${board[$i,$j]}${board[$i,$(($j+1))]}${board[$i,$(($j+2))]}
		if [ $horizontalData == "$player$player$player" ]
		then
			echo "Congrats You won horizontally"
			exit
		elif [[ $horizontalData == "$computer$computer$computer" ]]
		then
			echo "Congrats! Computer Won Horizontally"
			exit
		fi

		verticalData=${board[$j,$i]}${board[$(($j+1)),$i]}${board[$(($j+2)),$i]}
		if [[ $verticalData == "$player$player$player" ]]
		then
			echo "Congrats You won vertically"
			exit
		elif [[ $verticalData == "$computer$computer$computer" ]]
		then
			echo "Congrats! Computer Won Horizontally"
			exit
		fi

		firstDiagonal=${board[$i,$j]}${board[$(($i+1)),$(($j+1))]}${board[$(($i+2)),$(($j+2))]} 
		secondDiagonal=${board[$i,$(($j+2))]}${board[$(($i+1)),$(($j+1))]}${board[$(($i+2)),$j]}
		if [[ $firstDiagonal == "$player$player$player" ]] || [[ $secondDiagonal == "$player$player$player" ]]
		then
			echo "You Won Diagonally!!"
			exit
		elif [[ $firstDiagonal == "$computer$computer$computer" ]] || [[ $secondDiagonal == "$computer$computer$computer" ]]
		then
			echo "Computer Won Diagonally!!"
			exit
		fi
	done
done
}

resetBoard
assignSymbols
checkTurn

# to check whether count is less than or equal to max position
while [[ $count -le $MAX_POSITION ]]
do
   userInput
done



