<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:key name="textLabels" match="property[@name='label']" use="@part-name"/>
    <xsl:template match="part[@class='TextOutput'][key('textLabels', @id)]">
        <xf:output>
            <xsl:apply-templates select="@size | @style | @id"/>
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
            <xsl:attribute name="name">
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
            <xf:label>
                <xsl:value-of select="key('textLabels', @id)"/>
            </xf:label>
        </xf:output>
    </xsl:template>
    
</xsl:stylesheet>