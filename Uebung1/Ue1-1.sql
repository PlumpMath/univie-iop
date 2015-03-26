SELECT XMLSERIALIZE( 
           XMLELEMENT( NAME "Participant", XMLATTRIBUTES(tnnr AS "PNr"), 
                  XMLELEMENT(NAME "Name", t.name),
                  XMLELEMENT(NAME "loc", ort)
           ) 
       AS CLOB INCLUDING XMLDECLARATION) "XML Output"
FROM teilnehmer AS t