Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

--//
#!/bin/bash
 echo \${var.server} > /tmp/bikkumar
 sudo apt update 
 sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
 curl -fsSL https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
 sudo add-apt-repository "deb https://debian.neo4j.com stable 4.1"
 sudo apt install -y neo4j
 sudo systemctl enable neo4j.service
 sudo sed -i 's/#dbms.default_listen_address=0.0.0.0/dbms.default_listen_address=0.0.0.0/g' /etc/neo4j/neo4j.conf
 sudo systemctl stop neo4j.service
 sudo systemctl start neo4j.service

