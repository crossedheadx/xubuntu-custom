
pub mod out {
    use crate::utilities::utility::sleep;
    use crate::utilities::utility::read;
    use std::io::*;
    use std::process::Command;

    pub fn print_menu(){
        println!("Avvio la modalità automatica? [s]ì [n]o [i]nfo");
    }
    
    pub fn print_infos(){
        println!("Con la modalità automatica lasci che questo script si occupi interamente del post installazione   ");
        println!();
        println!("l'unica interazione che ti verrà richiesta, sarà l'accettazione dei termini e condizioni di alcuni");
        println!();
        println!("software e l'inserimento della password utente. ");
        println!();
        println!();
        println!("Attenzione: la modalità automatica desumerà che questo pc abbia anche un lettore ottico DVD ed    ");
        println!();
        println!("installerà tutti i software necessari al suo funzionamento come lettore video, poi ed altri extra ");
        println!();
        println!("quali: skype, zoom, telegram, spotify, joplin, ecc. ");
        println!();
        println!();
        
        let mut user_input:String = String::new();
        while user_input != "\n" {
            println!("Premere INVIO o ENTER per tornare indietro...");
            user_input = read();
        }
    }

    pub fn clean_screen(){
        Command::new("clear");
    }

    pub async fn loading(){
        clean_screen();
        println!("{}", "loading");
        for _ in 0..100 {
            print!("{}", ".");
            let _ = stdout().flush();
            sleep(125);
        }
        clean_screen()
    }
}