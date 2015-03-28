-- Leider kein einzelnes XML-Doc; dafür aber mit korrekter Gruppierung nach Kurs

SELECT 
    XMLSERIALIZE( 
       XMLAGG(
           XMLELEMENT(NAME "Kurs", 
               XMLATTRIBUTES(
                   k.kursnr AS "KursNr", 
                   k.titel AS "Titel"
                ),
               (SELECT XMLAGG(
                            XMLELEMENT(NAME "Angebot", 
                                XMLFOREST(a.angnr AS "AngNR", a.datum AS "Datum", a.ort AS "Ort")
                            )
                        )
                FROM angebot a
                WHERE a.kursnr = k.kursnr
               )
           )
       )
    AS CLOB INCLUDING XMLDECLARATION) "XML Output"
FROM kurs k
JOIN angebot a ON k.kursnr = a.kursnr
GROUP BY k.kursnr, k.titel;

