<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">   
    <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
    <xsl:strip-space elements="*" />
    
    <xsl:template match="course">
        <xsl:variable name="courseid" select="concat('c', @id)" /> 
        <xsl:variable name="c"  select="concat(':', $courseid, '&#xA;', 
                                     '    rdfs:comment &quot;', title/text(), '&quot; ;','&#xA;',
                                     '    s:continousassessment &quot;', imanent_exam/text(), '&quot; ;', '&#xA;',
                                     '    s:ECTS ', ects/text(), ' ;','&#xA;',
                                     '    s:hoursPerWeek ', week_hours/text(), ' ;','&#xA;',
                                     '    s:type &quot;', course_type/text(), '&quot; .', '&#xA;')"/>
        <xsl:value-of select="concat('&#xA; ', $c)"/>
        <xsl:for-each select="course_group">
            <xsl:variable name="groupid" select="concat('gr_', $courseid, '_', @id)" /> 
  :<xsl:value-of select="$courseid"/> s:hasGroup :<xsl:value-of select="$groupid"/> .
  :<xsl:value-of select="$groupid"/> 
    s:seqno "<xsl:value-of select="@id"/>" ;
    s:livestream "<xsl:value-of select="livestream/text()"/>" ;
    s:signlanguage "<xsl:value-of select="sign_language/text()"/>" ;
    s:lang "<xsl:value-of select="language/text()"/>" ;
    
             <xsl:for-each select="lecturer">
                <xsl:if test="role_person/text() = 'V - Verantwortlicher Leiter'">
    s:lect_responsible "<xsl:value-of select="concat(last_name/text(), ', ', first_name/text())"/>" ;
                </xsl:if>
                <xsl:if test="role_person/text() = 'P - Mitanbieter'">
    s:lect_auxiliary "<xsl:value-of select="concat(last_name/text(), ', ', first_name/text())"/>" ;
                </xsl:if>
             </xsl:for-each>
    
    s:block "<xsl:value-of select="blocked/text()"/>" .
          
             <xsl:for-each select="from_to">
                 <xsl:variable name="appointmentid" select="concat(':ap', $groupid, '_', position())"/> 
  :<xsl:value-of select="$groupid"/> s:hasAppointment <xsl:value-of select="concat($appointmentid, ' .&#xA;')"/>
  
                 <xsl:value-of select="$appointmentid"/> 
      <xsl:variable name="startdate" select="time_start/text()"/>
      <xsl:variable name="enddate" select="time_end/text()"/>
          s:start "<xsl:value-of select="$startdate"/>"^^xsd:datetime ;
          s:end "<xsl:value-of select="$enddate"/>"^^xsd:datetime ;
          s:room "<xsl:value-of select="room_number/text()"/>" ;
          s:dayinweek <xsl:value-of select="date:day-in-week(substring(time_start/text(), 1,10))"/> .
             </xsl:for-each>
             
        </xsl:for-each>

    </xsl:template>
</xsl:stylesheet>