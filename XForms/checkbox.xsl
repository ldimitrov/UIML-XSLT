<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    version="2.0">
    
    <!-- UI -Checkboxes	-->
    <xsl:key name="checkBoxLabels" match="property[@name='label']" use="@part-name"/>
    <xsl:template match="part[@class='Checkbox'][key('checkBoxLabels', @id)]">
        <xf:select appearance="full">
            <xsl:apply-templates select="@accesskey | @tabindex | @style | @id"/>
            
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
            <xf:label>
                <xsl:value-of select="key('checkBoxLabels', @id)"/>
            </xf:label>
            <xsl:apply-templates select="*"/>
        </xf:select>
    </xsl:template>
    
    <!-- Create <item> elements	-->
    <xsl:key name="checkBoxItemLabels" match="property[@name='label']" use="@part-name"/>
    <xsl:template match="part[@class='CheckboxItem'][key('checkBoxItemLabels', @id)]">
        <xf:item>
            <xf:label>
                <xsl:value-of select="key('checkBoxItemLabels', @id)"/>
            </xf:label>
            <xf:value>
                <xsl:value-of select="@value"/>
            </xf:value>
        </xf:item>        
    </xsl:template>
</xsl:stylesheet>