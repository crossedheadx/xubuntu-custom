pub mod fixes {

    pub fn usb_copy_issue_fix(){
        let dirty_background_bytes:i32 = 16*1024*1024;
        let dirty_bytes:i32 = 48*1024*1024;
        // TODO: implement follow lines in Rust and place into flow
        // echo $((16*1024*1024)) > /proc/sys/vm/dirty_background_bytes
        // echo $((48*1024*1024)) > /proc/sys/vm/dirty_bytes
    }
}