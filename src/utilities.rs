pub mod utility {
    use std::{io, thread, time, fs};
    use std::io::{Write, Cursor};
    use crate::op_types::PostInstallMode;
    
    type Result<T> = std::result::Result<T, Box<dyn std::error::Error + Send + Sync>>;
    use crate::op_types::{ListCategories};
 
    pub fn read() -> String {
        let mut user_input:String = String::new();
        io::stdin().read_line(&mut user_input).expect("Failed to read input");
        user_input
    }

    // pub fn to_log(msg: String){
    //     println!("{}", msg);
    // }

    pub fn sleep(seconds: u64) {
        thread::sleep(time::Duration::from_millis(seconds));
    }

    pub fn append_to_file(file_path: &str, content: &str) {
        let mut file = std::fs::OpenOptions::new()
            .append(true)
            .create(true)
            .open(file_path)
            .unwrap();
        file.write_all(content.as_bytes()).unwrap();
    }

    // downloader 
    pub async fn donwload(url: String, file_name: String) -> Result<()> {
        let response = reqwest::get(url).await?;
        let mut file = std::fs::File::create(file_name)?;
        let mut content =  Cursor::new(response.bytes().await?);
        std::io::copy(&mut content, &mut file)?;
        Ok(())
    }

    pub fn get_packages(mode: PostInstallMode) {
        let path: &str = "./src/packages.json";
        let data:String = fs::read_to_string(path).expect("Error reading file");
        let res: serde_json::Value = serde_json::from_str(&data).expect("Error parsing json");

        for category in res["categories"].as_array().unwrap() {
            
        }
        
    }
}

