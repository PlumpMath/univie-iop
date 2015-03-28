SELECT XMLSERIALIZE(
         XMLELEMENT(NAME "Angebote", 
           XMLAGG(
               XMLELEMENT(NAME "Kursnr", 
                    XMLATTRIBUTES(a.kursnr AS "Kursnr"),
                    XMLELEMENT(NAME "Name", k.name),
                    XMLELEMENT(NAME "Ort", a.ort)
               )
           )
         )
       AS CLOB INCLUDING XMLDECLARATION)
FROM angebot a 
JOIN fuehrt_durch f ON a.kursnr = f.kursnr
JOIN kursleiter k ON k.persnr = f.persnr
