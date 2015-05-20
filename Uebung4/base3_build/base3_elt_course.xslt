<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">   
    <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
    <xsl:strip-space elements="*" />
    
    <xsl:template match="lecture">
        <xsl:variable name="courseid" select="concat('c', @nr)" /> 
        <xsl:variable name="c"  select="concat(':', $courseid, '&#xA;', 
                                     '    rdfs:comment &quot;', @title, '&quot; ;','&#xA;',
                                     '    s:ects ', @ects, ' ;','&#xA;',
                                     '    s:type &quot;', @type, '&quot; .', '&#xA;')"/>
        <xsl:value-of select="concat('&#xA; ', $c)"/>
        <xsl:for-each select="group">
            <xsl:variable name="groupid" select="concat('gr_', $courseid, '_', @id)" /> 
  :<xsl:value-of select="$courseid"/> s:hasGroup :<xsl:value-of select="$groupid"/> .
  :<xsl:value-of select="$groupid"/> 
    s:lang "<xsl:value-of select="language/text()"/>" ;
    
             <xsl:for-each select="lecturer">
                <xsl:if test="@role = 'V - Verantwortlicher Leiter'">
    s:lect_responsible "<xsl:value-of select="concat(@last_name, ', ', @first_name)"/>" ;
                </xsl:if>
                <xsl:if test="@role = 'P - Mitanbieter'">
    s:lect_auxiliary "<xsl:value-of select="concat(@last_name, ', ', @first_name)"/>" ;
                </xsl:if>
             </xsl:for-each>
    
    s:block "<xsl:value-of select="@blocked"/>" .
          
             <xsl:for-each select="appointment">
                 <xsl:variable name="appointmentid" select="concat(':ap', $groupid, '_', position())"/> 
  :<xsl:value-of select="$groupid"/> s:hasAppointment <xsl:value-of select="concat($appointmentid, ' .&#xA;')"/>
  
                 <xsl:value-of select="$appointmentid"/> 
      <xsl:variable name="startdate" select="concat(@date, 'T', @start_time)" />
          s:start "<xsl:value-of select="$startdate"/>"^^xsd:datetime ;
          s:room "<xsl:value-of select="@street"/>" ;
          s:dayinweek <xsl:value-of select="date:day-in-week(substring($startdate, 1, 10))"/> .
             </xsl:for-each>
             
        </xsl:for-each>

    </xsl:template>
</xsl:stylesheet>