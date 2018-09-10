pw groupmod wheel -m zabbix
mkdir /scripts
fetch -q -o https://raw.githubusercontent.com/victorfmaraujo/zabbix/master/Templates/Pfsense/Openvpn/Client/openvpn.clients.data.php
fetch -q -o https://raw.githubusercontent.com/victorfmaraujo/zabbix/master/Templates/Pfsense/Openvpn/Client/openvpn.clients.discovery.php
chmod +x /scripts/gateway.php
