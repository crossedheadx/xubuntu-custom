pub mod install {
    use std::process::Command;
    use crate::messages::out::*;
    use crate::op_types::PostInstallMode;

    pub fn post_install_steps(_mode: PostInstallMode) {
        loading();

        enable_repos();
        enable_canonical_partners();
        do_updates(Some(true));

        
    }

    fn enable_repos() {
        let v: Vec<&str> = vec!["universe", "multiverse", "restricted"];  
        let shell:&mut Command = &mut Command::new("sh");
        
        v.into_iter().for_each(|i:&str| {
            shell.arg("-c")
            .arg("apt-add-repository -y")
            .arg(i)
            .output()
            .expect("failed to execute process");
        });
    }

    fn enable_canonical_partners() {
        let v: Vec<&str> = vec!["deb http://archive.canonical.com/ubuntu $(lsb_release -cs) partner", "deb-src http://archive.canonical.com/ubuntu $(lsb_release -cs) partner"];
        
        let shell:&mut Command = &mut Command::new("sh");

        v.into_iter().for_each(|i:&str| {
            shell.arg("-c")
            .arg(format!("echo {} | sudo tee -a /etc/apt/sources.list", i))
            .spawn()
            .expect("failed to execute process");
        });
    }

    pub fn do_updates(snap: Option<bool>) {
        let shell:&mut Command = &mut Command::new("sh");
        let cmd = format!("sudo apt update && sudo apt -y full-upgrade {}", 
        if snap.unwrap_or(false) { "&& sudo snap refreshd" } else { "" });

        shell.arg("-c").arg(cmd).spawn().expect("failed to execute process");
    }
}