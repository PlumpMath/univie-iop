CREATE TABLE "A" (B VARCHAR(6));
INSERT INTO A VALUES ('value‘);
SELECT XMLSERIALIZE(
           XMLELEMENT (NAME "A",
               XMLELEMENT(NAME "B", A.b)
           ) AS CLOB INCLUDING XMLDECLARATION
       ) AS "XML Output"
FROM A

