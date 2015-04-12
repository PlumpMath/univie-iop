<CoursesWithLecturerSNstartingWithM>{
let $course := doc("devl/pycharm/rhoerbe/univie-iop/Uebung2/vlz_kap_706_clean.xml")//course
for $c in $course
  where $c//lecturers/lecturer/substring(@surname,1, 1) = "M"
  return <course>{$c/@title}{$c/@id}</course>
}</CoursesWithLecturerSNstartingWithM>