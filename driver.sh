#!/usr/bin/env bash
#-----------------------------------------------------------------------------------------------------------------------#
# Script Shell por João Cláudio de Alcântara.----------------------------------------------------#
#----------------------------------------------------------------------------------------------------------------------#
# Este script foi escrito para ser capaz de instalar drivers proprietário------------#
# da Nvidia em qualquer Linux OS.------------------------------------------------------------------#
# Ele foi testado no Lubuntu 16.04 LST.----------------------------------------------------------#
# Você pode alterar e redistribuir este script.-------------------------------------------------#
#---------------------------------------------------------------------------------------------------------------------#
clear
echo "=========================================="
echo "#                 CREDITO                #"                                                 #
echo "#    Autor: João Cláudio de Alcântara    #"                         #
echo "#     E-mail: joaoclaudio63@gmail.com    #"                      #
echo "=========================================="
sleep 5
#-----------VARIAVEIS----------#
echo "Coloque o caminho do instalador oficial baixado do site da Nvidia"
read instalador
#-------------------------------------#
#-------------TESTES-------------#
if [ `whoami` == root ]; then	# Verifica se o script shell esta sendo executado como root
	echo "Você é ROOT"
else
	echo -e "\033[31mVocê deve ser ROOT para executar este Script Shell.\033[m"; exit
fi
while true	# Verifica se o arquivo de driver Nvidia foi encontrado
do
	if [ -f $instalador ]; then
		echo "Arquivo encontrado"; break
	else
		echo -e "\033[31mFalha arquivo não foi encontrado\033[m"; echo -e "Coloque o caminho do instalador oficial baixado do site da Nvidia\nCtrl+C para sair !"; read instalador
	fi
done
echo -e " 
\033[0;31mATENÇÃO\033[m\n---> Este script deve ser executado no terminal\npara acessar o terminal use as teclas Ctrl+Alt+F1.\nO computador precisa reiniciar e você tera\nque iniciar o script varias vezes ate terminar a instalação !\n
"
read -p "Pressione [Enter] para continuar ou CTRL+C para sair..."
# Detecta e para o direct manager suporta LightDM, GDM, MDM, KDM, LXDM e SDDM
if type /etc/init.d/lightdm; then echo "Detectado LightDM";
/etc/init.d/lightdm stop
	elif type /etc/init.d/gdm; then echo "Detectado GDM";
	/etc/init.d/gdm stop
	elif type /etc/init.d/kdm; then echo "Detectado MDM";
	/etc/init.d/mdm stop
	elif type /etc/init.d/mdm; then echo "Detectado KDM";
	/etc/init.d/kdm stop
	elif type /etc/init.d/lxdm; then echo "Detectado LXDM";
	/etc/init.d/lxdm stop
	elif type /etc/init.d/sddm; then echo "Detectado SDDM";
	/etc/init.d/sddm stop
else
	echo -e "\033[0;31mFalha não foi possível detectar o Direct Manager.\nRever linhas 40 a 55.\033[m"
	exit
fi
#-------------------------------------#
echo -e "\033[0;32m
      _        _                         _     
     | |      (_)                       | |    
   __| | _ __  _ __   __ ___  _ __  ___ | |__  
  / _  ||  __|| |\ \ / // _ \|  __|/ __||  _ \ 
 | (_| || |   | | \ V /|  __/| | _ \__ \| | | |
  \__ _||_|   |_|  \_/  \___||_|(_)|___/|_| |_|
\033[0;34mVersion: 1\033[m
"
if lsmod | grep nouveau; then	# Detecta se o nouveau esta ativo e desativa.
	echo -e "# Gerado pelo script driver.sh\nblacklist nouveau\noptions nouveau modeset=0" > /etc/modprobe.d/blacklist-nouveau.conf
	update-initramfs -u
	echo -e "O sistema sera reiniciado em 10 seg...\napós reinicio iniciar novamente o script.\nCtrl+C para cancelar !"
	sleep 10
	systemctl -i reboot
fi
bash $instalador	# Inicia o instalador
echo -e "O sistema sera reiniciado em 10 seg...\nCtrl+C para cancelar !"
sleep 10
systemctl -i reboot