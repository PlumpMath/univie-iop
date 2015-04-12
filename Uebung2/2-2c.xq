<StudyModuleCount>{
let $sb := doc("devl/pycharm/rhoerbe/univie-iop/Uebung2/vlz_kap_706_clean.xml")//studybranch
for $x in $sb
  return 
    <result studyCount="{count ($sb//study)}" moduleCount="{count($sb//module)}"></result>
}</StudyModuleCount>

