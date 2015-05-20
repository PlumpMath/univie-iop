cat base2_schema.ttl base2_elt_studybranch.ttl > base2_ontology.ttl
xsltproc base2_elt_study.xslt base2.xml | perl -pe 's/^\s+\:/:/; s/;\s*$/;/g' >> base2_ontology.ttl
echo '# elt_module ' >> base2_ontology.ttl
#  fehlerhafte <title> Zeilen werden eliminiert indem auf : oder # gefiltert wird
xsltproc base2_elt_module.xslt base2.xml | perl -ne 's/^\s+\:/:/; s/;\s*$/;/; print if /[#:]/' >> base2_ontology.ttl
echo '# elt_course ' >> base2_ontology.ttl
xsltproc base2_elt_course.xslt base2.xml | perl -ne 's/^\s+\:/:/; s/;\s*\n\s*\n/;\n/; print if /[#:]/' >> base2_ontology.ttl  
rapper -i turtle -o rdfxml base2_ontology.ttl > /dev/null  # validation step