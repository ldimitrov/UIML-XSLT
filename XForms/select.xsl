<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    version="2.0">
    
    <xsl:key name="selectLabels" match="constant[@label]" use="@part-name"/>
    <xsl:key name="selectLabels" match="constant" use="@id"/>
    <xsl:key name="selectStyles" match="property[@name='style']" use="@part-name"/>
    <xsl:key name="selectStyles" match="property[@name='style']" use="@id"/>
    <xsl:template match="part[@class='Select'][not(@multiple)][key('selectLabels', @id)]">
        <xf:select1 appearance="minimal">
            <xsl:apply-templates select="@id"/>
            
            <!-- Create Reference to the XForms instance -->
            <xsl:attribute name="ref">
                <xsl:apply-templates select="@id"/>                
            </xsl:attribute>
            
            <xsl:attribute name="class">
                <xsl:value-of select="key('selectStyles', @id)"/>     
            </xsl:attribute>
            
            <xsl:choose>
                <xsl:when test="key('selectLabels', @id)/@label != ''">
                    <xf:label>
                        <xsl:value-of select="key('selectLabels', @id)/@label"/>
                    </xf:label>
                </xsl:when>
            </xsl:choose>

            <!-- Create <item> elements	-->            
            <xsl:apply-templates select="*"/>
        </xf:select1>
    </xsl:template>
    
    <!-- UI - Select - items -->
    <xsl:template match="part[@class='Option'][key('selectLabels', @id)]">
        <xf:item>
            <xf:label>
                <xsl:value-of select="key('selectLabels', @id)/@label"/>
            </xf:label>
            <xf:value>
                <xsl:value-of select="key('selectLabels', @id)/@value"/>
            </xf:value>
        </xf:item>
    </xsl:template>
    
</xsl:stylesheet>