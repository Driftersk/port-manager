<?php

use PEAR2\Net\RouterOS;

require_once dirname(__FILE__) . "../../../../vendor/autoload.php";

$portComment = $_POST['comment'];
$portType = $_POST['portType'];

$success = false;

if($GLOBALS['logged']) {
    if(empty($_POST['portType'])) {
        echo json_encode(['success' => false, 'error' => 'Port type not supplied.']);
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
        $util->exec('/ip firewall nat set [find comment="PORTS:MAIN:' . $portComment . '"] protocol=' . $portType);
        $util->exec('/ip firewall nat set [find comment="PORTS:HAIRPIN:' . $portComment . '"] protocol=' . $portType);
    } catch(Exception $e) {
        echo json_encode(['success' => false, 'error' => 'Unable to change port type.']);
        die();
    }

    $success = true;
}
echo json_encode(['success' => $success]);
