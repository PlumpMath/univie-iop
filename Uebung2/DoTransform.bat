@echo off

RaptorXML xslt --xslt-version=2 --input="Z:\u\IOP2015\rhoerbe\univie-iop\Uebung2\vlz_509_clean.xml" --output="Z:\u\IOP2015\rhoerbe\univie-iop\Uebung2\vlz_kap_706_clean.xml" --xml-validation-error-as-warning=true %* "MappingMapTovlz_kap_706_clean_edit.xslt"
IF ERRORLEVEL 1 EXIT/B %ERRORLEVEL%
