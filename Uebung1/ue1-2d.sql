 -- ohne Gruppierung nach Kurs, diese ist in 2e umgesetzt
 SELECT XMLSERIALIZE(
     CONTENT XMLELEMENT(
     NAME "Kurs", XMLATTRIBUTES(
         k.kursnr AS "KursNr", k.titel AS "Titel"
       ),
       XMLAGG(
         XMLROW(a.angnr AS "AngNR", a.datum AS "Datum", a.ort AS "Ort" OPTION ROW "Angebot")
       )
     )
     AS CLOB
   ) AS "Kursplan"
FROM kurs k
JOIN angebot a ON k.kursnr = a.kursnr
GROUP BY k.kursnr, k.titel;

