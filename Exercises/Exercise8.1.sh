#!/bin/bash 
read -p "Skriv in din ålder: " age # frågar användaren om ålder
if ! [[ "$age" =~ ^[0-9]+$ ]]; then # om åldern inte är ett nummer
    echo "Ogiltig ålder. Ange ett nummer." # skriv ut att det är ogiltig ålder
    exit 1 
fi #

if (( age >= 16 )); then # om åldern är större eller lika med 16
    echo "Du får dricka alkohol." # skriv ut att användaren får dricka alkohol
    if (( age >= 18 )); then # om åldern är större eller lika med 18
        beer=$(( (age - 18) * 100 )) # räkna ut hur mycket öl användaren har druckit
        echo "Du har druckit $beer liter av öl." # skriv ut hur mycket öl användaren har druckit
    fi
else # om åldern är mindre än 16 
    years_left=$((16 - age)) # räkna ut hur många år användaren måste vänta innan hen får dricka alkohol
    echo "Du måste vänta $years_left mer år innan du får dricka alkohol." # skriv ut hur många år användaren måste vänta innan hen får dricka alkohol
fi
