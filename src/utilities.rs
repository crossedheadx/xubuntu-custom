pub mod utility {
    use std::{io, thread, time};

    pub fn read() -> String {
        let mut user_input:String = String::new();
        io::stdin().read_line(&mut user_input).expect("Failed to read input");
        user_input
    }

    pub fn to_log(msg: String){
        println!("{}", msg);
    }

    pub fn sleep(seconds: u64) {
        thread::sleep(time::Duration::from_millis(seconds));
    }
}

