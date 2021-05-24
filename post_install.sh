#!/bin/bash
# shell post install script

echo "Avvio post installazione"
notify-send 'Avvio post installazione'
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y restricted
# this will avoid future false-positive internal errors
sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport
notify-send 'rimozione falsi errori di sistema: FATTO!'

# enable canonical's partner repository
notify-send 'abilito i partners di Canonicals'
echo "deb http://archive.canonical.com/ubuntu $(lsb_release -cs) partner" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://archive.canonical.com/ubuntu $(lsb_release -cs) partner" | sudo tee -a /etc/apt/sources.list
#

notify-send 'Controllo aggiornamenti e metto software utile'
sudo apt update && sudo apt -y dist-upgrade && sudo snap refresh
notify-send 'ATTENZIONE: potrebbe essere richiesta qualche azione da parte utente'
notify-send 'accettare tutto'
sudo apt install -y ubuntu-restricted-extras ubuntu-restricted-addons rar unrar p7zip-full p7zip-rar fonts-crosextra-caladea fonts-crosextra-carlito libdvd-pkg vlc mpv wget curl mc git vim zsh

# snap part
sudo snap install skype --classic
sudo snap install zoom-client
sudo snap install telegram-desktop
sudo snap install joplin-desktop
sudo snap install spotify
sudo snap install chromium
# end snap part

sudo dpkg-reconfigure libdvd-pkg

# kernel liquorix install
sudo add-apt-repository -y ppa:damentz/liquorix && sudo apt-get update
sudo apt-get install -y linux-image-liquorix-amd64 linux-headers-liquorix-amd64

# timeshift
sudo add-apt-repository -y ppa:teejee2008/ppa
sudo apt update
sudo apt install -y timeshift

notify-send 'scarico ed installo software di controllo remoto'
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb 
wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb
sudo apt install -y "$HOME/*.deb"
rm -rf "$HOME/*.deb"

notify-send 'faccio pulizia'
sudo apt autoremove -y

notify-send 'finito!'
reboot # apply all mods
