<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
        
    <!-- Keys  for matching by @id or by @part-name -->
    <xsl:key name="divStyles" match="property[@name='style']" use="@part-name"/>
    <xsl:key name="divStyles" match="property[@name='style']" use="@id"/>
            
    <!-- UI - HTML div tag - <div/>  -->
    <xsl:template match="part[@class='div']">
        <xsl:element name="div">
            <xsl:choose>
                <xsl:when test="key('divStyles', @id) != ''">
                    <xsl:attribute name="class">
                        <xsl:value-of select="key('divStyles', @id)"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- UI - HTML span tag - <span/>  -->
    <xsl:template match="part[@class='span']">       
        <span>
            <xsl:apply-templates/>
            <xsl:choose>
                <xsl:when test="key('divStyles', @id) != ''">
                    <xsl:attribute name="class">
                        <xsl:value-of select="key('divStyles', @id)"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
        </span>        
    </xsl:template>
    
    <!-- UI - Vertical Layout turns into a HTML div tag - <div/>  -->
    <xsl:template match="part[@class='VerticalLayout']">
        <xsl:element name="div">
            <xsl:apply-templates/>
            <xsl:choose>
                <xsl:when test="key('divStyles', @id) != ''">
                    <xsl:attribute name="class">
                        <xsl:value-of select="key('divStyles', @id)"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <!-- UI - Horizontal Layout turns into a HTML span tag enclosed with a div -<div> <span/> </div>  -->
    <xsl:template match="part[@class='HorizontalLayout']">       
        <div>
            <xsl:choose>
                <xsl:when test="key('divStyles', @id) != ''">
                    <xsl:attribute name="class">
                        <xsl:value-of select="key('divStyles', @id)"/>
                    </xsl:attribute>
                    <span>
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
            </xsl:choose>
        </div>
    </xsl:template>
    
</xsl:stylesheet>