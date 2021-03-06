#!/bin/bash -x
echo "********************Welcome to TicTacToe Simulation Problem********************"
declare -A board

#CONSTANTS
readonly ROW=$1
readonly COLUMN=$2
readonly MAX_POSITION=9

#VARIABLES
randomCheck=$(($RANDOM%2))
count=1

#function is used to Start fresh by resetting the board
function resetBoard(){
	for ((i=1;i<=$ROW;i++))
	do
		for ((j=1;j<=$COLUMN;j++))
		do
			board[$i,$j]="-"
		done
	done
}

#function is used to assign the letters to a player
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

#function is used to check who playes first
function checkTurn(){
	if [ $player == "X" ]
	then
		turn=player
		userInput
	else
		turn=computer
		computerInput
	fi
}

#function is used to display game board
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

#function is used to display condition when game gets tie
function tieCondition() {
	if [[ $count -eq $MAX_POSITION ]]
	then
		echo "Game have tie"
		exit
	fi
}

#function is used to display the board,check win conditions and tie conditions and increase the count by 1
function boardConditions(){
	displayBoard
	winConditions
	tieCondition
}

#function is used to take input from user and to choose valid cells
function userInput(){
read -p "enter row & column number to insert value" rowNumber columnNumber
	if [[ ${board[$rowNumber,$columnNumber]} == "-" ]]
	then
		board[$rowNumber,$columnNumber]=$player
		((count++))
		boardConditions
		computerInput
	else
		echo "OOPS! Position is occupied"
		userInput
   fi
}

#function is used to take input from computer and to choose valid cells
function computerInput(){
computersPossibility $computer
flag=0
	echo "Computer will be played"
if [[ $flag -eq 0 ]]
	then
		computersPossibility $player
	fi
	if [[ $flag -eq 0 ]]
	then
		computersCornerPossibility
	fi
	if [[ $flag -eq 0 ]]
	then
		computersCenterPossibility
	fi
	if [[ $flag -eq 0 ]]
	then
		computersSidesPossibility
	fi
	if [[ $flag -eq 0 ]]
	then
		rowNumber2=$(($RANDOM%3+1))
		columnNumber2=$(($RANDOM%3+1))
			if [[ ${board[$rowNumber2,$columnNumber2]} == "-" ]]
			then
				board[$rowNumber2,$columnNumber2]=$computer
				boardConditions
				userInput
			else
				echo "OOPS! Position is occupied"
				computerInput
			fi
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
			echo "Congrats..!! You won horizontally"
			exit
		elif [[ $horizontalData == "$computer$computer$computer" ]]
		then
			echo "Computer Won Horizontally"
			exit
		fi
		verticalData=${board[$j,$i]}${board[$(($j+1)),$i]}${board[$(($j+2)),$i]}
		if [[ $verticalData == "$player$player$player" ]]
		then
			echo "Congrats..!! You won vertically"
			exit
		elif [[ $verticalData == "$computer$computer$computer" ]]
		then
			echo "Computer Won Vertically"
			exit
		fi
		firstDiagonal=${board[$i,$j]}${board[$(($i+1)),$(($j+1))]}${board[$(($i+2)),$(($j+2))]}
		secondDiagonal=${board[$i,$(($j+2))]}${board[$(($i+1)),$(($j+1))]}${board[$(($i+2)),$j]}
		if [[ $firstDiagonal == "$player$player$player" ]] || [[ $secondDiagonal == "$player$player$player" ]]
		then
			echo "Congrats..!! You Won Diagonally"
			exit
		elif [[ $firstDiagonal == "$computer$computer$computer" ]] || [[ $secondDiagonal == "$computer$computer$computer" ]]
		then
			echo "Computer Won Diagonally"
			exit
		fi
	done
done
}

#function is used to check win and block possibility of computer
function computersPossibility(){
flag=0
input=$1
for (( i=1;i<=$ROW;i++ ))
do
	for (( j=1;j<=$COLUMN;j++ ))
	do
#for horizontal
		if [[ ${board[$i,$j]} == "-" && ${board[$i,$(($j+1))]} == $input && ${board[$i,$(($j+2))]} == $input ]]
		then
			board[$i,$j]=$computer
			flag=1
			break
		elif [[ ${board[$i,$j]} == $input && ${board[$i,$(($j+1))]} == "-" && ${board[$i,$(($j+2))]} == $input ]]
		then
			board[$i,$(($j+1))]=$computer
			flag=1
			break
		elif [[ ${board[$i,$j]} == $input && ${board[$i,$(($j+1))]} == $input && ${board[$i,$(($j+2))]} == "-" ]]
		then
			board[$i,$(($j+2))]=$computer
			flag=1
			break
#for Vertical
		elif [[ ${board[$j,$i]} == "-" && ${board[$(($j+1)),$i]} == $input && ${board[$(($j+2)),$i]} == $input ]]
		then
			board[$j,$i]=$computer
			flag=1
			break
		elif [[ ${board[$j,$i]} == $input && ${board[$(($j+1)),$i]} == "-" && ${board[$(($j+2)),$i]} == $input ]]
		then
			board[$(($j+1)),$i]=$computer
			flag=1
			break
		elif [[ ${board[$j,$i]} == $input && ${board[$(($j+1)),$i]} == $input && ${board[$(($j+2)),$i]} == "-" ]]
		then
			board[$(($j+2)),$i]=$computer
			flag=1
			break
#for 1st diagonal
		elif [[ ${board[$i,$j]} == "-" && ${board[$(($i+1)),$(($j+1))]} == $input && ${board[$(($i+2)),$(($j+2))]} == $input ]]
		then
			board[$i,$j]=$computer
			flag=1
			break
		elif [[ ${board[$i,$j]} == $input && ${board[$(($i+1)),$(($j+1))]} == "-" && ${board[$(($i+2)),$(($j+2))]} == $input ]]
		then
			board[$(($i+1)),$(($j+1))]=$computer
			flag=1
			break
		elif [[ ${board[$i,$j]} == $input && ${board[$(($i+1)),$(($j+1))]} == $input && ${board[$(($i+2)),$(($j+2))]} == "-" ]]
		then
			board[$(($i+2)),$(($j+2))]=$computer
			flag=1
			break
#for 2nd diagonal
		elif [[ ${board[$i,$(($j+2))]} == "-" && ${board[$(($i+1)),$(($j+1))]} == $input && ${board[$(($i+2)),$j]} == $input ]]
		then
			board[$i,$(($j+2))]=$computer
			flag=1
			break
		elif [[ ${board[$i,$(($j+2))]} == $input && ${board[$(($i+1)),$(($j+1))]} == "-" && ${board[$(($i+2)),$j]} == $input ]]
		then
			board[$(($i+1)),$(($j+1))]=$computer
			flag=1
			break
		elif [[ ${board[$i,$(($j+2))]} == $input && ${board[$(($i+1)),$(($j+1))]} == $input && ${board[$(($i+2)),$j]} == "-" ]]
		then
			board[$(($i+2)),$j]=$computer
			flag=1
			break
		fi
		[ $flag == 1 ] && break
	done
done
		if [ $flag -eq 1 ]
		then
			displayBoard
			winConditions
		fi
}

#function is used to check corner possibility of computer
function computersCornerPossibility(){
flag=0
	for ((i=1;i<=$ROW;i=$(($i+2)) ))
	do
		for ((j=1;j<=$COLUMN;j=$(($j+2)) ))
		do
			if [[ ${board[$i,$j]} == "-" ]]
			then
				board[$i,$j]=$computer
				flag=1
         fi
			if [[ $flag -eq 1 ]]
			then
				displayBoard
			fi
		done
   done
}

#function is used to check center possibility of computer
function computersCenterPossibility(){
   if [[ ${gameBoard[2,2]} == "-" ]]
   then
      gameBoard[2,2]=$computer
      flag=1
   fi
   if [[ $flag -eq 1 ]]
   then
      displayBoard
   fi
}

#function is used to check side possibility of computer
function computersSidesPossibility(){
	for ((i=1;i<=$ROW;i=$(($i+2)) ))
	do
		j=2
		if [[ ${board[$i,$j]} == "-" ]]
		then
			board[$i,$j]=$computer
			flag=1
		elif [[ ${board[$j,$i]} == "-" ]]
		then
			board[$j,$i]=$computer
			flag=1
		fi
		if [[ $flag -eq 1 ]]
		then
			displayBoard
		fi
	done
}

assignSymbols
resetBoard
checkTurn

while [[ $count -le $MAX_POSITION ]]
do
	userInput
done
