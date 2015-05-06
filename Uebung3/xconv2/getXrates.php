<?php
$xrates = ();

function readitem($line) {
    global $currency, $xrates;
    $l = trim($line);
    if (preg_match('/^\D/', ltrim($l))) { 
        $currency = $l;
    } elseif (preg_match('/^\d/', ltrim($l))) { 
        $xrates[$currency] = $l;
    } else {
        print "no match";
    }
}

function getCurrencies() {
    global $xrates;
    $contents = file_get_contents('http://wwwlab.cs.univie.ac.at/~pargm92/server.php/currencies');
    $stripped = strip_tags($contents);

    $xrates = array();
    $currency = '';

    $separator = "\r\n";
    $line = strtok($stripped, $separator);
    readItem($line);
    while ($line !== false) {
        $line = strtok($separator);
        readItem($line);
    }
    return ($xrates);
}
?>