<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xf="http://www.w3.org/2002/xforms"
    exclude-result-prefixes="xs"
    version="2.0">
        
    <xsl:key name="Contents" match="constant" use="@id"/>
    <xsl:key name="bindings" match="rule" use="condition/event[@class='binding']/@part-name"/>
    <!-- UI - Date Picker -->
    <xsl:key name="inputStyles" match="property[@name='style']" use="@part-name"/>
    <xsl:key name="inputLabels" match="property[@name='label']" use="@part-name"/>
    <xsl:key name="inputHint" match="property[@name='hint']" use="@part-name"/>
    <xsl:key name="inputLabels_single" match="property[@label]" use="@part-name"/>
    <xsl:key name="inputHint_single" match="property[@hint]" use="@part-name"/>
    <!-- Keys for matching ids only  -->
    <xsl:key name="bindings" match="rule" use="condition/event[@class='binding']/@id"/>
    <xsl:key name="inputStyles" match="property[@name='style']" use="@id"/>
    <xsl:key name="inputLabels" match="property[@name='label']" use="@id"/>
    <xsl:key name="inputHint" match="property[@name='hint']" use="@id"/>
    <xsl:key name="inputLabels_single" match="property[@label]" use="@id"/>
    <xsl:key name="inputHint_single" match="property[@hint]" use="@id"/>
    <!-- Date Pickers which have an @id corresponding to a style/property @part-name -->    
    <xsl:template match="part[@class='DatePicker']">
        <xsl:element name="xf:input">
            <xsl:choose>
                <xsl:when test="key('inputStyles', @id) != ''">
                    <xsl:attribute name="class">
                        <xsl:value-of select="key('inputStyles', @id)"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
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
            <!--<xsl:choose>
                <xsl:when test="key('bindings', @id)/action/property/@bind != ''">
                    <xsl:attribute name="bind">
                        <xsl:value-of select="key('bindings', @id)/action/property/@bind"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>-->
            
            <xsl:attribute name="id">
                <xsl:value-of select="@id | @size | @style"/>
            </xsl:attribute>            
            <xsl:choose>
                <xsl:when test="key('inputLabels', @id) != ''">
                    <xsl:element name="xf:label">
                        <xsl:value-of select="key('inputLabels', @id)"/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="key('inputLabels_single', @id)/@label != ''">
                    <xsl:element name="xf:label">                     
                        <xsl:value-of select="key('inputLabels_single', @id)/@label"/>                   
                    </xsl:element>
                </xsl:when>
                <xsl:when test="key('Contents', @id)/@label != ''">
                    <xsl:element name="xf:label">                        
                        <xsl:value-of select="key('Contents', @id)/@label"/>                     
                    </xsl:element>                    
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="key('inputHint', @id) != ''">
                    <xsl:element name="xf:hint">
                        <xsl:value-of select="key('inputHint', @id)"></xsl:value-of>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="key('inputHint_single', @id)/@hint != ''">
                    <xsl:element name="xf:hint">                        
                        <xsl:value-of select="key('inputHint_single', @id)/@hint"/>                        
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
    
    <!-- Date Pickers which have a nested style/property with @name=label -->
    <xsl:template match="part[@class='DatePicker'][style/property[@name='label']]">
        <xf:input id="{@id}">
            <xsl:apply-templates select="@accesskey | @tabindex | @size | @style | @id"/>
            <xf:label>
                <xsl:value-of select="style/property[@name='label']"/>
            </xf:label>
            <xf:hint>
                <xsl:value-of select="key('inputHint', @id)"></xsl:value-of>
            </xf:hint>
        </xf:input>
    </xsl:template>
</xsl:stylesheet>