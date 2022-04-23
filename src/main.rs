use operatives::op::startup;
mod operatives;
mod messages;
mod utilities;
mod op_types;
mod post_install;
mod fixes;
use nix::unistd::Uid;

// TODO: implement function for resume interrupted operation, from startup

fn main() {
    // if !Uid::effective().is_root() {
    //     panic!("You must run this executable with root permissions");
    // }
    startup();
}
