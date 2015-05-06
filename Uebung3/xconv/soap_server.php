<?php
  class XConvService {
    function getXConv($currency, $amount) {
      $xrates = array(
          "USD" => 1.04,
          "JPY" => 93.22,
          "CNY" => 2.04,
          "CHF" => 1.08,
      );    
      if (array_key_exists($currency, $xrates)) {
          $XConv = new StdClass;
          $XConv->convertedAmount = $currency / 1.04;
          return $XConv->convertedAmount;
      } else {
          return new SoapFault('100', 'Currency not supported', 'Callee', 'see list of supported currencies', 'UnsupportedCurrency');      
      }
    }
  }
 
  if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $s = new XConvService;
    header('content-type: text/plain');
    print_r($s->getXConv('XXX'));
  }
 
  if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    ini_set("soap.wsdl_cache_enabled","0");
    $server = new SoapServer('xconv.wsdl');
    $server->setClass('XConvService');
    $server->handle();
    exit;
  }
?>


