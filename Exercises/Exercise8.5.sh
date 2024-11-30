#!/bin/bash

read -p "Ange filnamnet du vill arbeta med: " filnamn # read -p = skriver ut en prompt och läser in användarens input, ber om filnamn istället för ett argument som i originalscriptet. 

if [[ -e $filnamn ]]; then # om filnamnet finns
    echo "Filen $filnamn hittades." # skriv ut att filen hittades
else
    echo "Fel: Filen $filnamn finns inte." #  skriv ut att filen inte finns
    exit 1
fi

echo "Innehållet i filen $filnamn:" # skriv ut innehållet i filen
cat "$filnamn" # cat = visar innehållet i filen
