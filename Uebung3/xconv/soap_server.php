<?php
  class XConvService {
    function getXConv($currency) {
      $XConv = new StdClass;
      $XConv->convertedAmount = $currency / 1.04;
      return $XConv->convertedAmount;
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


