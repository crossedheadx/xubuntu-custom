
pub mod op {
    use crate::messages::out::{print_menu, print_infos};
    use crate::utilities::utility::read;
    
    enum PostInstallMode {
        Manual,
        Automatic
    }

    pub fn startup(){
        print_menu();
        let user_input:String = read();
        match user_input.as_str() {
            "s\n" => post_installation(PostInstallMode::Automatic),
            "n\n" => post_installation(PostInstallMode::Manual),
            "i\n" => {print_infos(); startup();},
            _ => stop()
        }
    }
    
    fn stop(){
        println!("vuoi interrompere? [s]ì [n]o");
        let user_input:String = read();
        match user_input.as_str() {
            "s\n" => return,
            "n\n" => startup(),
            _ => stop()
        }
    }
    
    fn post_installation(_mode: PostInstallMode){
        println!("tbi");
    }
}

