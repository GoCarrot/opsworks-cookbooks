# Delete our log file (gets kinda big) and restart snowflake
file "/var/log/snowflake/snowflake.log" do
  action :delete
  notifies :restart, 'service[snowflake]', :delayed
end
