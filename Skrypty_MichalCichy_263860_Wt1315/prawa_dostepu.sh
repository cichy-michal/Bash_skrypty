#!/bin/bash

# Sprawdzenie czy zostaly podane conajmniej 2 parametry
if [ $# -lt 2 ] 
then
echo "Nie podano dwoch parametrow"
exit 1
fi

# Sprawdzenie czy 1 parametr sklada sie z 3 cyfr
if [[ ! $1 =~ ^[0-7][0-7][0-7]$ ]]
then
echo "Pierwszy parametr jest bledny"
exit 1
fi
# Iteracja po liczbie argumentow zaczynajac od 2
for ((i=2; i <= $#; i++))
do
# Przypisanie zmiennej plik wartosci argumentu o indeksie i
plik="${!i}"
# Sprawdzenie czy mamy prawa dostepu do pliku lub katalogu i czy dany plik lub katalog istnieje
if [ ! -w "$plik" ]
then
echo "Nie masz prawa modyfikacji do tego pliku lub katalogu lub ten plik lub katalog nie istnieje"
continue
fi
# Nadanie praw dostepu
chmod "$1" "$plik"
done
