<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xf="http://www.w3.org/2002/xforms"
    xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs"
    version="2.0">
        
    <xsl:key name="buttonLabels" match="property[@name='label']" use="@part-name"/>
    <xsl:key name="altAttribute" match="property[@name='alt']" use="@part-name"/>
    <xsl:key name="imageSource" match="property[@name='imgSource']" use="@part-name"/>
    <xsl:key name="appearanceAttribute" match="property[@name='appearance']" use="@part-name"/>
    <xsl:key name="buttonHint" match="property[@name='hint']" use="@part-name"/>
    
    <!-- Buttons which have an @id corresponding to a style/property @part-name -->  
    <xsl:template match="part[@class='ImageButton'][key('buttonLabels', @id)]">
        <xf:trigger id="{@id}">
            <xsl:attribute name="appearance">
                <xsl:value-of select="key('appearanceAttribute', @id)"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:value-of select="key('altAttribute', @id)"/>
            </xsl:attribute>
            <xsl:apply-templates select="@accesskey | @tabindex | @size | @style | @id"/>
            <xf:label>
                <xsl:value-of select="key('buttonLabels', @id)"/>
            </xf:label>
            <img>
                <xsl:attribute name="src">
                    <xsl:value-of select="key('imageSource', @id)"/>
                </xsl:attribute>
            </img>
            <xf:hint>
                <xsl:value-of select="key('buttonHint', @id)"/>
            </xf:hint>
        </xf:trigger>
    </xsl:template>
    
    <!-- Image Buttons which have a nested style/property with @name=label -->
    <xsl:template match="part[@class='ImageButton'][style/property[@name='label']]">
        <xf:trigger id="{@id}">
            <xsl:attribute name="appearance">
                <xsl:value-of select="style/property[@name='appearance']"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:value-of select="style/property[@name='alt']"/>
            </xsl:attribute>
            <xsl:apply-templates select="@accesskey | @tabindex | @size | @style | @id"/>
            <xf:label>
                <xsl:value-of select="style/property[@name='label']"/>
            </xf:label>
            <img>
                <xsl:attribute name="src">
                    <xsl:value-of select="style/property[@name='imgSource']"/>
                </xsl:attribute>
            </img>
            <xf:hint>
                <xsl:value-of select="style/property[@name='hint']"/>
            </xf:hint>
        </xf:trigger>
    </xsl:template>
    
</xsl:stylesheet>