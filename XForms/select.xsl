<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    version="2.0">
    
    <xsl:key name="selectLabels" match="property[@name='label']" use="@part-name"/>
    <xsl:key name="selectLabels" match="property[@name='label']" use="@id"/>
    <xsl:template match="part[@class='Select'][not(@multiple)][key('selectLabels', @id)]">
        <xf:select1 appearance="minimal">
            <xsl:apply-templates select="@accesskey | @tabindex | @style | @id"/>
            
            <!-- Create Reference to the XForms instance -->
            <xsl:attribute name="ref">
                <xsl:apply-templates select="@accesskey | @tabindex | @style | @id"/>
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
                <xsl:value-of select="key('selectLabels', @id)"/>
            </xf:label>
        
            <!-- Create <item> elements	-->            
            <xsl:apply-templates select="*"/>
        </xf:select1>
    </xsl:template>
    
    <!-- UI - Select - items -->
    <xsl:template match="part[@class='Option'][key('selectLabels', @id)]">
        <xf:item>
            <xf:label>
<!--                <xsl:choose>-->
<!--                    <xsl:when test="@label">-->
                        <xsl:value-of select="key('selectLabels', @id)"/>
                    <!--</xsl:when>-->
                   <!-- <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>-->
                <!--</xsl:choose>-->
            </xf:label>
            <xf:value>
                <xsl:choose>
                    <xsl:when test="@value">
                        <xsl:value-of select="@value"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="translate(., ' ', '_')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xf:value>
        </xf:item>
    </xsl:template>
    
</xsl:stylesheet>