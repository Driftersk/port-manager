<?php

use PEAR2\Net\RouterOS;

require_once dirname(__FILE__) . "../../../../vendor/autoload.php";

$portComment = $_POST['comment'];

$success = false;

if($GLOBALS['logged']) {
    $ip = $GLOBALS['config']['routers']['mikrotik-DF']['ip'];
    $user = $GLOBALS['config']['routers']['mikrotik-DF']['user'];
    $pass = $GLOBALS['config']['routers']['mikrotik-DF']['password'];

    try {
        $client = new RouterOS\Client($ip, $user, $pass);
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'error' => 'Unable to connect to RouterOS.']);
        die();
    }

    try {
        $util = new RouterOS\Util($client);
        $util->exec('/ip firewall nat remove [find comment="PORTS:MAIN:' . $portComment . '"]');
        $util->exec('/ip firewall nat remove [find comment="PORTS:HAIRPIN:' . $portComment . '"]');
    } catch(Exception $e) {
        echo json_encode(['success' => false, 'error' => 'Unable to remove port.']);
        die();
    }

    $success = true;
}
echo json_encode(['success' => $success]);
