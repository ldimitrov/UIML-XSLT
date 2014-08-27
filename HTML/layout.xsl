<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:xf="http://www.w3.org/2002/xforms"
    version="2.0">
    
    <!-- UIML has <layout> element with constraints - explore it in the documentation page 42; -->
    
    <!-- simple container layout by Bootstrap CSS -->
    <xsl:template match="part[@class='Container']">
        <xsl:element name="div">
            <xsl:attribute name="class">container</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
        
        <!-- RelativeLayout lets child views specify their position relative to the parent 
             view or to each other (specified by ID). So you can align two elements by right
             border, or make one below another, centered in the screen, centered left, and 
             so on.
        -->
        <!-- Add rules for:
         - to the right of
         - below
         - center vertical, center horizontal (but maybe that with css)
        -->
        
        <!-- Grid layout - would look for something like css grid -->
        <!-- Add styles for width and height of elements. 
             The idea is that elements can have these properties
             and be styled accordingly, instead of defining hard-coded
             values for positions and width, height         -->
        
    </xsl:template>
    
    <xsl:template match="part[@class='Row']">
        <xsl:element name="div">
            <xsl:attribute name="class">row</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:key name="columnStyle" match="property[@name='style']" use="@part-name"/>
    <xsl:template match="part[@class='Col']">
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:value-of select="key('columnStyle', @id)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>

