<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    version="2.0">
    
    <xsl:key name="labelNames" match="property[@name='label']" use="@part-name"/>
    <xsl:key name="labelNames" match="property[@name='label']" use="@id"/>
    <xsl:key name="Contents" match="constant" use="@id"/>
    <xsl:template match="part[@class='Label'][key('labelNames', @id)]">
        <xsl:choose>
            <xsl:when test="key('labelNames', @id) != ''">
                <xf:label>
                    <xsl:value-of select="key('labelNames', @id)"/>
                </xf:label>
            </xsl:when>
            <xsl:otherwise>
                <xf:label>
                    <xsl:value-of select="key('Contents', @id)/@value"/>
                </xf:label>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>    
</xsl:stylesheet>