
pub mod op {
    use std::future::Future;

    use cmd_lib::CmdResult;
    use crate::messages::out::*;
    use crate::utilities::utility::read;
    use crate::{post_install::install::post_install_steps, op_types::PostInstallMode};
      
    pub async fn startup() -> Box<dyn Future<Output = CmdResult>> {
        print_menu();
        let user_input:String = read();
        match user_input.as_str() {
            "s\n" => Box::new(post_install_steps(PostInstallMode::Automatic)),
            "n\n" => Box::new(post_install_steps(PostInstallMode::Manual)),
            "i\n" => {
                print_infos(); 
                clean_screen().unwrap(); 
                return startup().await;
            },
            _ => return stop()
        }
    }
    
    async fn stop() -> CmdResult {
        println!("vuoi interrompere? [s]ì [n]o");
        let user_input:String = read();
        match user_input.as_str() {
            "s\n" => return Ok(()),
            "n\n" => { 
                clean_screen().unwrap(); 
                return startup().await
            },
            _ => return stop().await
        }
    }
}

