<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ev="http://www.w3.org/2001/xml-events"
    exclude-result-prefixes="xs"
    xmlns:xf="http://www.w3.org/2002/xforms"
    version="2.0">
    
    <!-- UI - HTML div tag - <div/>  -->
    <xsl:template match="part[@class='div']">       
        <div>
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <!-- UI - HTML span tag - <span/>  -->
    <xsl:template match="part[@class='span']">       
        <span>
            <xsl:apply-templates/>
        </span>        
    </xsl:template>
    
    <!-- UI - HTML table tag - <table/>  -->
    <xsl:template match="part[@class='HBox']">       
        <table>
            <td>
                <xsl:apply-templates/>
            </td>
        </table>      
    </xsl:template>
    
    <!-- UI - HTML image tag - <img src="" alt=""/> -->  
    <xsl:key name="altAttribute" match="property[@name='alt']" use="@part-name"/>
    <xsl:key name="imageSource" match="property[@name='src']" use="@part-name"/>
    <xsl:key name="altAttribute_single" match="property[@alt]" use="@part-name"/>
    <xsl:key name="imageSource_single" match="property[@src]" use="@part-name"/>
    <xsl:template match="part[@class='Image']">
        <img>
            <xsl:apply-templates select="@accesskey | @tabindex | @size | @style | @id"/>
            <xsl:attribute name="src">
                <xsl:value-of select="key('imageSource_single', @id)/@src"/>
                <xsl:value-of select="key('imageSource', @id)"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:value-of select="key('altAttribute_single', @id)/@alt"/>
                <xsl:value-of select="key('altAttribute', @id)"/>
            </xsl:attribute>
        </img>
    </xsl:template>
        
    <!-- UI - HTML anchor tag - <a href=""/> -->
    <xsl:key name="anchorLink" match="property[@name='href']" use="@part-name"/>
    <xsl:key name="anchorText" match="property[@name='text']" use="@part-name"/>
    <xsl:key name="anchorLink_single" match="property[@href]" use="@part-name"/>
    <xsl:key name="anchorText_single" match="property[@text]" use="@part-name"/>
    <xsl:template match="part[@class='Anchor']">        
        <a>            
            <xsl:attribute name="href">
                <xsl:value-of select="key('anchorLink_single', @id)/@href"/>
                <xsl:value-of select="key('anchorLink', @id)"/>
            </xsl:attribute>
            <xsl:value-of select="key('anchorText', @id)"/>
            <xsl:value-of select="key('anchorText_single', @id)/@text"/>
            <xsl:apply-templates/>
        </a>        
    </xsl:template>
    
    <!-- Intention to create Tab by switching content by case statements -->
    <xsl:key name="tabLabels" match="property[@name='label']" use="@part-name"/>
    <xsl:key name="tabContents" match="property[@select='case']" use="@part-name"/>    
    <xsl:template match="part[@class='Tab']">
        <xf:trigger>
            <xsl:attribute name="appearance">minimal</xsl:attribute>
            <xf:label>
                <xsl:value-of select="key('tabLabels', @id)"/>
            </xf:label>
            <xf:toggle>
                <xsl:attribute name="case">
                    <xsl:value-of select="@id"/>   
                </xsl:attribute>
                <xsl:attribute name="ev:event">DOMActivate</xsl:attribute>
            </xf:toggle>
            <xsl:apply-templates select="*"/>
        </xf:trigger>        
    </xsl:template>
    
    <xsl:template match="part[@id='TabContent']">        
        <xf:switch>
            <xsl:for-each select=".//part[@class='Content']">
                <xf:case>
                    <xsl:attribute name="id">
                        <xsl:value-of select="key('tabContents', @id)"></xsl:value-of>
                    </xsl:attribute>
                    <div>
                        <xsl:value-of select="key('tabContents', @id)"></xsl:value-of>
                    </div>
                </xf:case>
            </xsl:for-each>
        </xf:switch>        
    </xsl:template>
    
    
</xsl:stylesheet>