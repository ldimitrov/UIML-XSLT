<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- UI - HTML image tag - <img src="" alt=""/> -->  
    <xsl:key name="Contents" match="constant" use="@id"/>
    <xsl:key name="altAttribute" match="property[@name='alt']" use="@part-name"/>
    <xsl:key name="imageSource" match="property[@name='src']" use="@part-name"/>
    <xsl:key name="altAttribute_single" match="property[@alt]" use="@part-name"/>
    <xsl:key name="imageSource_single" match="property[@src]" use="@part-name"/>
    <!-- Keys for matching ids only  -->
    <xsl:key name="altAttribute" match="property[@name='alt']" use="@id"/>
    <xsl:key name="imageSource" match="property[@name='src']" use="@id"/>
    <xsl:key name="altAttribute_single" match="property[@alt]" use="@id"/>
    <xsl:key name="imageSource_single" match="property[@src]" use="@id"/>
    <xsl:template match="part[@class='Image']">
        <xsl:element name="img">
            <xsl:apply-templates select="@accesskey | @tabindex | @size | @style | @id"/>
            <xsl:attribute name="src">
                <xsl:value-of select="key('imageSource_single', @id)/@src"/>
                <xsl:value-of select="key('imageSource', @id)"/>
                <xsl:value-of select="key('Contents', @id)/@src"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:value-of select="key('altAttribute_single', @id)/@alt"/>
                <xsl:value-of select="key('altAttribute', @id)"/>
                <xsl:value-of select="key('Contents', @id)/@alt"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>