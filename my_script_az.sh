#!/bin/bash

HOST=saltdemo.sytes.net
S1=/usr/local/bin/startup_script.sh

sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo dnf install -y vim unzip wget python3 python3-pip
pip3 install noipy
noipy --store -u gilesdj@gmail.com -p Snoopy*13 -n $HOST --provider noip

cat >$S1 <<EOL
#!/bin/bash
noipy -n $HOST --provider noip
EOL

chmod u+x $S1

cat >/etc/systemd/system/run-at-startup.service <<EOL
[Unit]
Description=Run script at startup after all systemd services are loaded
After=network.target

[Service]
Type=simple
User=root
RemainAfterExit=yes
ExecStart=$S1
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOL

chmod 664 /etc/systemd/system/run-at-startup.service
systemctl daemon-reload
systemctl enable run-at-startup.service
systemctl start run-at-startup.service
