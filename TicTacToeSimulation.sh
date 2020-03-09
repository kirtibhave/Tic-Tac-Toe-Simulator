#!/bin/bash -x
echo "********************Welcome to TicTacToe Simulation Problem********************"

#CONSTATNTS
ROW=$1
COLUMN=$2

declare -a board

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
randomChecksign=$(($RANDOM%2))
	if [ $randomChecksign == 1 ]
	then
		SIGN=X
	else
		SIGN=O
	fi
}

resetBoard
assignSymbols
