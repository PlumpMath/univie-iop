<?php
$contents = file_get_contents('http://wwwlab.cs.univie.ac.at/~pargm92/server.php/name');
echo ('author:' . strip_tags($contents));
?>
