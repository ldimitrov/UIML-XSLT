<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:xf="http://www.w3.org/2002/xforms"
    version="2.0">
    <xsl:template match="part[@class='RelativeLayout']">
        
        <!-- Add rules for:
         - to the left of
         - to the right of
         - below
         - maybe on top, but seems redundant
        -->
        
        <!-- Add styles for width and height of elements. 
             The idea is that elements can have these properties
             and be styled accordingly, instead of defining hard-coded
             values for positions and width, height 
        -->
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>