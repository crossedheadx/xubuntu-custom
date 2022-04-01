pub struct PostInstallStep {
    step: i8,
    description: String,
    fail: bool
}

impl PostInstallStep {
    pub fn new(step: i8, description: String, fail: bool) -> PostInstallStep {
        PostInstallStep {
            step,
            description,
            fail
        }
    }
    pub fn get_step(&self) -> i8 {
        self.step
    }
    pub fn get_description(&self) -> &String {
        &self.description
    }
    pub fn get_fail(&self) -> bool {
        self.fail
    }
    pub fn set_step(&mut self, step: i8) {
        self.step = step;
    }
    pub fn set_description(&mut self, description: String) {
        self.description = description;
    }
    pub fn set_fail(&mut self, fail: bool) {
        self.fail = fail;
    }
}

pub struct Pkg {
    name: String,
    url: String
}

pub struct Category {
    name: String,
    pkgs: Vec<Pkg>
}

pub struct ListCategories {
    categories: Vec<Category>
}

impl Pkg {
    pub fn new(name: String, url: String) -> Pkg {
        Pkg {
            name,
            url
        }
    }
    pub fn get_name(&self) -> &String {
        &self.name
    }
    pub fn get_url(&self) -> &String {
        &self.url
    }
}

impl Category {
    pub fn new(name: String, pkgs: Vec<Pkg>) -> Category {
        Category {
            name,
            pkgs
        }
    }
    pub fn get_name(&self) -> &String {
        &self.name
    }
    pub fn get_pkgs(&self) -> &Vec<Pkg> {
        &self.pkgs
    }
}
pub enum PostInstallMode {
    Manual,
    Automatic
}

impl ListCategories {
    pub fn new(categories: Vec<Category>) -> ListCategories {
        ListCategories {
            categories
        }
    }
    pub fn get_categories(&self) -> &Vec<Category> {
        &self.categories
    }
}
