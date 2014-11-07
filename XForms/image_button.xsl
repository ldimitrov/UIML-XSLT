<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xf="http://www.w3.org/2002/xforms"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:key name="Contents" match="constant" use="@id"/>
    <xsl:key name="buttonStyles" match="property[@name='style']" use="@part-name"/>
    <xsl:key name="buttonLabels" match="property[@name='label']" use="@part-name"/>
    <xsl:key name="altAttribute" match="property[@name='alt']" use="@part-name"/>
    <xsl:key name="imageSource" match="property[@name='src']" use="@part-name"/>
    <xsl:key name="appearanceAttribute" match="property[@name='appearance']" use="@part-name"/>
    <xsl:key name="buttonHint" match="property[@name='hint']" use="@part-name"/>
    <!-- Parts that have all attributes in a single <property> tag -->
    <xsl:key name="buttonAttributes_single" match="property" use="@part-name"/>
    <!-- Keys for matching ids only  -->
    <xsl:key name="buttonStyles" match="property[@name='style']" use="@id"/>
    <xsl:key name="buttonLabels" match="property[@name='label']" use="@id"/>
    <xsl:key name="altAttribute" match="property[@name='alt']" use="@id"/>
    <xsl:key name="imageSource" match="property[@name='src']" use="@id"/>
    <xsl:key name="appearanceAttribute" match="property[@name='appearance']" use="@id"/>
    <xsl:key name="buttonHint" match="property[@name='hint']" use="@id"/>
    <xsl:key name="buttonAttributes_single" match="property" use="@id"/>
    <!-- Buttons which have an @id corresponding to a style/property @part-name
         In Single property line or Multiple property lines -->  
    <xsl:template match="part[@class='ImageButton']">
        <xf:trigger id="{@id}">
            <xsl:choose>
                <xsl:when test="key('buttonStyles', @id) != ''">
                    <xsl:attribute name="class">
                        <xsl:value-of select="key('buttonStyles', @id)"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="key('buttonAttributes_single', @id)/@appearance != ''">
                    <xsl:attribute name="appearance">
                        <xsl:value-of select="key('buttonAttributes_single', @id)/@appearance"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="key('appearanceAttribute', @id) != ''">
                    <xsl:attribute name="appearance">                   
                        <xsl:value-of select="key('appearanceAttribute', @id)"/>
                    </xsl:attribute>
                </xsl:when>                
            </xsl:choose>
            <xsl:apply-templates select="@id"/>
            
            <xsl:choose>
                <xsl:when test="key('buttonAttributes_single', @id)/@label != ''">
                    <xsl:element name="xf:label">
                        <xsl:value-of select="key('buttonAttributes_single', @id)/@label"/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="key('buttonLabels', @id) != ''">
                    <xsl:element name="xf:label">
                        <xsl:value-of select="key('buttonLabels', @id)"/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="key('Contents', @id)/@label != ''">
                    <xsl:element name="xf:label">
                        <xsl:value-of select="key('Contents', @id)/@label"/>
                    </xsl:element>
                </xsl:when>
            </xsl:choose>
            
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
            
            <xsl:choose>
                <xsl:when test="key('buttonAttributes_single', @id)/@hint != ''">
                    <xsl:element name="xf:hint">
                        <xsl:value-of select="key('buttonAttributes_single', @id)/@hint"/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="key('buttonHint', @id) != ''">
                    <xsl:element name="xf:hint">
                        <xsl:value-of select="key('buttonHint', @id)"/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="key('Contents', @id)/@hint != ''">
                    <xsl:element name="xf:hint">
                        <xsl:value-of select="key('Contents', @id)/@hint"/>
                    </xsl:element>
                </xsl:when>
            </xsl:choose>
            
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