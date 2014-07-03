<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    version="2.0">
    
    <xsl:template match="part[@class='Group']">
        <xf:group>
            <xsl:apply-templates/>
        </xf:group>
    </xsl:template>
    
</xsl:stylesheet>