#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ ! $1 ]]
  then
  echo "Please provide an element as an argument."
  
  else
    if [[ $1 =~ ^[0-9]+$ ]]
      then
      FOUND_FROM_ATOMIC=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
    fi
  FOUND_FROM_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1'")
  FOUND_FROM_NAME=$($PSQL "SELECT name FROM elements WHERE name='$1'")
  
  if [[ $FOUND_FROM_ATOMIC ]]
    then
    ELEMENT=$($PSQL "SELECT * FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1")
    echo $ELEMENT | while read TYPEID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR WEIGHT BAR MELT BAR BOIL BAR TYPE;
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done

  elif [[ $FOUND_FROM_SYMBOL ]]
    then 
    ELEMENT=$($PSQL "SELECT * FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol='$1'")
    echo $ELEMENT | while read TYPEID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR WEIGHT BAR MELT BAR BOIL BAR TYPE;
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done
  
  elif [[ $FOUND_FROM_NAME ]]
    then
    ELEMENT=$($PSQL "SELECT * FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE name='$1'")
    echo $ELEMENT | while read TYPEID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR WEIGHT BAR MELT BAR BOIL BAR TYPE;
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done
  
  else
    echo "I could not find that element in the database."
  fi
fi