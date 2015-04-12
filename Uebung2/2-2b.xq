<LecturersResponsible>{
for $lect in doc("devl/pycharm/rhoerbe/univie-iop/Uebung2/vlz_kap_706_clean.xml")//lecturer
where $lect/@role="V - Verantwortlicher Leiter"
order by $lect/@surname, $lect/@givenname
return 
  <lecturer>
    {$lect/@givenname} {$lect/@surname}
  </lecturer>
}</LecturersResponsible>