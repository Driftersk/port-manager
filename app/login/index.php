<?php

require_once dirname(__FILE__) . "/../../vendor/autoload.php";

function redirectToMaintenance() {
    header("Location: /maintenance");
    die();
}

if($GLOBALS['logged']) {
    redirectToMaintenance();
}

$pass = $_POST['password'];

if(!empty($pass)) {
    if(password_verify($pass, $GLOBALS['config']['password'])) {
        $_SESSION['logged'] = true;
        redirectToMaintenance();
    }
    else {
        $smarty->assign("error", "Wrong password!");
    }
}

$smarty->assign("root_prefix", "../");
$smarty->display("login.tpl");