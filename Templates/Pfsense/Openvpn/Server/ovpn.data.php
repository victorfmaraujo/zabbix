<?php
require_once("/etc/inc/globals.inc");
require_once("/etc/inc/functions.inc");
require_once("classes/autoload.inc.php");
require_once("/etc/inc/openvpn.inc");
require_once("/etc/inc/service-utils.inc");

$return = new stdClass();
$op1 =  $argv[1];
$op2 =  $argv[2];

$dados = [];

foreach (openvpn_get_active_servers(true) as $server){
    if($server['name'] == $op1) {
        $data = $server[$op2];
            if ($data == 'up') {
	            $data = 1;}
	                else{($data = 0);}
        echo $data;
    }
}
?>