<CoursesNotEnglish>{
let $group := doc("devl/pycharm/rhoerbe/univie-iop/Uebung2/vlz_kap_706_clean.xml")//group
for $g in $group
  where $g//lang/text() != "Englisch"
  return <course>{$g/../@title}{$g/../@id}{$g//lang/text()}</course>
}</CoursesNotEnglish>
