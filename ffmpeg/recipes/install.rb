src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/ffmpeg.tar.gz"
remote_file src_filepath do
  source node[:ffmpeg][:url]
  checksum node[:ffmpeg][:checksum]
  backup false
end

bash "untar ffmpeg" do
  user "root"
  cwd "#{Chef::Config['file_cache_path'] || '/tmp'}"
  code %(tar -xf #{src_filepath} --strip 1)
end

bash "copy ffmpgeg root" do
  user "root"
  cwd "#{Chef::Config['file_cache_path'] || '/tmp'}"
  code %(cp ffmpeg /usr/bin/ffmpeg && cp ffprobe /usr/bin/ffprobe)
end
