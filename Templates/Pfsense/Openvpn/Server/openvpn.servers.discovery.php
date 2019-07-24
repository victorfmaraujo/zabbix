<?php
require_once("/etc/inc/openvpn.inc");

$op1 =  $argv[1];
$op2 =  $argv[2];
$op3 =  $argv[3];

$data = [];
/*

/usr/local/zabbix/bin/zabbix_get -s fwamazon.pcgeeks.com.br -p 10050 -k "openvpn.servers.discovery[server_user]"
/usr/local/zabbix/bin/zabbix_get -s fwamazon.pcgeeks.com.br -p 10050 -k "openvpn.servers.discovery[p2p_shared_key]"
/usr/local/zabbix/bin/zabbix_get -s fwamazon.pcgeeks.com.br -p 10050 -k "ovpn.users.discovery['CLIENT DISCADA UDP4:1197','user_name']"


/usr/local/zabbix/bin/zabbix_get -s fwamazon.pcgeeks.com.br -p 10050 -k "teste['list', 'server_user']"
/usr/local/zabbix/bin/zabbix_get -s fwamazon.pcgeeks.com.br -p 10050 -k "teste['list', 'p2p_shared_key']"
/usr/local/zabbix/bin/zabbix_get -s fwamazon.pcgeeks.com.br -p 10050 -k "teste['details','CLIENT DISCADA UDP4:1197','user_name']"

*/
function vpnServers ($mode) {
	foreach (openvpn_get_active_servers(true) as $status){
	    $server['{#NAME}'] = $status['name'];
	    if ($status['mode'] == $mode) {
			$data[] = $server;
	    }
	}
	return $data;
}

function serverDetails($server, $properties) {
	foreach (openvpn_get_active_servers()['name' == $server]['conns'] as $item){
		$data[]['{#USERDATA}'] = $item[$properties];
	}
	return $data;
}

switch ($op1){
	case 'list':
		$data = vpnServers($op2);
		break;
	case 'details':
		$data = serverDetails($op2, $op3);
		break;
}

print_r(json_encode(['data' => $data]));
?>
