 #!/bin/bash
 echo \${var.server} > /tmp/bikkumar
 sudo apt update -y
 sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
 curl -fsSL https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
 sudo add-apt-repository "deb https://debian.neo4j.com stable 4.1"
 sudo apt install -y neo4j
 sudo systemctl enable neo4j.service
 sudo sed -i 's/#dbms.default_listen_address=0.0.0.0/dbms.default_listen_address=0.0.0.0/g' /etc/neo4j/neo4j.conf
 sudo systemctl stop neo4j.service
 sudo systemctl start neo4j.service
