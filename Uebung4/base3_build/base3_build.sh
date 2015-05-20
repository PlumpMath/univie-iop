cat base3_schema.ttl base3_elt_studybranch.ttl > base3_ontology.ttl
#xsltproc base3_elt_study.xslt base3_mod.xml | perl -pe 's/^\s+\:/:/; s/;\s*$/;/g' >> base3_ontology.ttl
#echo '# elt_module ' >> base3_ontology.ttl
#  fehlerhafte <title> Zeilen werden eliminiert indem auf : oder # gefiltert wird
#xsltproc base3_elt_module.xslt base3_mod.xml | perl -ne 's/^\s+\:/:/; s/;\s*$/;/' >> base3_ontology.ttl
#echo '# elt_course ' >> base3_ontology.ttl
xsltproc base3_elt_course.xslt base3_mod.xml >> base3_ontology.ttl  
rapper -i turtle -o rdfxml base3_ontology.ttl > /dev/null  # validation step