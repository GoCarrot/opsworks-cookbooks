bash "delete nginx logs" do
  user "root"
  cwd "/var/log/nginx"
  code %(rm -f * && /etc/init.d/nginx reopen_logs)
end
