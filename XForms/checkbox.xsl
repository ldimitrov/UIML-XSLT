<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    version="2.0">
    
    <!-- UI -Checkboxes	-->
    <xsl:key name="checkBoxLabels" match="property[@name='label']" use="@part-name"/>
    <!-- Keys for matching ids only  -->
    <xsl:key name="checkBoxLabels" match="property[@name='label']" use="@id"/>
    <xsl:key name="Contents" match="constant" use="@id"/>
    <xsl:template match="part[@class='Checkbox']">
        <xf:select appearance="full">
            <xsl:apply-templates select="@accesskey | @tabindex | @style | @id"/>            
            <!-- Create Reference to the XForms instance -->
            <xsl:attribute name="ref">
                <xsl:choose>
                    <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:when test="@name and not(@id)">
                        <xsl:value-of select="@name"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(local-name(.), position())"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="key('checkBoxItemLabels', @id) != ''">
                    <xf:label>
                        <xsl:value-of select="key('checkBoxLabels', @id)"/>
                    </xf:label>
                </xsl:when>
                <xsl:otherwise>
                    <xf:label>
                        <xsl:value-of select="key('Contents', @id)/@label"/>
                    </xf:label>
                </xsl:otherwise>
            </xsl:choose>
            
            <xsl:apply-templates select="*"/>
        </xf:select>
    </xsl:template>
    
    <!-- Create <item> elements	-->
    <xsl:key name="checkBoxItemLabels" match="property[@name='label']" use="@part-name"/>
    <xsl:key name="checkBoxItemValues" match="property[@name='value']" use="@part-name"/>
    <!-- Keys for matching ids only  -->
    <xsl:key name="checkBoxItemLabels" match="property[@name='label']" use="@id"/>
    <xsl:key name="checkBoxItemValues" match="property[@name='value']" use="@id"/>
    <xsl:template match="part[@class='CheckboxItem']">
            <xf:item>
                <xsl:choose>
                    <xsl:when test="key('checkBoxItemLabels', @id) != ''">
                        <xf:label>
                            <xsl:value-of select="key('checkBoxItemLabels', @id)"/>
                        </xf:label>
                    </xsl:when>
                    <xsl:otherwise>
                        <xf:label>
                            <xsl:value-of select="key('Contents', @id)/@label"/>
                        </xf:label>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="key('checkBoxItemLabels', @id) != ''">
                        <xf:value>
                            <xsl:value-of select="key('checkBoxItemValues', @id)"/>
                        </xf:value>
                    </xsl:when>
                    <xsl:otherwise>
                        <xf:value>
                            <xsl:value-of select="key('Contents', @id)/@value"/>
                        </xf:value>
                    </xsl:otherwise>
                </xsl:choose>
            </xf:item>        
    </xsl:template>
</xsl:stylesheet>