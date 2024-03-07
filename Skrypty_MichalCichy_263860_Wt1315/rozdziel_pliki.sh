#!/bin/bash

# Sprawdzenie czy zostaly podane 3 parametry
if [ ! $# -eq 3 ] 
then
echo "Nie podano trzech parametrow"
exit 1
fi
# Iteracja po wszystkich argumentach
for plik in "$@"
do
# Sprawdzenie czy podane pliki istnieja i sa plikami zwyklymi
if [ ! -f "$plik" ]
then
echo "Plik $plik nie istnieje lub nie jest plikiem zwyklym"
exit 1
fi
done
# Sprawdzenie czy mamy prawo do odczytu pliku zrodlowego
if [ ! -r "$1" ]
then
echo "Nie masz prawa odczytu do pliku $1"
exit 1
fi
# Iteracja po liczbie argumentow zaczynajac od 2
for ((i=2; i <= $#; i++))
do
# Przypisanie zmiennej plik wartosci argumentu o indeksie i
plik="${!i}"
# Sprawdzenie czy mamy prawo do zapisu do plikow wynikowych
if [ ! -w "$plik" ]
then
echo "Nie masz prawa zapisu do pliku $plik"
continue
fi
done
# Iteracja po liniach pliku zrodlowego
numer=0
cat "$1" | while read linia
do
#Przypisanie do zmiennej numeru aktualnie iterowanej linii
#numer=$(echo "$linia" | awk '{print NR}')
numer=$((numer+1))
# Sprawdzenie parzystosci linii
if [ $((numer % 2)) -eq 0 ]
then
# Nadpisywanie linii parzystych pliku zrodlowego do 1 pliku wyjsciowego
echo "$numer: $linia" >> "$2"
else
# Nadpisywanie linii nieparzystych pliku zrodlowego do 2 pliku wyjsciowego
echo "$numer: $linia" >> "$3"
fi
done
