#!/bin/bash

# Sprawdzenie czy zostaly podane 2 parametry
if [ ! $# -eq 2 ] 
then
echo "Nie podano dwoch parametrow"
exit 1
fi
# Sprawdzenie czy plik logow istnieje i jest plikiem zwyklym
if [ ! -f "$2" ]
then
echo "Plik $2 nie istnieje lub nie jest plikiem zwyklym"
exit 1
fi
# Sprawdzenie czy mamy prawo do odczytu i zapisu w pliku logow
if [ ! -r "$2" -o ! -w "$2" ]
then
echo "Nie masz prawa odczytu lub zapisu do pliku $2"
exit 1
fi
# Sprawdzenie czy 1 parametr jest katalogiem i istnieje
if [ ! -d "$1" ]
then
echo "Parametr 1 nie jest katalogiem lub nie istnieje"
exit 1
fi
# Sprawdzenie czy istnieja dowiazania symboliczne
cd "$1"
for link in $(ls)
do
if [ -L "$link" ]
then
break
fi
done
if [ ! -L "$link" ]
then
echo "Nie isnieja dowiazania symboliczne w podanym katalogu"
exit 1
fi
# Sprawdzenie czy mamy prawo do odczytu, zapisu i wykonywania w podanym katalogu
if [ ! -r "$1" -o ! -w "$1" -o ! -x "$1" ]
then
echo "Nie masz prawa odczytu, zapisu lub wykonania do katalogu $1"
exit 1
fi
# Skasowanie dowiazan symbolicznych w podanym katalogu za zgoda uzytkownika
for link in $(find "$1" -type l)
do
echo "Czy chcesz usunac dowiazanie symboliczne $link?"
echo "Wpisz Y jesli chcesz usunac lub N jesli nie chcesz : "
read decyzja
while [[ "$decyzja" != Y && "$decyzja" != N ]]
do
echo "Podano bledna decyzje"
read decyzja
done
if [[ "$decyzja" = Y ]]
then
rm "$link"
echo "$link" >> "$2"
elif [[ "$decyzja" = N ]]
then
continue
fi
done
