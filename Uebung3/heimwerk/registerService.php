#!/usr/bin/env php
<?php 
$wsdlSource = "http://donatello.cs.univie.ac.at/tools_lehre/interop/2015/phase1/soapwork.wsdl";
$client = new SoapClient($wsdlSource, array ("trace"=>1));
$result = $client -> registerService(
    "a7901955", 
    "a7901955@unet.univie.ac.at",
    "6344f5cd03f75d1649a256a30ea29d23", 
    "http://univie.hoerbe.at/homework/soap_server.php");
if ($result) 
    print "done.\n";
else
    print "failed.\n"; 
?>