
pub mod op {
    use std::process::Command;
    use crate::messages::out::*;
    use crate::utilities::utility::read;
    use crate::{post_install::install::post_install_steps, op_types::PostInstallMode};
      
    
    pub fn startup(){
        main_menu();
    }

    fn main_menu() {
        print_menu();
        let user_input:String = read();
        match user_input.as_str() {
            "s\n" => post_install_steps(PostInstallMode::Automatic),
            "n\n" => post_install_steps(PostInstallMode::Manual),
            "i\n" => {
                print_infos(); 
                clean_screen(); 
                startup()
            },
            _ => stop()
        }
    }


    fn stop() {
        println!("vuoi interrompere? [s]ì [n]o");
        let user_input:String = read();
        match user_input.as_str() {
            "s\n" => {
               Command::new("exit");
            },
            "n\n" => { 
                clean_screen(); 
                startup()
            },
            _ => stop()
        }
    }
}
