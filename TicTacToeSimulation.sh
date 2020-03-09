#!/bin/bash -x
echo "********************Welcome to TicTacToe Simulation Problem********************"

declare -a board

#CONSTATNTS
ROW=$1
COLUMN=$2
PLAYER=1

randomCheck=$(($RANDOM%2))

#function is used to start fresh by resetting the board
function resetBoard(){
for (( i=1;i<=$ROW;i++ ))
do
	for (( j=1;j<=$COLUMN;j++ ))
	do
		board[$i,$j]="_"
	done
	 echo ${board[@]}
done
}

#function is used to assign the letters to a player
function assignSymbols(){
randomCheck=$(($RANDOM%2))
	if [ $randomCheck -eq $PLAYER ]
	then
		SIGN=X
	else
		SIGN=O
	fi
}

#function is used to check who playes first
function checkTurn(){
	if [ $randomCheck -eq $PLAYER ]
	then
		echo "player 1 will be played first"
	else
		echo "player 2 will be played first"
	fi
}

resetBoard
assignSymbols
checkTurn
