<?php
/**
 * Created by PhpStorm.
 * User: erik
 * Date: 7. 3. 2016
 * Time: 17:38
 */

ini_set("display_errors", "on");
error_reporting(E_ALL ^ E_NOTICE);

session_start();

$GLOBALS['smarty'] = new Smarty();

$GLOBALS['smarty']->setTemplateDir(dirname(__FILE__) . "/../templates");
$GLOBALS['smarty']->setCompileDir(dirname(__FILE__) .  "/../templates_compiled");
