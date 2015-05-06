<?php
  class HomeworkService {
    function getHomework($id) {
      $homework = new StdClass;
      $homework->name = 'Lore ipsum';
      return $homework;
    }
  }
 
  if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $s = new HomeworkService;
    header('content-type: text/plain');
    print_r($s->getHomework('a'));
  }
 
  if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    ini_set("soap.wsdl_cache_enabled","0");
    $server = new SoapServer('soapwork.wsdl');
    $server->setClass('HomeworkService');
    $server->handle();
    exit;
  }
?>


