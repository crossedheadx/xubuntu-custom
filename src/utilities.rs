pub mod utility {
    use std::io;

    pub fn read() -> String {
        let mut user_input:String = String::new();
        io::stdin().read_line(&mut user_input).expect("Failed to read input");
        user_input
    }

    pub fn to_log(msg: String){
        println!("{}", msg);
    }
}

