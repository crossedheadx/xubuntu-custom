use operatives::op::startup;
mod operatives;
mod messages;
mod utilities;
pub mod types;

// TODO: implement function for resume interrupted operation, from startup

fn main() {
    startup();
}
