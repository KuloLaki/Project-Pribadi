#!/bin/bash
Program=/opt/aino/InfoSystem.sh
mac_address=$(ifconfig $interface | awk '/ether/{print $2}')
mac_address_no_colon=$(echo $mac_address | tr -d ':')
penting=/opt/aino/backuplog/Hasilrun.log

if [ $# -ne 1 ]; then
    echo "Usage: $0 Masukkan waktu tunda!!!"
    exit 1
fi

# Simpan argumen dalam variabel
waktu_penundaan=$1

# Perulangan tak terbatas
while true; do
filesize=$(wc -c $penting | awk '{print  $1}')
datetime=$(date +"%Y%m%d%H%M%S")
kb=$(bc <<<"scale=3; $filesize / 1024")
namafile='/opt/aino/backuplog/Hasilrun.log'

    bash $Program
    #Catatan data: 
    #Kb: 1024
    #Mb: 1048576
    #Gb: 1073741824
    if [ $filesize -gt 1500 ]  ; then  #&& [ $filesize -lt 2000 ]
        echo ""
        echo "$kb Kb"
        echo "File akan di zip" 
        zip   /opt/aino/backuplog/$datetime"_$mac_address_no_colon"_LOG backuplog/Hasilrun.log
        echo "Zip berhasil"
        rm $namafile
        sleep 1
        touch $namafile
        echo "File log baru berhasil dibuat"
    else
        echo "$kb Kb"
        echo "File belum mencukupi untuk zip"
    fi

    sleep "$waktu_penundaan"
done
