<?php

$GLOBALS['logged'] = false;

if($_SESSION['logged']) {
    $GLOBALS['logged'] = true;
}

// Assign user to smarty
$GLOBALS['smarty']->assign("logged", $GLOBALS['logged']);