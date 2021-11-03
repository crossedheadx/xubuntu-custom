#!/usr/bin/env bash
# this script will create a set of commands on the shell
{
echo "##CUSTOM COMMANDS" 
echo "alias rimuovi='shred -fuzv -n 8' # cancellazione sicura" #secure erase
echo "alias nuke='shred -fuzv -n 40' # cancellazione definitiva" #secure erase final form
echo "alias installa='sudo apt install'"
echo "alias INSTALLA='sudo apt install -y' # non chiede conferma per installare"
echo "alias disinstalla='sudo apt remove'"
echo "alias DISINSTALLA='sudo apt remove -y' # non chiede conferma per disinstallare"
echo "alias aggiorna='sudo apt update && sudo apt full-upgrade - y && sudo apt autoremove -y'"
echo "alias ..='cd ..'"
echo "alias pulisci='clear'"
echo "alias ls='ls --color=auto'"
echo "alias grep='grep --color=auto'"
echo "alias egrep='egrep --color=auto'"
echo "alias fgrep='fgrep --color=auto'"
echo "alias fastping='ping -c 100 -s.2' # esegue un ping rapido"
echo "alias porte='netstat -tulanp'"
echo "alias rm='rm -I --preserve-root'"
echo "alias mv='mv -i'"
echo "alias cp='cp -i'"
echo "alias ln='ln -i'"
echo "alias chown='chown --preserve-root'"
echo "alias chmod='chmod --preserve-root'"
echo "alias chgrp='chgrp --preserve-root'"
echo "alias meminfo='free -m -l -t' #mostra la memoria libera"
echo "alias psmem='ps auxf | sort -nr -k 4' #mostra i processi mangia-memoria"
echo "alias psmem10='ps auxf | sort -nr -k 4 | head -10' # mostra i processi mangia-memoria"
echo "alias pscpu='ps auxf | sort -nr -k 3' #mostra i processi mangia cpu"
echo "alias pscpu10='ps auxf | sort -nr -k 3 | head -10' #mostra i processi mangia cpu"
echo "alias cpuinfo='lscpu' # mostra le info della cpu"
echo "alias copia='rsync -ah --info=progress2' # copia sicura con progress bar"
echo "alias aiuto='tail -n 40 $HOME/.bashrc' #mostra tutti gli alias"
} >> "$HOME"/.bashrc
source "$HOME"/.bashrc
echo "Ho finito!"
sleep 5
return 1