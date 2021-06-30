echo -n "#Architecture : " && uname -a
echo -n "#CPU physical : " && grep "cpu cores" /proc/cpuinfo | sort -u | cut -c13-
echo -n "#vCPU : " && grep "siblings" /proc/cpuinfo | sort -u | cut -c12-
echo -n "#Memory usage : " && free -m | grep Swap | awk '{print $3, "/", $2, "MB", " ", "(", $3/$2 * 100.0, "%)"}'
echo -n "#Disk usage : " && free -m | grep Mem | awk '{print $3, "/", $2, "Gb", " (", $3/$2 * 100.0, "%)"}'
echo -n "#CPU load : " && grep -m 1 'cpu' /proc/stat | awk '{print ($2 + $4) * 100 / ($2 + $4 + $5), "%"}'
echo -n "#Last boot : " && who -b | cut -c22-
echo -n "#LVM use : " && if lsblk | grep lvm | wc -l > /dev/null; then
	echo "yes"
else
	echo "no"
fi
echo -n "#Connections TCP : " && cat /proc/net/tcp | wc -l | awk '{print $1, "ESTABLISHED"}'
echo -n "#User log : " && who -q | grep users | awk '{print $2}' | cut -c7-
echo -n "#Network : " && echo -n "IP:$( hostname -I)" && /usr/sbin/ifconfig | awk ' /ether/ {print "(", $2, ")"}'
echo  "#Sudo : " "$(grep -c 'COMMAND' /var/log/sudo/sudolog)" "cmd"