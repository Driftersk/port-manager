<?php

use PEAR2\Net\RouterOS;

require_once dirname(__FILE__) . "/../../vendor/autoload.php";

if(!$GLOBALS['logged']) {
    header("Location: /login");
    die();
}

$ip = $GLOBALS['config']['routers']['mikrotik-DF']['ip'];
$user = $GLOBALS['config']['routers']['mikrotik-DF']['user'];
$pass = $GLOBALS['config']['routers']['mikrotik-DF']['password'];

try {
    $client = new RouterOS\Client($ip, $user, $pass);
} catch (Exception $e) {
    echo 'Unable to connect to RouterOS.';
}

try {
    $util = new RouterOS\Util($client);
    $ports = $util->setMenu('/ip firewall nat')->getAll();
} catch(Exception $e) {
    echo "Port forwarding table cannot be retrieved.";
}

$portsFiltered = [];
foreach($ports as $port) {
    // protocol
    $protocol = $port('protocol');
    // dst-address ( public ip )
    $dst_address = $port('dst-address');
    // dst-port ( public port )
    $dst_port = $port('dst-port');
    // to-addresses
    $to_addresses = $port('to-addresses');
    $disabled = $port('disabled');
    // to-ports
    $to_ports = $port('to-ports');
    if(empty($to_ports)) {
        $to_ports = $dst_port;
    }
    // comment
    $comment = $port('comment');
    $matches = [];
    if(preg_match("/^PORTS:(.*)/", $comment, $matches)) {
        $comment = $matches[1];
        $matches = [];
        if(preg_match("/^MAIN:(.*)/", $comment, $matches)) {
            $comment = $matches[1];
        } else {
            // HAIRPIN do not show
            continue;
        }
    } else {
        // unknown format, not meant for this app
        continue;
    }

    array_push($portsFiltered, ['protocol' => $protocol,
        'dst-address' => $dst_address,
        'dst-port' => $dst_port,
        'to-addresses' => $to_addresses,
        'to-ports' => $to_ports,
        'disabled' => $disabled,
        'comment' => $comment,
        'details' => $port]);
}

$smarty->assign("ports", $portsFiltered);
$smarty->assign("root_prefix", "../");
$smarty->display("maintenance.tpl");
