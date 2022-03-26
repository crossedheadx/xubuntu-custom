
pub mod op {
    use cmd_lib::CmdResult;
    use crate::messages::out::*;
    use crate::utilities::utility::{read};
    use crate::post_install::Install::post_install_steps;
    use crate::op_types::{PostInstallMode};
  
    pub fn startup() -> CmdResult {
        print_menu();
        let user_input:String = read();
        match user_input.as_str() {
            "s\n" => post_install_steps(PostInstallMode::Automatic),
            "n\n" => post_install_steps(PostInstallMode::Manual),
            "i\n" => {
                print_infos(); 
                clean_screen(); 
                return startup();
            },
            _ => stop()
        };
        Ok(())
    }
    
    fn stop() -> CmdResult {
        println!("vuoi interrompere? [s]ì [n]o");
        let user_input:String = read();
        match user_input.as_str() {
            "s\n" => return Ok(()),
            "n\n" => { 
                clean_screen(); 
                return startup()
            },
            _ => return stop()
        }
    }
}

