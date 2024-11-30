#!/bin/bash

read -p "Ange användarnamn: " anvandarnamn # read -p = skriver ut en prompt och läser in användarens input, ber om användarnamn

if [[ -z $anvandarnamn ]]; then # om användarnamn är tomt
    echo "Fel: Du måste ange ett användarnamn." # skriv ut att användaren måste ange ett användarnamn
    exit 1
fi

if id "$anvandarnamn" &>/dev/null; then # om användaren redan finns
    echo "Fel: Användaren $anvandarnamn finns redan." # skriv ut att användaren redan finns
    exit 1
fi

read -p "Ange önskat shell (standard: /bin/bash): " shell # frågar användaren om önskat shell
shell=${shell:-/bin/bash}

read -p "Ange kontots utgångsdatum (format: YYYY-MM-DD, valfritt): " utgangsdatum # frågar användaren om kontots utgångsdatum


read -p "Ange ytterligare grupper (kommaseparerade, valfritt): " grupper # frågar användaren om ytterligare grupper, t.ex sudo

# Skapa användaren med en privat grupp  # -m = skapar en hemkatalog för användaren -s = sätter vilket shell användaren ska använda
sudo useradd -m -s "$shell" "$anvandarnamn"

if [[ -n $utgangsdatum ]]; then # om utgångsdatumet inte är tomt
    sudo chage -E "$(date -d "$utgangsdatum" +%Y-%m-%d)" "$anvandarnamn"  # chage = ändrar användarens lösenords- och kontoinformation -E = sätter utgångsdatumet för kontot
    echo "Utgångsdatum satt till $utgangsdatum för $anvandarnamn."  # skriver ut att utgångsdatumet är satt
fi

if [[ -n $grupper ]]; then # om grupper inte är tom
    sudo usermod -aG "$grupper" "$anvandarnamn" # usermod = ändrar användarens egenskaper -a = lägger till användaren till grupperna
    echo "Användaren $anvandarnamn har lagts till i grupperna: $grupper." # skriver ut att användaren har lagts till i grupperna
fi

# Bekräfta att användaren skapades
echo "Användaren $anvandarnamn skapades framgångsrikt."