SELECT XMLSERIALIZE(
           XMLAGG(
               XMLELEMENT( NAME "Participant",
                    XMLATTRIBUTES(tnnr AS "PNr",
                                  t.name AS "Name",
                                  ort as "Loc")
               )
           )
       AS CLOB INCLUDING XMLDECLARATION)
FROM teilnehmer as t
