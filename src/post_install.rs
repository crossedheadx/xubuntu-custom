pub mod install {
    use cmd_lib::{run_cmd, CmdResult};
    use crate::messages::out::*;
    use crate::op_types::{PostInstallMode};


    pub async fn post_install_steps(mode: PostInstallMode) -> CmdResult {
        loading().await;

        enable_repos()?;
        enable_canonical_partners()?;
        do_updates(Some(true))?;

        Ok(())
    }

    fn enable_repos() -> CmdResult {
        let v: Vec<&str> = vec!["universe", "multiverse", "restricted"];  
        v.into_iter().for_each(|i:&str| {
            let cmd: String = format!("add-apt-repository -y {}", i);
            run_cmd!( $cmd ).unwrap();
        });
        
        Ok(())
    }

    fn enable_canonical_partners()-> CmdResult {
        let cmd1: String = format!("deb http://archive.canonical.com/ubuntu $(lsb_release -cs) partner");
        let cmd2: String = format!("deb-src http://archive.canonical.com/ubuntu $(lsb_release -cs) partner" );

        run_cmd!( echo $cmd1 | sudo tee -a /etc/apt/sources.list ).unwrap();
        run_cmd!( echo $cmd2 | sudo tee -a /etc/apt/sources.list )
    }

    pub fn do_updates(snap: Option<bool>) -> CmdResult {
        if snap.unwrap_or(true) {
            run_cmd!("sudo apt update && sudo apt -y full-upgrade && sudo snap refresh").unwrap();
        } else {
            run_cmd!("sudo apt update && sudo apt -y full-upgrade").unwrap();
        }
        Ok(())
    }
}