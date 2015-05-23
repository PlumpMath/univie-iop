<?php
/**
 * Created by PhpStorm.
 * User: r2h2
 * Date: 23.05.15
 * Time: 11:38
 */


$stock_items = array(
    "Lautsprecher" => array(
        "4711" => array(
            "part_desc" => "Chassis Tannoy 11 r99",
            "on_stock" => 1
        ),
        "4713" => array(
            "part_desc" => "Membran Tannoy 11 r99",
            "on_stock" => 1
        ),
        "4715" => array(
            "part_desc" => "Spule Tannoy 11 r99",
            "on_stock" => 0
        ),
        "4717" => array(
            "part_desc" => "1 Paar Anschlussstücke Tannoy 11 r99",
            "on_stock" => 10
        ),
        "4719" => array(
            "part_desc" => "Garantieerklärung",
            "on_stock" => 99999
        ),
        "4721" => array(
            "part_desc" => "Beipacktext",
            "on_stock" => 999
        ),
        "4723" => array(
            "part_desc" => "Kurzanleitung",
            "on_stock" => 99
        )
    )
);

echo json_encode($stock_items);