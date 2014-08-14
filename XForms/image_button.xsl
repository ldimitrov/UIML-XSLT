<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xf="http://www.w3.org/2002/xforms"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:key name="Contents" match="constant" use="@id"/>
    <xsl:key name="buttonLabels" match="property[@name='label']" use="@part-name"/>
    <xsl:key name="altAttribute" match="property[@name='alt']" use="@part-name"/>
    <xsl:key name="imageSource" match="property[@name='src']" use="@part-name"/>
    <xsl:key name="appearanceAttribute" match="property[@name='appearance']" use="@part-name"/>
    <xsl:key name="buttonHint" match="property[@name='hint']" use="@part-name"/>
    <!-- Parts that have all attributes in a single <property> tag -->
    <xsl:key name="buttonAttributes_single" match="property" use="@part-name"/>
    <!-- Buttons which have an @id corresponding to a style/property @part-name
         In Single property line or Multiple property lines -->  
    <xsl:template match="part[@class='ImageButton']">
        <xf:trigger id="{@id}">
            <xsl:attribute name="appearance">
                <xsl:value-of select="key('buttonAttributes_single', @id)/@appearance"/>
                <xsl:value-of select="key('appearanceAttribute', @id)"/>
            </xsl:attribute>            
            <xsl:apply-templates select="@accesskey | @tabindex | @size | @style | @id"/>
            <xf:label>
                <xsl:value-of select="key('buttonAttributes_single', @id)/@label"/>
                <xsl:value-of select="key('buttonLabels', @id)"/>
                <xsl:value-of select="key('Contents', @id)/@value"/>
            </xf:label>
            <img>
                <xsl:attribute name="src">
                    <xsl:value-of select="key('buttonAttributes_single', @id)/@src"/>
                    <xsl:value-of select="key('imageSource', @id)"/>
                    <xsl:value-of select="key('Contents', @id)/@src"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                    <xsl:value-of select="key('buttonAttributes_single', @id)/@alt"/>
                    <xsl:value-of select="key('altAttribute', @id)"/>
                    <xsl:value-of select="key('Contents', @id)/@alt"/>
                </xsl:attribute>
            </img>
            <xf:hint>
                <xsl:value-of select="key('buttonAttributes_single', @id)/@hint"/>
                <xsl:value-of select="key('buttonHint', @id)"/>
                <xsl:value-of select="key('Contents', @id)/@hint"/>
            </xf:hint>
        </xf:trigger>
    </xsl:template>
    
    <!-- Image Buttons which have a nested style/property with @name=label -->
    <xsl:template match="part[@class='ImageButton'][style/property[@name='label']]">
        <xf:trigger id="{@id}">
            <xsl:attribute name="appearance">
                <xsl:value-of select="style/property[@name='appearance']"/>
            </xsl:attribute>            
            <xsl:apply-templates select="@accesskey | @tabindex | @size | @style | @id"/>
            <xf:label>
                <xsl:value-of select="style/property[@name='label']"/>
            </xf:label>
            <img>
                <xsl:attribute name="src">
                    <xsl:value-of select="style/property[@name='src']"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                    <xsl:value-of select="style/property[@name='alt']"/>
                </xsl:attribute>
            </img>
            <xf:hint>
                <xsl:value-of select="style/property[@name='hint']"/>
            </xf:hint>
        </xf:trigger>
    </xsl:template>
    
</xsl:stylesheet>