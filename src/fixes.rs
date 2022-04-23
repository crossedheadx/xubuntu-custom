pub mod fixes {

    use crate::utilities::utility::append_to_file;

    pub fn usb_copy_issue_fix(){
        let dirty_background_bytes: i32 = 16*1024*1024;
        let dirty_bytes: i32 = 48*1024*1024;
        append_to_file("/proc/sys/vm/dirty_background_bytes", &dirty_background_bytes.to_string());
        append_to_file("/proc/sys/vm/dirty_bytes", &dirty_bytes.to_string());
    }
   
}