# univie SS2015

VO Interoperabilität
Workflow Systems and Technology Faculty of Computer Science University of Vienna
Univ. Prof. Dr. Stefanie Rinderle-Ma


1. Übung: XML und Datenbanken (9 Punkte) Aufgabe 1-1: SQL/XML – VALUES (1 Punkte)
18.03.2015
Installieren Sie die IBM DB2 Express-C Datenbank (siehe Hinweise auf der Webseite).
Verwenden Sie den Befehlseditor, um ein XML-Dokument im internen Format zu erzeugen. Das Dokument soll folgendermaßen aussehen:
Aufgabe 1-2: SQL/XML – SELECT (5 Punkte)
Laden Sie nun auf der Veranstaltungshomepage die KursDB-Datenbank herunter (createKursRel.txt). Zum Ausführen der Kommandos kann der DB2-Befehlseditor verwendet werden.
Machen Sie eine Datenbankabfrage und geben das Ergebnis in ein XML-Dokument aus. Geben Sie:
a) alle Teilnehmer mit Teilnehmer-Nr., und -Name und -Ort aus. Für jeden Teilnehmer soll ein XML- Dokument erzeugt werden.
b) wie a), aber alle Teilnehmer sollen in einem Dokument ausgegeben werden.
c) alle Angebote mit dem jeweiligen Kursleiter aus.
d) alle Kurse mit den jeweiligen Angeboten aus.
e) Wie d), aber die Ausgabe soll in einem XML-Dokument erfolgen.
Aufgabe 1-3: SQL/XML – CREATE (3 Punkte)
Erstellen Sie eine neue Tabelle „TeilnehmerXML“, die aus den zwei Feldern TnNr (Typ:Integer) und Content (Typ:XML) besteht.
Fügen Sie in einem zweiten Schritt den folgenden Datensatz in diese Tabelle ein.
Teilnehmer: Gerstner, M. aus Ulm (TnNr: 215).
Der Name und Ort des Teilnehmers wird in das Content-Feld geschrieben.


