#!/bin/bash

#turn txt to array again
declare -A phonebook
while read line; do
  IFS='	'
  read -a temparr <<< "$line"
  phonebook[${temparr[0]}]=${temparr[1]}
done < phonebook.txt


if [ "$#" -lt 1 ]; then
    exit 1

elif [ "$1" = "new" ]; then
    declare -A phonebook
    phonebook[$4]=$2' '$3
    echo "new entry:" ${phonebook[$4]}, $4 

elif [ "$1" = "list" ]; then
    
    if [ ${#phonebook[@]} -eq 0 ]; then
        echo "Your phonebook is empty."
    else
        for K in "${!phonebook[@]}"; do echo $K ${phonebook[$K]}; done
    fi

elif [ "$1" = "lookup" ]; then
    found=true
    for K in "${!phonebook[@]}"
    do 
      if [ ${phonebook[$K]} = $2' '$3 ];
      then
        echo $K 
        found=false
      fi
    done
    if [[ "$found" == "true" ]]; then
      echo "Nobody with that name was found. Please try again (this took way too long to do)"
    fi

elif [ "$1" = "remove" ]; then
    foundr=true
    for K in "${!phonebook[@]}"
    do 
      if [ ${phonebook[$K]} = $2' '$3 ];
      then
        unset phonebook[$K]
        foundr=false
      fi
    done
    if [[ "$foundr" == "true" ]]; then
      echo "Nobody with that name was found. Please try again (this took way too long to do)"
    else
      echo $2' '$3 has been removed from the phonebook.
    fi

elif [ "$1" = "clear" ]; then
    if [ ${#phonebook[@]} -eq 0 ]; then
      echo "Your phonebook is already empty!"
    else
      unset phonebook
      declare -A phonebook
      echo "Phonebook cleared!"
    fi
else
     echo "That is not a valid argument. Please try again."
fi

#put array into txt
for K in "${!phonebook[@]}"; do echo "$K	${phonebook[$K]}"; done > phonebook.txt