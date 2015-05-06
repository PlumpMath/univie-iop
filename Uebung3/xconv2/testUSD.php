#!/usr/bin/env php
<?php
$wsdlSource = "http://univie.hoerbe.at/xconv2/xconv.wsdl";
$client = new SoapClient($wsdlSource, array ("trace"=>1));
$result = $client -> getXConv("USD", 1);
#var_dump($result);
print_r($result);
?>