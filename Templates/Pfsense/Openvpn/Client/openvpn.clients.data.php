<?php
require_once("/etc/inc/openvpn.inc");
$op1 =  $argv[1];
$op2 =  $argv[2];

$dados = [];

foreach (openvpn_get_active_clients(true) as $server){
    if($server['name'] == $op1) {
        $data = $server[$op2];
            if ($data == 'down') {
	            $data = 0;}
	        elseif ($data == 'waiting') {
                    $data = 1;}
            elseif ($data == 'reconnecting; ping-restart') {
            		$data = 2;}
            elseif ($data == 'up') {
                    $data = 3;}                        
            else {$data = $server[$op2];}
    }
        echo $data;
$data = null;
}
?>