
// TODO: implement function for logging actions
// TODO: implement function for logging operation concluded
// TODO: implement function for resume interrupted operation, from startup

use std::io;

enum PostInstallMode {
    Manual,
    Automatic
}

fn main() {
    startup();
}


fn startup(){
    print_menu();
    let mut user_input:String = String::new();
    io::stdin().read_line(&mut user_input).expect("Failed to read input");
    match user_input.as_str() {
        "s\n" => post_installation(PostInstallMode::Automatic),
        "n\n" => post_installation(PostInstallMode::Manual),
        "i\n" => {print_infos(); startup();},
        _ => stop()
    }
}

fn print_menu(){
    println!("Avvio la modalità automatica? [s]ì [n]o [i]nfo");
}

fn print_infos(){
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
        user_input = String::from("");
        println!("Premere INVIO o ENTER per tornare indietro...");
        io::stdin().read_line(&mut user_input).expect("Failed to read input");       
    }
}

fn stop(){
    println!("vuoi interrompere? [s]ì [n]o");
    let mut user_input:String = String::new();
    io::stdin().read_line(&mut user_input).expect("Failed to read input"); 
    match user_input.as_str() {
        "s\n" => return,
        "n\n" => startup(),
        _ => stop()
    }
}

fn post_installation(_mode: PostInstallMode){
    println!("tbi");
}

/*
fn usb_copy_issue_fix(){
    let dirty_background_bytes:i32 = 16*1024*1024;
    let dirty_bytes:i32 = 48*1024*1024;
    // TODO: implement follow lines in Rust and place into flow
    // echo $((16*1024*1024)) > /proc/sys/vm/dirty_background_bytes
    // echo $((48*1024*1024)) > /proc/sys/vm/dirty_bytes
}
*/
