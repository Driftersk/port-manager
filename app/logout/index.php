<?php

require_once dirname(__FILE__) . "/../../vendor/autoload.php";

if($GLOBALS['logged']) {
   $_SESSION['logged'] = false;
}

header("Location: /login");
die();