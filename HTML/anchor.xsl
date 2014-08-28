<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
        
    <!-- UI - HTML anchor tag - <a href=""/> -->
    <xsl:key name="Contents" match="constant" use="@id"/>
    <xsl:key name="anchorLink" match="property[@name='href']" use="@part-name"/>
    <xsl:key name="anchorText" match="property[@name='label']" use="@part-name"/>
    <xsl:key name="anchorLink_single" match="property[@href]" use="@part-name"/>
    <xsl:key name="anchorText_single" match="property[@label]" use="@part-name"/>
    <!-- Keys for matching ids only  -->
    <xsl:key name="anchorLink" match="property[@name='href']" use="@id"/>
    <xsl:key name="anchorText" match="property[@name='label']" use="@id"/>
    <xsl:key name="anchorLink_single" match="property[@href]" use="@id"/>
    <xsl:key name="anchorText_single" match="property[@label]" use="@id"/>
    <xsl:template match="part[@class='Anchor']">    
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="key('anchorLink_single', @id)/@href"/>
                <xsl:value-of select="key('anchorLink', @id)"/>
                <xsl:value-of select="key('Contents', @id)/@href"/>
            </xsl:attribute>
            <xsl:value-of select="key('anchorText', @id)"/>
            <xsl:value-of select="key('anchorText_single', @id)/@label"/>
            <xsl:value-of select="key('Contents', @id)/@text"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>