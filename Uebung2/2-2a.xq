<Courses>{
for $course in doc("devl/pycharm/rhoerbe/univie-iop/Uebung2/vlz_kap_706_clean.xml")//course
return 
  <course>
    {$course/@title}{$course/ancestor::module[1]/@name}
      {$course//appointment}
  </course>
}</Courses>
