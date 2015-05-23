<?php
/**
 * Created by PhpStorm.
 * User: r2h2
 * Date: 22.05.15
 * Time: 18:13
 */
#debug:
$_SERVER['REQUEST_METHOD'] = 'GET';

$stock_items = json_decode(file_get_contents("lagerverwaltung.json"), true);

$pinf = split('/', $_SERVER['PATH_INFO'], 4);

function json_ok($out) {
    header('Content-Type: text/json; charset=utf-8');
    echo json_encode($out);
    echo "\n";
}

function http404_notfound($msg) {
    header('HTTP/1.1 404 Not Found');
    header('Content-Type: text/html; charset=utf-8');
    #echo $pinf[0] . '|' . strtolower($pinf[1]) . '|' . $pinf[2] . ';';
    #echo $msg . "\n";
}

function http405_request_method_not_allowed() {
    header('HTTP/1.1 404 MethodNot Allowed');
    header('Content-Type: text/html; charset=utf-8');
    #echo $pinf[0] . '|' . strtolower($pinf[1]) . '|' . $pinf[2] . ';';
    #echo $msg . "\n";
}

function handle_get($stock_items, $pinf) {
    if ($pinf[1] == '') {
        json_ok($stock_items);
    } elseif (strtolower($pinf[1]) == "lautsprecher") {
        if ($pinf[2] == '') {
            json_ok($stock_items["Lautsprecher"]);
        } else {
            foreach ($stock_items["Lautsprecher"] as $part) {
                if ($part["part_no"] == $pinf[2]) {
                    json_ok($part);
                    break;
                }
                http404_notfound("part_no not found");
            }
        }
    } else {
        http404_notfound("only known key is Lautsprecher: " . $pinf[2]);
    }
}

function handle_get($stock_items, $pinf) {
    
}

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    handle_get($stock_items, $pinf);
} elseif ($_SERVER['REQUEST_METHOD'] == 'PUT') {
    handle_put($stock_items, $pinf);
} else {
    http405_request_method_not_allowed();
}


#echo $_SERVER['REQUEST_METHOD'];
?>
