#!/bin/bash
install -d /opt/Bento4
cp -r /root/source/Bento4/Build/Targets/x86_64-unknown-linux/Release/* /opt/Bento4/
cp -r /root/source/Bento4/Source/Python /opt/Bento4/
for i in aac2mp4 avcinfo mp42aac mp42avc mp42hevc mp42hls mp42ts mp4compact mp4dcfpackager mp4decrypt mp4dump mp4edit mp4encrypt mp4extract mp4fragment mp4info mp4mux mp4split mp4tag ; do
  ln -s /opt/Bento4/$i /usr/local/bin/$i
done

cat > /usr/local/bin/mp4dash <<EOL
#!/bin/bash
exec python /opt/Bento4/Python/utils/mp4-dash.py
EOL
chmod +x /usr/local/bin/mp4dash

cat > /usr/local/bin/mp4hls <<EOL
#!/bin/bash
exec python /opt/Bento4/Python/utils/mp4-hls.py
EOL
chmod +x /usr/local/bin/mp4hls
