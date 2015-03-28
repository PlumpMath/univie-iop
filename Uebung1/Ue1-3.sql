CREATE TABLE teilnehmerxml (tnnr INTEGER, content XML, 
CONSTRAINT valid_check CHECK (content IS VALIDATED));

INSERT INTO teilnehmerxml VALUES (1, XMLPARSE(DOCUMENT
    '<?xml version="1.0" encoding="UTF-8"?><Teilnehmer></Teilnehmer>'));

-- Result
-- The requested operation is not allowed because a row does not satisfy the check constraint "DB2ADMIN.TEILNEHMERXML.VALID_CHECK".. SQLCODE=-545, SQLSTATE=23513, DRIVER=3.68.61

-- ohne validation funktioniert es.
-- Kommentar: Unbrauchbare Fehlermeldung, nur der letzen Fehler der Kaskade wird ausgegeben. 
-- Verstärkt den Gesamteindruck des Produkts: Schwache Usability. (wie die Linux-Installation) 
