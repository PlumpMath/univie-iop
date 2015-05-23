#!/bin/bash

#Beispiel:
$0 Lautsprecher 4711 zusammengeschriebendertext Menge_Lagerstand

curl --request PUT  http://localhost/uebung5/lagerverwaltung.php/$1/$2?part_no=$3&on_stock=$4