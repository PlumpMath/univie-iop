<?php

// initialize data set

$stock_orders = array(
    "O0815" => array(
        array(
            "part_no" => "4711",
            "ord_qty" => 1,
            "backlog_qty_current" => 1,
            "backlog_qty_previous" => 1,
            "last_change" => "2015-06-23T14:02",
        ),
        array(
            "part_no" => "4713",
            "ord_qty" => 1,
            "backlog_qty_current" => 0,
            "backlog_qty_previous" => 1,
            "last_change" => "2015-06-23T14:02",
        ),
    ),
);

require_once('persistence.php');
$p = new Persistence;
$p->put_stock_orders($stock_orders);
echo "stock items initialized with test data\n";

?>