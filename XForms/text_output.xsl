<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:key name="bindings" match="rule" use="condition/event[@class='binded']/@part-name"/>
    <xsl:key name="Contents" match="constant" use="@id"/>
    <xsl:key name="textLabels" match="property[@name='label']" use="@part-name"/>
    
    <!-- Keys for matching ids only  -->
    <xsl:key name="bindings" match="rule" use="condition/event[@class='binded']/@id"/>
    <xsl:key name="textLabels" match="property[@name='label']" use="@id"/>
    <xsl:template match="part[@class='TextOutput']">
        <xf:output>
            <xsl:apply-templates select="@size | @style"/>
            <xsl:attribute name="class">row</xsl:attribute>
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
            <xsl:choose>
                <xsl:when test="key('bindings', @id)/action/property/@bind != ''">
                    <xsl:attribute name="bind">
                        <xsl:value-of select="key('bindings', @id)/action/property/@bind"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xf:label>
                <xsl:value-of select="key('textLabels', @id)"/>
                <xsl:value-of select="key('Contents', @id)/@label"/>
            </xf:label>
        </xf:output>
    </xsl:template>
    
</xsl:stylesheet>