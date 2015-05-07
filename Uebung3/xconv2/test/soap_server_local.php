<?php

class XConvService {
    function getXConv($currency, $amount) {
      $xrates = getCurrencies();
      if (array_key_exists($currency, $xrates)) {
          return array($currency, $amount / $xrates[$currency]);
      } else {
          return new SoapFault('100', 'Currency not supported', 'Callee',
              'see list of supported currencies: ' . implode(' ', $xrates),
              'UnsupportedCurrency');
      }
    }

    function getAuthor($attribute) {
      if ($attribute == 'cn') {
        return getName();
      } else {
        return 'unsupported attribute';
      }
    }
}
 
# test helper
if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $s = new XConvService;
    header('content-type: text/html');
    print_r($s->getXConv('JPY', 1));
}
 
# Web service
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    ini_set("soap.wsdl_cache_enabled","0");
    $server = new SoapServer('xconv_local.wsdl');
    $server->setClass('XConvService');
    $server->handle();
    exit;
}

# REST calls
function readitem($line) {
    global $currency, $xrates;
    $l = trim($line);
    if (preg_match('/^\D/', ltrim($l))) {
        $currency = $l;
    } elseif (preg_match('/^\d/', ltrim($l))) {
        $xrates[$currency] = $l;
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

function getName() {
    $contents = file_get_contents('http://wwwlab.cs.univie.ac.at/~pargm92/server.php/name');
    return = strip_tags($contents);
}
?>
