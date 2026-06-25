#!/bin/bash


# limpar a linha de comandos
clear

### definir o arquivo
arquivo='info.txt'

### limpar o ficheiro
echo > $arquivo


### COMANDOS - como variáveis

# distribuição
dist=$(lsb_release -i | cut -d: -f2)

# descrição da distribuição
desc=$(lsb_release -d | cut -d: -f2)

# versão da distribuição
version=$(lsb_release -r | cut -d: -f2)

# codename da versão da distribuição
codename=$(lsb_release -c | cut -d: -f2)

# arquitetura do sistema
arch=$(arch)

# memória livre
free_mem=$(free -h | grep -wi mem | sed "s/  //g" | cut -d " " -f4)

# espaço livre
free_disk=$(df -h | grep -w / | tr -s " " | cut -d " " -f3)

# IP interno
ip=$(hostname -I)

# MAC address
mac_a=$(ifconfig | egrep ether | tr -s " " | cut -d " " -f3)

# pacotes TX
tx=$(ifconfig | egrep "TX packets" | head -1 | cut -d "(" -f2 | sed "s/)//g")

# pacotes RX
rx=$(ifconfig | egrep "RX packets" | head -1 | cut -d "(" -f2 | sed "s/)//g")

# data e hora atual do sistema
date_time=$(date +'%d-%m-%Y %H:%M:%S')

# uptime
uptime=$(uptime | cut -d "," -f1)

# portas na firewall
firewall_ports=$(sudo ufw status | cut -d" " -f1 | egrep "[0-9]+$"*)

# utilizador loggado - que estamos a utilizar na linha de comandos
logged_user=$USER

# ip externo
ip_ext=$(curl -s ifconfig.io)

# nome do servidor
server=$(hostname)

# temperaturas do servidor (são 8 e aparecerão pela ordem comentada em baixo)
## CPU - Processador como um todo (média da temperatura dos cores) - Package id 0 
## CPU - Core 0  
## CPU - Core 1
## CPU - Core 2
## CPU - Core 3
## Motherboard - zona perto da CPU - temp1
## Motherboard - zona perto do Chipset - temp2
## GPU - temp1
temps=$(sensors | cut -d'(' -f1 | grep -oP '\+\K[0-9.]+.*C')


### função para chamar cada uma das variáveis invocadas uma a uma 
for var in "$mac_a" "$server" "$logged_user" "$dist" "$desc" "$version" "$codename" "$arch" "$free_mem" "$used_mem" "$free_disk" "$used_disk" "$ip" "$ip_ext" "$tx" "$rx" "$date_time" "$uptime" $temps "$users"
do
	# mostrar os valores ao fazer sh neste ficheiro
	echo $var

	# mandar os valores para o arquivo 
	echo $var >> $arquivo
done

