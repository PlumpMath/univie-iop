<?php
/**
 * Created by PhpStorm.
 * User: r2h2
 * Date: 22.05.15
 * Time: 18:13
 */

//test:
$_GET['part_desc'] = 'neuer teil';
$_GET['on_stock'] = 1;
$_SERVER['REQUEST_METHOD'] = 'PUT';

$stock_items = json_decode(file_get_contents("lagerverwaltung.json"), true);

$pinf = split('/', $_SERVER['PATH_INFO'], 4);

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

function handle_get($stock_items, $pinf) {
    if ($pinf[1] == '') {
        json_ok($stock_items);
    } elseif (strtolower($pinf[1]) == "lautsprecher") {
        $prod = $stock_items["Lautsprecher"];
        if ($pinf[2] == '') {
            json_ok($prod);
        } elseif ($prod[$pinf[2]] ==! '') {
            json_ok($prod[$pinf[2]]);
        } else {
            http404_notfound("part_no not found");
        }
    } else {
        http404_notfound("only known key is Lautsprecher: " . $pinf[1]);
    }

}

function handle_put($stock_items, $pinf) {
    if (strtolower($pinf[2]) == '') {
        http404_notfound("Put need to specify a path including a part number: " . $pinf[1]);
    } elseif (strtolower($pinf[1]) != "lautsprecher") {
        http404_notfound("only known key is Lautsprecher: " . $pinf[1]);
    } elseif (strtolower($_GET['part_desc']) == '') {
        http422_unprocessable_request('missing parameter or value "part_desc=string"');
    } elseif (strtolower($_GET['on_stock']) == '') {
        http422_unprocessable_request('missing parameter or value "on_stock=integer"');
    }
    $stock_items[$pinf[1]][$pinf[2]] = array(
        "part_desc" => $_GET['part_desc'],
        "on_stock" => $_GET['on_stock'],
    );
    json_ok($stock_items);
}

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    handle_get($stock_items, $pinf);
} elseif ($_SERVER['REQUEST_METHOD'] == 'PUT') {
    handle_put($stock_items, $pinf);
} else {
    http405_request_method_not_allowed($_SERVER['REQUEST_METHOD']);
}


#echo $_SERVER['REQUEST_METHOD'];
?>
