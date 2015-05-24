<?php

function json_ok($out) {
    header('Content-Type: text/json; charset=utf-8');
    echo json_encode($out);
    echo "\n";
}

function http404_notfound($msg) {
    header("HTTP/1.1 404 $msg");
    header('Content-Type: text/html; charset=utf-8');
    //echo $pinf[0] . '|' . strtolower($pinf[1]) . '|' . $pinf[2] . ';';
    //echo $msg . "\n";
    exit();
}

function http405_request_method_not_allowed($method) {
    header('HTTP/1.1 405 Request Method $method Not Allowed');
    header('Content-Type: text/html; charset=utf-8');
    exit();
}

function http422_unprocessable_request($msg) {
    header('HTTP/1.1 422 $msg');
    header('Content-Type: text/html; charset=utf-8');
    exit();
}


?>
