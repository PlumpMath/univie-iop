<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">   
    <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
    <xsl:strip-space elements="*" />
    
    <xsl:template match="course">
        <xsl:value-of select="concat(':c', @id, '&#xA;', 
                                     '    dc:subject &quot;', @title, '&quot; ;','&#xA;',
                                     '    s:continousassessment &quot;', @continousassessment, '&quot; ;', '&#xA;',
                                     '    s:ects ', @ects, ' ;','&#xA;',
                                     '    s:hoursPerWeek ', @hoursPerWeek, ' ;','&#xA;',
                                     '    s:type &quot;', @type, '&quot; .', '&#xA;')"/>
        <xsl:variable name="courseid" select="concat('c', @id)" /> 
        <xsl:for-each select="group">
            <xsl:variable name="groupid" select="concat('gr_', $courseid, '_', @id)" /> 
  :<xsl:value-of select="$courseid"/> s:hasGroup :<xsl:value-of select="$groupid"/> .
  :<xsl:value-of select="$groupid"/> 
    s:seqno "<xsl:value-of select="@id"/>" ;
    s:learningplatform "<xsl:value-of select="@learningplatform"/>" ;
    s:learningplatformurl "<xsl:value-of select="@learningplatformurl"/>" ;
    s:livestream "<xsl:value-of select="@livestream"/>" ;
    s:signlanguage "<xsl:value-of select="@signlanguage"/>" ;
             <xsl:for-each select="courselanguages/lang">
    s:lang "<xsl:value-of select="current()"/>" ;
             </xsl:for-each>
        
             <xsl:for-each select="lecturers/lecturer">
                <xsl:if test="@role = 'V - Verantwortlicher Leiter'">
    s:lect_responsible "<xsl:value-of select="concat(@surname, ', ', @givenname)"/>" ;
                </xsl:if>
                <xsl:if test="@role = 'P - Mitanbieter'">
    s:lect_auxiliary "<xsl:value-of select="concat(@surname, ', ', @givenname)"/>" ;
                </xsl:if>
             </xsl:for-each>
    s:block "<xsl:value-of select="@block"/>" .
          
             <xsl:for-each select="appointments/appointment">
                 <xsl:variable name="appointmentid" select="concat(':ap', $groupid, '_', position())"/>
  :<xsl:value-of select="$groupid"/> s:hasAppointment <xsl:value-of select="concat($appointmentid, ' .&#xA;')"/>
  
  <xsl:value-of select="$appointmentid"/> 
    s:start "<xsl:value-of select="@start"/>"^^xsd:datetime ;
    s:end "<xsl:value-of select="@end"/>"^^xsd:datetime ;
    s:room "<xsl:value-of select="@room"/>" .
             </xsl:for-each>
             
        </xsl:for-each>

    </xsl:template>
</xsl:stylesheet>