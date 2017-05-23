node[:nginx][:proxies].each do |(proxy_name, proxy_attrs)|
  nginx_web_app proxy_name do
    server_name proxy_attrs[:domains].first
    template "proxy.erb"
    application proxy_attrs
  end
end
