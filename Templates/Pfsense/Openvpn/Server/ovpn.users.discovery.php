<?php
require_once("/etc/inc/openvpn.inc");

$op1 =  $argv[1];
$op2 =  $argv[2];

$dados = [];
foreach (openvpn_get_active_servers()['name' == $op1]['conns'] as $data){
	$dados[]['{#USERDATA}'] = $data[$op2];
}

print_r(json_encode(['data' => $dados]));
?>