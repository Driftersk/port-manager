<?php

use PEAR2\Net\RouterOS;

require_once dirname(__FILE__) . "../../../../vendor/autoload.php";

$portComment = $_POST['comment'];
$port = $_POST['port'];

$success = false;

if($GLOBALS['logged']) {
    if(empty($_POST['port'])) {
        echo json_encode(['success' => false, 'error' => 'Port number not supplied.']);
        die();
    }

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
        $util->exec('/ip firewall nat set [find comment="PORTS:MAIN:' . $portComment . '"] to-ports=' . $port);
        $util->exec('/ip firewall nat set [find comment="PORTS:HAIRPIN:' . $portComment . '"] dst-port=' . $port);
    } catch(Exception $e) {
        echo json_encode(['success' => false, 'error' => 'Unable to change private port.']);
        die();
    }

    $success = true;
}
echo json_encode(['success' => $success]);
