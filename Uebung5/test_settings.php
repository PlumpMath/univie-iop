<?php
/**
 * proved settings to test without CGI-call from command-line
 * User: r2h2
 * Date: 22.05.15
 * Time: 18:13
 */


if ($_SERVER['PATH_INFO'] == '') {
    $_GET['part_desc'] = 'neuer teil';
    $_GET['on_stock'] = 1;
    $_SERVER['REQUEST_METHOD'] = 'PUT';
    $_SERVER['PATH_INFO'] = '/Lautsprecher/4711';
}

?>