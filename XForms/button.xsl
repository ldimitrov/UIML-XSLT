<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    xmlns:ev="http://www.w3.org/2001/xml-events"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:key name="buttonStyles" match="property[@name='style']" use="@part-name"/>
    <xsl:key name="Contents" match="constant" use="@id"/>
    <!-- UI - Button -->
    <xsl:key name="buttonLabels" match="property[@name='label']" use="@part-name"/>
    <xsl:key name="buttonHint" match="property[@name='hint']" use="@part-name"/>
    <xsl:key name="buttonLabels_single" match="property[@label]" use="@part-name"/>
    <xsl:key name="buttonHint_single" match="property[@hint]" use="@part-name"/>
    
    <!-- Keys for matching ids only  -->
    <xsl:key name="buttonStyles" match="property[@name='style']" use="@id"/>
    <xsl:key name="buttonLabels" match="property[@name='label']" use="@id"/>
    <xsl:key name="buttonHint" match="property[@name='hint']" use="@id"/>
    <xsl:key name="buttonLabels_single" match="property[@label]" use="@id"/>
    <xsl:key name="buttonHint_single" match="property[@hint]" use="@id"/>
 
    <!-- Buttons which have an @id corresponding to a style/property @part-name -->    
    <xsl:template match="part[@class='Button']">
        <xsl:element name="xf:trigger">
            <xsl:choose>
                <xsl:when test="key('buttonStyles', @id) != ''">
                    <xsl:attribute name="class">
                        <xsl:value-of select="key('buttonStyles', @id)"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            
            <xsl:attribute name="id">
                <xsl:value-of select="@id | @size | @style"/>
            </xsl:attribute>            
                <xsl:choose>
                    <xsl:when test="key('buttonLabels', @id) != ''">
                        <xsl:element name="xf:label">
                            <xsl:value-of select="key('buttonLabels', @id)"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="key('buttonLabels_single', @id)/@label != ''">
                        <xsl:element name="xf:label">                     
                            <xsl:value-of select="key('buttonLabels_single', @id)/@label"/>                   
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="key('Contents', @id)/@label != ''">
                        <xsl:element name="xf:label">                        
                            <xsl:value-of select="key('Contents', @id)/@label"/>                     
                        </xsl:element>                    
                    </xsl:when>
                </xsl:choose>
            <xsl:choose>
                <xsl:when test="key('buttonHint', @id) != ''">
                    <xsl:element name="xf:hint">
                        <xsl:value-of select="key('buttonHint', @id)"></xsl:value-of>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="key('buttonHint_single', @id)/@hint != ''">
                    <xsl:element name="xf:hint">                        
                        <xsl:value-of select="key('buttonHint_single', @id)/@hint"/>                        
                    </xsl:element>
                </xsl:when>
                <xsl:when test="key('Contents', @id)/@hint != ''">
                    <xsl:element name="xf:hint">                        
                        <xsl:value-of select="key('Contents', @id)/@hint"/>                       
                    </xsl:element>                    
                </xsl:when>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <!-- Buttons which have a nested style/property with @name=label -->
    <xsl:template match="part[@class='Button'][style/property[@name='label']]">
        <xf:trigger id="{@id}">
            <xsl:apply-templates select="@accesskey | @tabindex | @size | @style | @id"/>
            <xf:label>
                <xsl:value-of select="style/property[@name='label']"/>
            </xf:label>
            <xf:hint>
                <xsl:value-of select="key('buttonHint', @id)"></xsl:value-of>
            </xf:hint>
<!--            <xsl:apply-templates select="key('buttonActions', @id)"/>-->
        </xf:trigger>
    </xsl:template>

</xsl:stylesheet>