#!/bin/bash

backup_plats="/root/backups/" # backup-platsen
home_plats="$HOME" # home-platsen
backup_fil="$backup_plats/backup_home.tar" # backup-filen
snapshot_fil="$backup_plats/snapshot.file" # snapshot-filen

if [[ ! -d $backup_plats ]]; then # ifall backup-platsen inte finns -d = directory
    echo "Backup-katalogen $backup_plats finns ej. Skapar den nu..." # skriver ut att backup-katalogen inte finns och att den skapas nu
    mkdir -p "$backup_plats" # -p = skapar alla underkataloger som saknas 
fi

behovd_plats=$(du -s "$home_plats" | awk '{print $1}') # du -s = summerar diskutrymmet som används av filer i en katalog och dess underkataloger
tillganglig_plats=$(df "$backup_plats" | tail -1 | awk '{print $4}') # df = rapporterar filsystemdiskutrymmet
if (( behovd_plats > tillganglig_plats )); then  # om behovd_plats är större än tillganglig_plats
    echo "Det finns inte tillräckligt med utrymme i $backup_plats." # skriv ut att det inte finns tillräckligt med utrymme
    exit 1
fi

read -p "Fullständig eller inkrementell backup? (full/inkrementell): " typ # frågar användaren om full eller inkrementell backup

if [[ $typ == "full" ]]; then # om användaren väljer full
    echo "Utför fullständig backup..."   # skriv ut att en fullständig backup utförs
    tar --listed-incremental="$snapshot_fil" -cvpf "$backup_fil" "$home_plats" # tar = skapar, visar eller extraherar filer från en arkivfil
elif [[ $typ == "inkrementell" ]]; then # om användaren väljer inkrementell
    echo "Utför inkrementell backup..." # skriv ut att en inkrementell backup utförs
    if [[ ! -f $snapshot_fil ]]; then # om snapshot-filen inte finns
        echo "Ingen tidigare snapshot hittades. Kör en fullständig backup istället." # skriv ut att ingen tidigare snapshot hittades och den istället gör en fullständig backup 
        tar --listed-incremental="$snapshot_fil" -cvpf "$backup_fil" "$home_plats"   # skapar en fullständig backup 
    else
        tar --listed-incremental="$snapshot_fil" -cvpf "$backup_fil" "$home_plats"  # skapar en inkrementell backup
    fi
else
    echo "Ogiltigt val. Avbryter."  # skriver ogiltigt val och avbryter vid annat svar än "Full eller inkrementell"
    exit 1
fi

gzip -f "$backup_fil" # komprimerar backup-filen
echo "Backup klar. Komprimerad fil: $backup_fil.gz" # skriver ut att backupen är klar och var den är komprimerad
echo "Storlek: $(du -h "$backup_fil.gz" | awk '{print $1}')" # skriver ut storleken på den komprimerade filen