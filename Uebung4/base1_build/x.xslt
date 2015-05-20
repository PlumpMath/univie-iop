<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">   
    <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
    <xsl:strip-space elements="*" />
    
    <xsl:template match="appointment">
        room: <xsl:value-of select="@room"/>
        start: <xsl:value-of select="date:day-in-week(substring(@start, 1, 10))"/>
        zip: <xsl:value-of select="@zip"/>
   </xsl:template>
</xsl:stylesheet>