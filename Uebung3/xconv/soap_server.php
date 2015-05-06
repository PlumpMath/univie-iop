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
          $XConv->currency = $currency;
          $XConv->amount = $amount / 1.04;
          return array($XConv->currency, $XConv->amount);
      } else {
          return new SoapFault('100', 'Currency not supported', 'Callee', 'see list of supported currencies', 'UnsupportedCurrency');      
      }
    }

    function getAuthor() {
      return 'r2h2';
    }
  }
 
  # test helper
  if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $s = new XConvService;
    header('content-type: text/plain');
    print_r($s->getXConv('XXX'));
  }
 
  # Web service
  if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    ini_set("soap.wsdl_cache_enabled","0");
    $server = new SoapServer('xconv.wsdl');
    $server->setClass('XConvService');
    $server->handle();
    exit;
  }
?>


