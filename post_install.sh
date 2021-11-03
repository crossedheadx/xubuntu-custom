#!/usr/bin/env bash
# shell post install script - executed after installation
if [ "$(whoami)" != 'root' ]; then
        echo "Must be root to run $0"
        exit 1;
fi
## functions part - parte funzioni
# print short description for user - stampa una breve descrizione per l'utente
print_infos(){
     echo -ne "Con la modalità automatica lasci che questo script si occupi interamente del post installazione   \n"
     echo -ne "l'unica interazione che ti verrà richiesta, sarà l'accettazione dei termini e condizioni di alcuni\n"
     echo -ne "software e l'inserimento della password utente. \n\n"
     echo -ne "Attenzione: la modalità automatica desumerà che questo pc abbia anche un lettore ottico DVD ed    \n"
     echo -ne "installerà tutti i software necessari al suo funzionamento come lettore video, poi ed altri extra \n"
     echo -ne "quali: skype, zoom, telegram, spotify, joplin, ecc. \n\n\n"
     sleep 5
     echo -ne "Premere INVIO o ENTER per tornare indietro..."
     read INPUT ## return back - ritorna indietro
     clear
     begin
}

# this will avoid future false-positive internal errors - questo eviterà futuri errori interni falsi positivi 
remove_false_positive(){
    to_log "Removing false-positive internal errors..."
    sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport
    notify-send 'rimozione falsi errori di sistema: FATTO!'
    to_log "Removing false-positive internal errors: DONE!"
}

#initial message - messaggio iniziale
start_message() {
    echo "Avvio post installazione"
    sleep 0.75
    clear
    loading
    notify-send 'Avvio post installazione'
}

# loading screen - schermata di caricamento
loading(){
    echo -ne "Caricamento "
    for i in {1..100}; do
        echo -ne "\b\r"
        echo -ne "\t\t $i%"
        sleep 0.0225
    done
}

spinner(){
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}
# enable multiverse and other useful repos - abilita i repo multiversi e altri utili
enable_repos(){
    to_log "Abilitazione dei repo necessari"
    sudo add-apt-repository -y universe
    sudo add-apt-repository -y multiverse
    sudo add-apt-repository -y restricted
    to_log "Repo abilitati"
}

# enable canonical's partner repository - abilita il repository partner di canonical
enable_canonical_partners(){
    to_log "Abilitazione repository partner di canonical"
    notify-send 'abilito i partners di Canonicals'
    echo "deb http://archive.canonical.com/ubuntu $(lsb_release -cs) partner" | sudo tee -a /etc/apt/sources.list
    echo "deb-src http://archive.canonical.com/ubuntu $(lsb_release -cs) partner" | sudo tee -a /etc/apt/sources.list
    to_log "Abilitazione repository partner di canonical: Fatto!"
}

# refresh package list - aggiorna la lista dei pacchetti
do_updates(){
    notify-send 'Controllo aggiornamenti e metto software utile'
    sudo apt update && sudo apt -y full-upgrade && sudo snap refresh
}

## inclusion part - parte inclusioni
include_zips(){
    echo "rar unrar p7zip-full p7zip-rar"
}

include_extra_fonts(){
    echo "fonts-crosextra-caladea fonts-crosextra-carlito"
}

include_audio(){
    echo "audacity"
}

include_videos(){
    echo "vlc mpv"
}

include_cli_downloader(){
    echo "wget curl"
}

include_git(){
    echo "git"
}

include_shell(){ 
    echo "zsh" 
}

include_shell_extra(){
    echo "mc vim ranger"
}

# end inclusion part - fine parte inclusioni

# enable dvd integration - abilita l'integrazione con il lettore DVD
install_dvd(){
    to_log "Abilito l'integrazione con il lettore DVD"
    sudo apt install -y libdvd-pkg && sudo dpkg-reconfigure libdvd-pkg
    to_log "Abilito l'integrazione con il lettore DVD: Fatto!"
}

# implements easy-to-use commands to simply mantain the system - implementa i comandi facili da mantenere il sistema
install_custom_shell_commands(){
    to_log "install_custom_shell_commands"
    source "$(pwd)"/custom_shell.sh
    to_log "custom alias setted"
}

#install snap packages - installa i pacchetti snap
snap_install(){
    to_log "Installo i pacchetti snap"
    ## constant variables declaration - dichiarazione costanti
    declare -A SNAP=(["skype"]="skype --classic" ["telegram"]="telegram-desktop" ["zoom"]="zoom-client" ["joplin"]="joplin-desktop" ["spotify"]="spotify" ["chromium"]="chromium")
    ## end of constant variables declaration - fine dichiarazione costanti
    if [ -z "$1" ] && [ "$1" = "M" ]
    then
        for i in "${SNAP[@]}"; do
            echo "Installo ${SNAP[$i]} ? [s]ì [n]o"
            read -r INPUT
            to_log "Installazione ${SNAP[$i]}"
            if [[ $INPUT != Nn ]]; then
                sudo snap install "${SNAP[$i]}"
            fi
            
        done
    else
        for i in "${SNAP[@]}"; do
        to_log "Installazione ${SNAP[$i]}"
            echo "Installo ${SNAP[$i]}"
            sudo snap install "$i"
        done
    fi
    to_log "Installazione pacchetti snap completata"
}

install_extra_software(){
    to_log "Installo software extra"
    declare -a PKGS=($(include_zips) $(include_extra_fonts) $(include_audio) $(include_videos) $(include_cli_downloader) $(include_git) $(include_shell) $(include_shell_extra))
    if [ "$1" = "M" ] ; then
        for pkg in "${PKGS[@]}"; do
            echo "Installo $pkg ? [s]ì [n]o"
            read -r INPUT
            if [[ $INPUT != Nn ]]; then
            to_log "Installo $pkg"
                sudo apt install -y "$pkg"
            fi
        done
        echo "Installo package per il dvd? [s]ì [n]o"
        read -r INPUT
            if [[ $INPUT != Nn ]]; then
                install_dvd
            fi
    else
        sudo apt install -y "${PKGS[@]}"
        install_dvd
    fi
    to_log "Installazione software extra completata"
}

# kernel liquorix install - installazione del kernel liquorix
kernel_liquorix(){
    to_log "Installo il kernel liquorix"
    sudo add-apt-repository -y ppa:damentz/liquorix && do_updates
    sudo apt-get install -y linux-image-liquorix-amd64 linux-headers-liquorix-amd64
    to_log "Installazione kernel liquorix completata"
}

# timeshift install - installazione timeshift
install_backup_tool(){
    to_log "Installo timeshift"
    sudo add-apt-repository -y ppa:teejee2008/ppa
    do_updates
    sudo apt install -y timeshift
    to_log "Installazione timeshift completata"
}

# remote desktop program install - installazione del programma di desktop remoto 
rdp_install(){
    to_log "Installo RDP"
    notify-send 'scarico ed installo software di controllo remoto'
    if [ -z "$1" ] && [ "$1" = "M" ] ; then
        echo "installo Teamviewer? [s]ì [n]o"
        read -r INPUT
        if [[ $INPUT =~ ^[Ss]$ ]]; then
            wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
        fi
        echo "installo AnyDesk? [s]ì [n]o"
        read -r INPUT
        if [[ $INPUT =~ ^[Ss]$ ]]; then
            wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb
        fi
        sudo apt install -y ./*.deb
        rm -rf ./*.deb
    else
        wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb 
        wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb
        sudo apt install -y ./*.deb
        rm -rf ./*.deb
    fi
    to_log "Installazione RDP completata"
}

# implement zram compression - implementa la compressione zram
implement_zram_optimization(){
    #TODO: set zswap, but with a small check on performance in order to not hang up system
    to_log "Imposto la compressione zram"
    source "$(pwd)"/zram.sh
    clear
    to_log "Compressione zram impostata"
}

#implement_no_hangup_oom(){
#    # TODO implement a oom sys between the garuda and earlyoom file and set a fine tuning system
#}

# START THE MAIN INSTALLATION PROCESS - INIZIO DEL PROCESSO DI INSTALLAZIONE
start_post_install(){
    to_log "Inizio installazione"
    if [ "$1" != "Y" ]; then 
        clear
        echo -ne 'ATTENZIONE: potrebbe essere richiesta qualche azione da parte utente: '
        echo -ne 'accettare tutto'
        sleep 2
        MODE="A"
    else
        MODE="M"
    fi
    clear

    do_updates
    sudo apt install -y ubuntu-restricted-extras ubuntu-restricted-addons pv
    clear
    
    install_extra_software "$MODE"
    clear
    
    snap_install "$MODE"
    clear
    
    rdp_install "$MODE" 
    clear
    loading
    kernel_liquorix
    clear
    
    install_backup_tool
    clear
    
    implement_zram_optimization
    clear

    install_custom_shell_commands
    final_operations
}

# cleanup - pulizia
final_operations() {
    to_log "Pulizia"
    clear
    notify-send 'faccio pulizia'
    sudo apt autoremove -y
    remove_false_positive
    rm *.log
    loading
    echo "ho finito!"
    notify-send 'finito!'
    to_log "Pulizia completata"
    cd ..
    rm -rf "$(pwd)"/post_install
    reboot # apply all mods and reboot - applica tutti i modifiche e riavvia
}

to_log(){
    echo -ne "\n>$(date): \n $1" >> "$(pwd)"/progress.log
}

#from_log(){
#
#}

begin(){
    loading
    clear
    USCITA='false'    
    until [[ "$USCITA" = "true" ]]; do
    chmod a+x *.sh
    echo "Avvio la modalità automatica? [s]ì [n]o [i]nfo"
    read -r SCELTA1
        case "$SCELTA1" in
            "s")
                    start_message
                    start_post_install
                    ;;
            "n")
                    start_message
                    start_post_install "Y"
                    ;;
            "i")
                    clear
                    print_infos
                    ;;
            *)
                    echo "vuoi interrompere? [s]ì [n]o"
                    read -r SCELTA2
                    if [[ "$SCELTA2" = 's' ]]; then
                        USCITA='true'
                    fi
                    ;;   
        esac
    done
}

## end functions part - fine parte funzioni 

begin
exit 1 ## end script - fine script