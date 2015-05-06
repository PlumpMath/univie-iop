#!/usr/bin/env php
<?php 
$wsdlSource = "http://univie.hoerbe.at/heimwerk/soapwork.wsdl";
$client = new SoapClient($wsdlSource, array ("trace"=>1));
$result = $client -> getHomework("6344f5cd03f75d1649a256a30ea29d23");
var_dump($result);
print_r($result);
if ($result) 
    print "$result\n";
else
    print "failed.\n"; 
?>