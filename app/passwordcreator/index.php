<?php

/**
 * Generates passwords for config file.
 */

$password = "test";

$options = [
    'cost' => 12,
];
require_once "../../vendor/autoload.php";

#echo password_hash($password, PASSWORD_BCRYPT, $options)."\n";
