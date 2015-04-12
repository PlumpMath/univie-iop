<CoursesStartingBeforeNoon>{
let $course := doc("devl/pycharm/rhoerbe/univie-iop/Uebung2/vlz_kap_706_clean.xml")//course
for $c in $course
  where $c//appointment/@start < 1200
  return <course>{$c/@title}{$c/@id}</course>
}</CoursesStartingBeforeNoon>
