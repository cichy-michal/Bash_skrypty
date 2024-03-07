#!/bin/bash
# Sprawdzenie czy zostal podany conajmniej 1 parametr
if [ $# -lt 1 ] 
then
echo "Nie podano nazw uzytkownikow"
exit 1
fi
# Iteracja po wszystkich argumentach
for nazwa in "$@"
do
# Sprawdzenie czy taki uzytkownik istnieje
if id "$nazwa" > /dev/null 2>&1
then
echo "Taki uzytkownik juz istnieje"
else
# Dodanie uzytkownika
sudo useradd -m "$nazwa"
# Stworzenie katalogu
sudo mkdir -p /home/"$nazwa"
# Ustawienie tymczasowego hasla
echo "$nazwa:$nazwa" | sudo chpasswd
#Wymuszenie zmiany hasla
sudo passwd -e "$nazwa"

echo "Konto zostalo utworzone"
fi
done
