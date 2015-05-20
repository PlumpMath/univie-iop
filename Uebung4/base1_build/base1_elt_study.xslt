<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">   
    <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
    <xsl:strip-space elements="*" />
    
    <xsl:template match="study">
        :st<xsl:value-of select="@id"/> rdfs:comment "<xsl:value-of select="@name"/>" ;
        <xsl:for-each select="modulegroup">
    s:hasModulegroup :mg<xsl:value-of select="@id"/> ;
        </xsl:for-each>
    a s:Study .
    
    
    </xsl:template>
</xsl:stylesheet>