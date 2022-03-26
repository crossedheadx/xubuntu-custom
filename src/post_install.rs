pub mod Install {
    use cmd_lib::{run_cmd, CmdResult};
    use crate::messages::out::*;
    use crate::op_types::{PostInstallMode};

    pub fn post_install_steps(mode: PostInstallMode) -> CmdResult {
        loading();

        // enable_repos()
        Ok(())
    }

    fn enable_repos() -> CmdResult {
        let v: Vec<&str> = vec!["universe", "multiverse", "restricted"];  
        v.into_iter().for_each(|i:&str| {
            let cmd = format!("add-apt-repository -y {}", i);
            run_cmd!{ cmd };
        });
        
        Ok(())
    }
}