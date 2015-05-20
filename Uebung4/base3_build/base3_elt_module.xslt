<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
	<xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
	
	<xsl:template match="module">
        :st<xsl:value-of select="@id"/> rdfs:comment "<xsl:value-of select="title/text()"/>" ;&#10;
    a s:Module .
    </xsl:template>
</xsl:stylesheet>