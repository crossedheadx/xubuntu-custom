
pub mod op {
    use async_recursion::async_recursion;
    use std::process::Command;
    use crate::messages::out::*;
    use crate::utilities::utility::read;
    use crate::{post_install::install::post_install_steps, op_types::PostInstallMode};
      
    #[async_recursion]
    pub async fn startup() {
        print_menu();
        let user_input:String = read();
        match user_input.as_str() {
            "s\n" => post_install_steps(PostInstallMode::Automatic).await,
            "n\n" => post_install_steps(PostInstallMode::Manual).await,
            "i\n" => {
                print_infos(); 
                clean_screen(); 
                startup().await
            },
            _ => stop().await
        }
    }

    #[async_recursion]
    async fn stop() {
        println!("vuoi interrompere? [s]ì [n]o");
        let user_input:String = read();
        match user_input.as_str() {
            "s\n" => {
               Command::new("exit");
            },
            "n\n" => { 
                clean_screen(); 
                return startup().await
            },
            _ => return stop().await
        }
    }
}

