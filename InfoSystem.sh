#!/bin/bash
echo "Ini Merupakan Program sistem"
log=>>/opt/aino/backuplog/Hasilrun.log
log1=Hasilrun.log

timestamp=$(date +"%H:%M:%S %d-%m-%Y" )

# Informasi RAM
ram_info=$(free -m | awk 'NR==2{printf "RAM Usage: %s/%sMB (%.2f%%)\n", $3, $2, $3*100/$2 }')

# Informasi Disk
disk_info=$(df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3, $2, $5}')

# Informasi CPU
cpu_info=$(top -bn1 | grep load | awk '{printf "CPU Usage: %.2f%%\n", $(NF-2)}')

# Menjalankan perintah ifconfig dan menyimpan output dalam variabel 'ifconfig_output'
ifconfig_output=$(ifconfig)

interface="eth0"

# Menjalankan ifconfig untuk mendapatkan alamat MAC
mac_address=$(ifconfig $interface | awk '/ether/{print $2}')

# Menghilangkan karakter ":" dari alamat MAC
mac_address_no_colon=$(echo $mac_address | tr -d ':')

#Cek status Online

echo " " >>/opt/aino/backuplog/Hasilrun.log
# Menampilkan informasi
echo "System Info:" >>/opt/aino/backuplog/Hasilrun.log
echo "$ram_info" >>/opt/aino/backuplog/Hasilrun.log
echo "$disk_info" >>/opt/aino/backuplog/Hasilrun.log
echo "$cpu_info" >>/opt/aino/backuplog/Hasilrun.log
 
# Menampilkan alamat MAC tanpa ":" ke layar
echo "MAC Address: $mac_address_no_colon" >>/opt/aino/backuplog/Hasilrun.log

if ping -c 2 google.com > /dev/null 2>&1; then
    
    echo "Status: Online" >>/opt/aino/backuplog/Hasilrun.log
else
    echo "Status: Offline" >>/opt/aino/backuplog/Hasilrun.log
fi

echo "Waktu Testing: $timestamp" >>/opt/aino/backuplog/Hasilrun.log
# echo "Program telah berjalan dengan baik"
echo "Untuk lihat hailnya silahkan akses ke: $log1" 