#!/bin/bash
# Kontrollera om en fil skickats som argument
file=$1 # filen som användaren skickar som argument

if [[ -z $file || ! -f $file ]]; then # om filen inte finns eller om filen inte är en fil
    echo "Användning: $0 <filnamn>"   #     skriv ut att användaren ska skicka en fil som argument
    exit 1
fi

# Visa en meny för komprimeringsalternativ
cat << EOF
Välj en komprimeringsmetod: 
1. gzip
2. bzip2
3. compress
4. zip
EOF

read -p "Ange ditt val (1-4): " choice # frågar användaren om val

case $choice in
    1) gzip "$file" ;; #  om användaren väljer 1 så komprimera filen med gzip 
    2) bzip2 "$file" ;; #  om användaren väljer 2 så komprimera filen med bzip2
    3) compress "$file" ;;  #  om användaren väljer 3 så komprimera filen med compress
    4) zip "${file}.zip" "$file" ;; # om användaren väljer 4 så komprimera filen med zip
    *) echo "Ogiltigt val"; exit 1 ;; # om användaren väljer något annat än 1, 2, 3 eller 4 så skriv ut att det är ett ogiltigt val 
esac 
Exercise 3