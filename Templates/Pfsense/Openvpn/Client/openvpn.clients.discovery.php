<?php
require_once("/etc/inc/openvpn.inc");

$return = new stdClass();
$op =  $argv[1];

$dados = [];

foreach (openvpn_get_active_clients(true) as $status){
    $server['{#NAME}'] = $status['name'];
    if ($status['mode'] == $op) {
        
    $dados[] = $server;
    }
}

print_r(json_encode(['data' => $dados]));
?>