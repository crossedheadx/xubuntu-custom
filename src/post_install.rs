pub mod install {
    use std::process::Command;
    use crate::messages::out::*;
    use crate::op_types::PostInstallMode;
    use crate::fixes::fixes::usb_copy_issue_fix as fix_usb;
    use crate::utilities::utility::get_packages;

    pub fn post_install_steps(mode: PostInstallMode) {
        // loading();

        // enable_repos();
        // enable_canonical_partners();
        // do_updates(Some(true));
        // fix_usb();

        install_extra_software(mode);
        
    }

    fn enable_repos() {
        let v: Vec<&str> = vec!["universe", "multiverse", "restricted"];  
        let shell:&mut Command = &mut Command::new("sh");
        
        v.into_iter().for_each(|i:&str| {
            let cmd: String = format!("apt-add-repository -y {}", i);
            shell.arg("-c")
            .arg(cmd)
            .output()
            .expect("failed to execute process");
        });
    }

    fn enable_canonical_partners() {
        let v: Vec<&str> = vec!["deb http://archive.canonical.com/ubuntu $(lsb_release -cs) partner", "deb-src http://archive.canonical.com/ubuntu $(lsb_release -cs) partner"];
        
        let shell:&mut Command = &mut Command::new("sh");

        v.into_iter().for_each(|i:&str| {
            shell.arg("-c")
            .arg(format!("echo {} | tee -a /etc/apt/sources.list", i))
            .output()
            .expect("failed to execute process");
        });
    }

    fn install_extra_software(_mode: PostInstallMode){
        get_packages();

    }

    pub fn do_updates(snap: Option<bool>) {
        let shell:&mut Command = &mut Command::new("sh");
        let cmd = format!("apt update && apt -y full-upgrade {}", 
        if snap.unwrap_or(false) { "&& snap refresh" } else { "" });

        shell.arg("-c").arg(cmd).output().expect("failed to execute process");
    }
}