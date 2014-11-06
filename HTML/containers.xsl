<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
        
    <!-- UI - HTML div tag - <div/>  -->
    <xsl:template match="part[@class='div']">
        <xsl:element name="div">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- UI - HTML span tag - <span/>  -->
    <xsl:template match="part[@class='span']">       
        <span>
            <xsl:apply-templates/>
        </span>        
    </xsl:template>
    
    <!-- UI - Vertical Layout turns into a HTML div tag - <div/>  -->
    <xsl:template match="part[@class='VerticalLayout']">
        <xsl:element name="div">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- UI - Horizontal Layout turns into a HTML span tag enclosed with a div -<div> <span/> </div>  -->
    <xsl:template match="part[@class='HorizontalLayout']">       
        <div>
            <span>
                <xsl:apply-templates/>
            </span>
        </div>
    </xsl:template>
    
</xsl:stylesheet>