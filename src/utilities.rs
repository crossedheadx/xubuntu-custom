pub mod utility {
    use std::{io, thread, time, fs};
    use std::io::Cursor;
    type Result<T> = std::result::Result<T, Box<dyn std::error::Error + Send + Sync>>;
    use crate::op_types::{ListCategories};
 
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

    fn get_packages() -> ListCategories {
        let path: &str = "./packages.json";
        let data:String = fs::read_to_string(path).expect("Error reading file");
        let res: serde_json::Value = serde_json::from_str(&data).expect("Error parsing json");
        println!("{:?}", res);
        // Todo: parse into obj with given struct
    }
}

