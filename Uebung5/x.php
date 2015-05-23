<?php

$stock_items = json_decode(file_get_contents("lagerverwaltung.json"));

var_dump($x);
echo "\n---\n";
var_dump($stock_items);

?>