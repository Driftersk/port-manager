<?php

use PEAR2\Net\RouterOS;

require_once dirname(__FILE__) . "../../../../vendor/autoload.php";

$success = false;

if($GLOBALS['logged']) {
    $portType = $_POST['portType'];
    $publicIp = $_POST['publicIp'];
    $publicPort = $_POST['publicPort'];
    $privateIp = $_POST['privateIp'];
    $privatePort = $_POST['privatePort'];
    $comment = $_POST['comment'];

    $ip = $GLOBALS['config']['routers']['mikrotik-DF']['ip'];
    $user = $GLOBALS['config']['routers']['mikrotik-DF']['user'];
    $pass = $GLOBALS['config']['routers']['mikrotik-DF']['password'];

    try {
        $client = new RouterOS\Client($ip, $user, $pass);
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'error' => 'Unable to connect to RouterOS.']);
        die();
    }

    // TODO: check port and comment duplicits

    try {
        $util = new RouterOS\Util($client);
        // Add MAIN rule:
        $util->exec('/ip firewall nat add chain=dstnat dst-address=' . $publicIp . ' protocol=' . $portType .
            ' dst-port=' . $publicPort . ' dst-address-type=local action=dst-nat to-addresses=' . $privateIp .
            ' to-ports=' . $privatePort . ' comment="PORTS:MAIN:' . $comment . '"');
        // Add HAIRPIN rule:
        $util->exec('/ip firewall nat add chain=srcnat src-address=192.168.0.0/24 dst-address=' . $privateIp .
            ' protocol=' . $portType . ' dst-port=' . $privatePort .
            ' out-interface=bridge-local action=masquerade comment="PORTS:HAIRPIN:' . $comment . '"');
    } catch(Exception $e) {
        echo json_encode(['success' => false, 'error' => 'Unable to add port.']);
        die();
    }

    $success = true;
}
echo json_encode(['success' => $success]);
