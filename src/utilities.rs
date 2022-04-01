pub mod utility {
    use std::{io, thread, time};
    use std::io::Cursor;
    type Result<T> = std::result::Result<T, Box<dyn std::error::Error + Send + Sync>>;
 
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

    // downloader 
    async fn donwload(url: String, file_name: String) -> Result<()> {
        let response = reqwest::get(url).await?;
        let mut file = std::fs::File::create(file_name)?;
        let mut content =  Cursor::new(response.bytes().await?);
        std::io::copy(&mut content, &mut file)?;
        Ok(())
    }
}

