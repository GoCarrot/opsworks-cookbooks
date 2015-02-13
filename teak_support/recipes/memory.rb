cron "Teak - Flush dentry/inode cache" do
  minute "0"
  command "echo 2 > /proc/sys/vm/drop_caches"
end
