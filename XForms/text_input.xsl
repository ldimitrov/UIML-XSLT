<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:key name="bindings" match="rule" use="condition/event[@class='binding']/@part-name"/>
    <xsl:key name="textLabels" match="property[@name='label']" use="@part-name"/>
    <xsl:template match="part[@class='TextInput'][key('textLabels', @id)]">
        <xf:input>
            <xsl:apply-templates select="@size | @style"/>
            <!-- Create Reference to the XForms instance -->
            <xsl:attribute name="ref">
                <xsl:choose>
                    <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:when test="@name and not(@id)">
                        <xsl:value-of select="@name"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(local-name(.), position())"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>            
<!--            <xsl:for-each select="uiml/interface/behavior/rule/condition/event[@class='binding']">-->
                <!--<xsl:if test="uiml/interface/behavior/rule/condition/event[@class='binding']">-->
                <xsl:attribute name="bind">
                    <xsl:value-of select="key('bindings', @id)/action/property/@bind"/>
                </xsl:attribute>
            <!--</xsl:for-each>-->
            <!--</xsl:if>-->
            <!--<xsl:if test="//property[@incremential='true']">
                <xsl:attribute name="incremential">
                    <xsl:value-of select="@name"/>
                </xsl:attribute>
            </xsl:if>-->
            <xf:label>
                <xsl:value-of select="key('textLabels', @id)"/>
            </xf:label>
        </xf:input>
    </xsl:template>
    
</xsl:stylesheet>