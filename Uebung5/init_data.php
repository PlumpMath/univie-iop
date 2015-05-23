<?php
/**
 * Created by PhpStorm.
 * User: r2h2
 * Date: 23.05.15
 * Time: 11:38
 */


$stock_items = array(
    "Lautsprecher" => array(
        array(
            "part_no" => "4711",
            "part_desc" => "Chassis Tannoy 11 r99",
            "on_stock" => 1
        ),
        array(
            "part_no" => "4713",
            "part_desc" => "Membran Tannoy 11 r99",
            "on_stock" => 1
        ),
        array(
            "part_no" => "4715",
            "part_desc" => "Spule Tannoy 11 r99",
            "on_stock" => 0
        ),
        array(
            "part_no" => "4717",
            "part_desc" => "1 Paar Anschlussstücke Tannoy 11 r99",
            "on_stock" => 10
        ),
        array(
            "part_no" => "4719",
            "part_desc" => "Garantieerklärung",
            "on_stock" => 99999
        ),
        array(
            "part_no" => "4721",
            "part_desc" => "Beipacktext",
            "on_stock" => 999
        ),
        array(
            "part_no" => "4723",
            "part_desc" => "Kurzanleitung",
            "on_stock" => 99
        )
    )
);

echo json_encode($stock_items);