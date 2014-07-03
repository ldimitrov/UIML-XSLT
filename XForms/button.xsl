<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    xmlns:ev="http://www.w3.org/2001/xml-events"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- UI - Button -->
    <xsl:key name="buttonLabels" match="property[@name='label']" use="@part-name"/>
    <xsl:key name="buttonActions" match="action/property[@name='text']" use="@part-name"/>
    <!-- All <part> elements that do not match the other two templates -->
    <xsl:template match="part"/>
    
    <!-- Buttons which have an @id corresponding to a style/property @part-name -->    
    <xsl:template match="part[@class='Button'][key('buttonLabels', @id)][key('buttonActions', @id)]">
        <xf:trigger id="{@id}">
            <xsl:apply-templates select="@accesskey | @tabindex | @size | @style | @id"/>
            <xf:label>
                <xsl:value-of select="key('buttonLabels', @id)"/>
            </xf:label>
            <xsl:apply-templates select="key('buttonActions', @id)"/>
        </xf:trigger>
    </xsl:template>
    
    <!-- Buttons which have a nested style/property with @name=label -->
    <xsl:template match="part[@class='Button'][style/property[@name='label']]">
        <xf:trigger id="{@id}">
            <xsl:apply-templates select="@accesskey | @tabindex | @size | @style | @id"/>
            <xf:label>
                <xsl:value-of select="style/property[@name='label']"/>
            </xf:label>
            <xsl:apply-templates select="key('buttonActions', @id)"/>
        </xf:trigger>
    </xsl:template>
    
    <xsl:template match="action/property">
        <xf:action ev:event="DOMActivate">
            <!--<xsl:choose>
                <xsl:when test="action/property/call[@name='onClick']">    -->                
            <xf:message>
                <xsl:value-of select="call/param/property[@name='label'][key('buttonLabels', @id)]"></xsl:value-of>
                <!--<xsl:attribute name="value">                            
                            <xsl:value-of select="key('buttonLabels', @id)"/>                                
                        </xsl:attribute>-->
                <!--                        <xsl:apply-templates select="key('buttonActions', @id)"/>-->
            </xf:message>                    
            <!--</xsl:when>
                   
                    
            </xsl:choose>-->
            
        </xf:action>        
    </xsl:template>    
    
    
</xsl:stylesheet>