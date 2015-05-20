<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
    <xsl:strip-space elements="*" />
	
    <xsl:template match="modulegroup">
        <xsl:value-of select="concat(':mg', @id, ' rdfs:comment &quot;', @name, '&quot; ;&#xA;' )"/>
        
        <xsl:for-each select="module">
    s:hasModule :m<xsl:value-of select="@id"/> ;
        </xsl:for-each>
    a s:Modulegroup .
    
    </xsl:template>
</xsl:stylesheet>