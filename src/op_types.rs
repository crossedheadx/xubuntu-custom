pub struct PostInstallStep {
    step: i8,
    description: String,
    fail: bool
}

pub enum PostInstallMode {
    Manual,
    Automatic
}