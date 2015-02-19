bash "delete snowflake log" do
  user "root"
  cwd "/var/log/snowflake"
  code %(rm -fr snowflake.log && restart snowflake)
end
