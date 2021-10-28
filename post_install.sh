#!/bin/bash
# shell post install script - executed after installation

## constant variables declaration - dichiarazione costanti

SNAP = (["skype"] = "skype --classic", ["telegram"] = "telegram-desktop", ["zoom"] = "zoom-client", ["joplin"] = "joplin-desktop", ["spotify"] = "spotify", ["chromium"] = "chromium")

## end of constant variables declaration - fine dichiarazione costanti

## functions part - parte funzioni
## print short description for user - stampa una breve descrizione per l'utente
print_infos(){
     echo -ne "Con la modalità automatica lasci che questo script si occupi interamente del post installazione"
     echo -ne "l'unica interazione che ti verrà richiesta, sarà l'accettazione dei termini e condizioni di alcuni software"
     echo -ne "e l'inserimento della password utente"
     echo -ne "Attenzione: la modalità automatica desumerà che questo pc abbia anche un lettore ottico ed installerà tutti i software"
     echo -ne "extra quali: skype, zoom, telegram, spotify, joplin, ecc."
     sleep 15
     echo -ne "Premere INVIO o ENTER per tornare indietro..."
     read INPUT ## return back - ritorna indietro
     clear
     return
}

## this will avoid future false-positive internal errors - questo eviterà futuri errori interni falsi positivi 
remove_false_positive(){
    sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport
    notify-send 'rimozione falsi errori di sistema: FATTO!'
}

start_message() {
    echo "Avvio post installazione"
    notify-send 'Avvio post installazione'
}

# enable multiverse and other useful repos - abilita i repo multiversi e altri utili
enable_repos(){
    sudo add-apt-repository -y universe
    sudo add-apt-repository -y multiverse
    sudo add-apt-repository -y restricted
}

# enable canonical's partner repository - abilita il repository partner di canonical
enable_canonical_partners(){
    notify-send 'abilito i partners di Canonicals'
    echo "deb http://archive.canonical.com/ubuntu $(lsb_release -cs) partner" | sudo tee -a /etc/apt/sources.list
    echo "deb-src http://archive.canonical.com/ubuntu $(lsb_release -cs) partner" | sudo tee -a /etc/apt/sources.list
}

do_updates(){
    notify-send 'Controllo aggiornamenti e metto software utile'
    sudo apt update && sudo apt -y dist-upgrade && sudo snap refresh
}

include_zips(){
    return "rar unrar p7zip-full p7zip-rar"
}

include_extra_fonts(){
    return "fonts-crosextra-caladea fonts-crosextra-carlito"
}

include_videos(){
    return "vlc mpv"
}

include_cli_downloader(){
    return "wget curl"
}

include_git(){
    return "git"
}

include_shell(){ 
    return "zsh" 
}

include_shell_extra(){
    return "mc vim"
}

install_dvd(){
    sudo apt install -y libdvd-pkg && sudo dpkg-reconfigure libdvd-pkg
}

install_custom_shell_commands(){
    # implements easy-to-use commands to simply mantain the system
    # eg = alias 'cinst'='sudo apt install'...
    # TODO: download implementation of the alias
}

snap_install(){
# TODO: implement for loop from choices passed from arguments
    sudo snap install # TODO: implement snap install
}

# kernel liquorix install - installazione del kernel liquorix
kernel_liquorix(){
    sudo add-apt-repository -y ppa:damentz/liquorix && do_updates
    sudo apt-get install -y linux-image-liquorix-amd64 linux-headers-liquorix-amd64
}

# timeshift install - installazione timeshift
install_backup_tool(){
    sudo add-apt-repository -y ppa:teejee2008/ppa
    do_updates
    sudo apt install -y timeshift
}

# remote desktop program install - installazione del programma di desktop remoto 
rdp_install(){
    notify-send 'scarico ed installo software di controllo remoto'
    wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb 
    wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb
    sudo apt install -y ./*.deb
    rm -rf ./*.deb
}

implement_zram_optimization(){
    #TODO set minimal configuration to apply a correct implementation for zram and sys stabilty
    # shall impose small memory blocks
    # and shall impose zstd compession which is the best, for now 
    # and the zswap, but with a small check on performance in order to not hang up system
}

implement_no_hangup_oom(){
    # TODO implement a oom sys between the garuda and earlyoom file and set a fine tuning system
}

# START THE MAIN INSTALLATION PROCESS - INIZIO DEL PROCESSO DI INSTALLAZIONE
start_post_install(){
    notify-send 'ATTENZIONE: potrebbe essere richiesta qualche azione da parte utente'
    notify-send 'accettare tutto'
    clear 
    sudo apt install -y ubuntu-restricted-extras ubuntu-restricted-addons
    clear
    snap_install
    clear
    rdp_install ###passare parametri in array
    clear
    kernel_liquorix
    clear
    install_backup_tool
    clear
    final_operations
}

final_operations() {
    clear
    notify-send 'faccio pulizia'
    sudo apt autoremove -y

    notify-send 'finito!'
    reboot # apply all mods - 
}

choice_actions(){
}
## end functions part - fine parte funzioni  

echo "Avvio la modalità automatica? [s]ì [n]o [i]nfo"
read SCELTA1
USCITA = false

until [[$USCITA = true]]; do
    case "$SCELTA1" in
        "s")
                start_message
                remove_false_positive
                ;;
        "n")
                start_message
                choice_actions
                ;;
        "i")
                print_infos
                ;;
        *)
                echo "vuoi interrompere? [s]ì [n]o"
                read SCELTA2
                if [[$SCELTA2 = "s"]]; then
                    USCITA = true
                fi
                ;;   
    esac
done

exit 0 ## fine script