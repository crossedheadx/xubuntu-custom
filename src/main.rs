use operatives::op::startup;
mod operatives;
mod messages;
mod utilities;
mod op_types;
mod post_install;
mod fixes;

// TODO: implement function for resume interrupted operation, from startup

fn main() {
    startup();
}
