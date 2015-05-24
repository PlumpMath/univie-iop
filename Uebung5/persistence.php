<?php
/**
 * Created by PhpStorm.
 * User: r2h2
 * Date: 23.05.15
 * Time: 19:59
 */

class Persistence {
    private $stock_items_file;

    function __construct() {
        $this->stock_items_file = "data/stock_items.json";
        $this->stock_order_file = "data/stock_orders.json";
    }

    public function get_stock_items() {
        return json_decode(file_get_contents($this->stock_items_file), true);
    }

    public function put_stock_items($stock_items) {
        file_put_contents($this->stock_items_file, json_encode($stock_items));
    }

    public function get_stock_orders() {
        return json_decode(file_get_contents($this->stock_order_file), true);
    }

    public function put_stock_orders($stock_orders) {
        file_put_contents($this->stock_order_file, json_encode($stock_orders));
    }
}
?>