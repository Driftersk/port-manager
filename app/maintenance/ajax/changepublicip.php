<?php

use PEAR2\Net\RouterOS;

require_once dirname(__FILE__) . "../../../../vendor/autoload.php";

$portComment = $_POST['comment'];
$publicIp = $_POST['ip'];

$success = false;

if($GLOBALS['logged']) {
    if(empty($_POST['ip'])) {
        echo json_encode(['success' => false, 'error' => 'Ip not supplied.']);
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

    // todo: validate ip

    try {
        $util = new RouterOS\Util($client);
        $util->exec('/ip firewall nat set [find comment="PORTS:MAIN:' . $portComment . '"] dst-address="' . $publicIp . '"');
    } catch(Exception $e) {
        echo json_encode(['success' => false, 'error' => 'Unable to change public ip.']);
        die();
    }

    $success = true;
}
echo json_encode(['success' => $success]);
