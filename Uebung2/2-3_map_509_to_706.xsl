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
        <modulegroup>
            <xsl:attribute name="id"><xsl:value-of select='@id'/></xsl:attribute>
            <xsl:attribute name="name"><xsl:value-of select='./@name'/></xsl:attribute>
            <xsl:apply-templates select="module"/>
        </modulegroup>
    </xsl:template>    
    
    <xsl:template match="module">
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
            <courselanguages>
                <xsl:apply-templates select="language"/>
            </courselanguages>
            <lecturers>
                <xsl:apply-templates select="lecturer"/>
            </lecturers>
            <appointments>
                <xsl:apply-templates select="duration"/>
            </appointments>
            
        </group>
    </xsl:template>    
 
    <xsl:template match="language">
        <lang><xsl:value-of select='.'/></lang>
    </xsl:template>    
    
    <xsl:template match="lecturer">
        <lecturer>
            <xsl:attribute name="givenname"><xsl:value-of select='@firstname'/></xsl:attribute>
            <xsl:attribute name="surname"><xsl:value-of select='@lastname'/></xsl:attribute>
            <xsl:attribute name="role"><xsl:value-of select='@rolePerson'/></xsl:attribute>
        </lecturer>
    </xsl:template>    
    
    <xsl:template match="duration">
        <appointment>
            <xsl:attribute name="date"><xsl:value-of select='substring(@date, 1, 11)'/></xsl:attribute>
            <xsl:attribute name="start"><xsl:value-of select='@begin'/></xsl:attribute>
            <xsl:attribute name="end"><xsl:value-of select='@end'/></xsl:attribute>
            <xsl:attribute name="room"><xsl:value-of select='@roomNr'/></xsl:attribute>
            <xsl:attribute name="city"><xsl:value-of select='@city'/></xsl:attribute>
            <xsl:attribute name="zip"><xsl:value-of select='@zip'/></xsl:attribute>
        </appointment>
    </xsl:template>    
    
    
</xsl:stylesheet>