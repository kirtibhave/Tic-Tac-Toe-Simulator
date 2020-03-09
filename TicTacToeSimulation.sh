#!/bin/bash 

echo ********************Welcome to TicTacToe Simulation Problem********************

#CONSTANTS
readonly ROW=3
readonly COLUMN=3
MAX_POSITION=9
PLAYER=1

#VARIABLES
randomCheck=$(($RANDOM%2))
count=1

declare -A gameBoard

# to Start fresh by resetting the board
function resetBoard(){
   for ((i=1;i<=$ROW;i++))
   do
      for ((j=1;j<=$COLUMN;j++))
      do
         gameBoard[$i,$j]="-"
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
   echo $sign
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
   for (( i=1;i<=$ROW;i++ ))
   do
      for (( j=1;j<=$COLUMN;j++ ))
      do
         echo -e "${gameBoard[$i,$j]} | \c"
      done
         echo
   done
}

#to take input from user and to choose valid cells
function userInput(){
   read -p "enter row & column number to insert value" rowNumber columnNumber
      if [[ ${gameBoard[$rowNumber,$columnNumber]} == "-" ]]
      then
         gameBoard[$rowNumber,$columnNumber]=$sign
         displayBoard
         ((count++))
      else
         echo "OOPS! Position is occupied" 
      fi
}

resetBoard
assignSymbols
checkTurn

while [[ $count -le $MAX_POSITION ]]
do
	userInput
done
