<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/">
        <lectureindex>
            <xsl:apply-templates select="course"/>
        </lectureindex>
    </xsl:template>    
    
    <xsl:template match="course">
        <study>
            <xsl:attribute name="id"><xsl:value-of select='@id'/></xsl:attribute>
            <xsl:attribute name="name"><xsl:value-of select='./name'/></xsl:attribute>
            <xsl:apply-templates select="moduleclass"/>
        </study>                
    </xsl:template>    
    
    <xsl:template match="moduleclass">
        <modulegroup>
            <xsl:attribute name="id"><xsl:value-of select='@id'/></xsl:attribute>
            <xsl:attribute name="name"><xsl:value-of select='./@name'/></xsl:attribute>
            <xsl:apply-templates select="modulegroup"/>
        </modulegroup>
    </xsl:template>    
    
    <xsl:template match="modulegroup">
        <module>
            <xsl:attribute name="id"><xsl:value-of select='@id'/></xsl:attribute>
            <xsl:attribute name="name"><xsl:value-of select='./@name'/></xsl:attribute>
            <xsl:apply-templates select="lecture"/>
        </module>
    </xsl:template>    
    
    <xsl:template match="lecture">
        <course>
            <xsl:attribute name="id"><xsl:value-of select='@id'/></xsl:attribute>
            <xsl:attribute name="title"><xsl:value-of select='./@title'/></xsl:attribute>
            <xsl:attribute name="ects"><xsl:value-of select='./@ects'/></xsl:attribute>
            <xsl:attribute name="continousassessment">
                <xsl:choose>
                    <xsl:when test="./@attendance='Y'">YES</xsl:when>
                    <xsl:otherwise>NO</xsl:otherwise>
                </xsl:choose> 
            </xsl:attribute>
            <xsl:attribute name="type"><xsl:value-of select='./@type'/></xsl:attribute>
            <xsl:apply-templates select="group"/>
        </course>
    </xsl:template>    
 
    <xsl:template match="group">
        <group>
            <xsl:attribute name="id"><xsl:value-of select='@id'/></xsl:attribute>
            <xsl:attribute name="signlanguage">
                <xsl:choose>
                    <xsl:when test="./@signLanguage='Y'">YES</xsl:when>
                    <xsl:otherwise>NO</xsl:otherwise>
                </xsl:choose> 
            </xsl:attribute>
            <xsl:apply-templates select="lecture"/>
            <xsl:attribute name="block">
                <xsl:choose>
                    <xsl:when test="./@block='Y'">YES</xsl:when>
                    <xsl:otherwise>NO</xsl:otherwise>
                </xsl:choose> 
            </xsl:attribute>
            <xsl:attribute name="livestream"><xsl:value-of select='@livestream'/></xsl:attribute>
            <xsl:attribute name="learningplatform"><xsl:value-of select='@platform'/></xsl:attribute>
        </group>
    </xsl:template>    
    
</xsl:stylesheet>