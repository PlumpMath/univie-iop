<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
	<xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
	
	<xsl:template match="module">
        <xsl:value-of select="concat(':m', @id, ' rdfs:comment &quot;', @name, '&quot; ;&#xA;' )"/>
            <xsl:for-each select="course">
    s:hasCourse :c<xsl:value-of select="@id"/> ;
            </xsl:for-each>
    a s:Module .
    
    
    </xsl:template>
</xsl:stylesheet>