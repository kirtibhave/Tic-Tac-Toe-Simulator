#!/bin/bash
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

resetBoard
