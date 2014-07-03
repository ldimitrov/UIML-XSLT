<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"    
    version="2.0">

    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jun 02, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> Lyuben Dimitrov</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:template name="stylesheet">
        <xsl:processing-instruction name="xml-stylesheet">
            <xsl:text>type="text/xsl" href="xsltforms/xsltforms.xsl"</xsl:text>
        </xsl:processing-instruction>
    </xsl:template>
    
    <!-- Not used currently -->
    <xsl:variable name="lc" select="'abcdefghijklmnopqrstuvwxyz'"/>
    <xsl:variable name="uc" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
    
    <!-- TODO: Make sure that space between the quotes is lost.... -->
    <xsl:variable name="instanceNamespace" select="' '"/>
    
    
    <!-- Process <html> root element -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Simple Calc</title>                
                <!-- Create an xforms model for each <form> elemtent -->
      
                <xf:model id="model{position()}">
                    <!-- Include XForms instance element -->
                    <!-- /TODO Currently only xf:input elements are added to instance - add all of them -->
                    <xf:instance id="formData{position()}"> 
                        <xsl:element name="data" namespace="{$instanceNamespace}"/>
                        <!-- <xsl:attribute name="{$instanceNamespace}"></xsl:attribute>-->
                        <xsl:if test="uiml/interface/structure/part[@class='TextBox']">
                            <xsl:for-each select="uiml/interface/structure/part[@class='TextBox']">
                                <xsl:element name="{@id}"/>                                    
                            </xsl:for-each>                                
                        </xsl:if>
                        <xsl:if test="uiml/interface/structure/part[@class='Select']">
                            <xsl:for-each select="uiml/interface/structure/part[@class='Select']">
                                <xsl:element name="{@id}"/>                                    
                            </xsl:for-each>                                
                        </xsl:if>
                        <xsl:if test="uiml/interface/structure/part[@class='Checkbox']">
                            <xsl:for-each select="uiml/interface/structure/part[@class='Checkbox']">
                                <xsl:element name="{@id}"/>                                    
                            </xsl:for-each>                                
                        </xsl:if>
                        <xsl:if test="uiml/interface/structure/part[@class='Radio']">
                            <xsl:for-each select="uiml/interface/structure/part[@class='Radio']">
                                <xsl:element name="{@id}"/>                                    
                            </xsl:for-each>                                
                        </xsl:if>
                    </xf:instance>
                    <!-- XForms submission -->
                    <xf:submission action="{@action}">
                        <xsl:attribute name="method">
                            <xsl:choose>
                                <xsl:when test="@method">
                                    <xsl:value-of select="@method"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>post</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:attribute name="id">
                            <xsl:choose>
                                <xsl:when test="@id">
                                    <xsl:value-of select="@id"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('s', position())"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xf:submission>
                </xf:model>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>  
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- UI - XForms button stylesheet - <xf:trigger/> -->
    <xsl:include href="XForms/button.xsl"/>
    
    <!-- UI - XForms text Input stylesheet - <xf:input/> -->
    <xsl:include href="XForms/text_input.xsl"/>
    
    <!-- UI - XForms Select stylesheet - <xf:select1/> -->
    <xsl:include href="XForms/select.xsl"/>
    
    <!-- UI - XForms Checkbox stylesheet - <xf:select/> -->
    <xsl:include href="XForms/checkbox.xsl"/>
    
    <!-- UI - XForms Radio Button stylesheet - <xf:select1/> -->
    <xsl:include href="XForms/radio.xsl"/>
    
    <!-- UI - XForms label element - <xf:label/> -->
    <xsl:include href="XForms/label.xsl"/>
    
    <!-- UI - XForms groups/fieldsets - <xf:group/> -->
    <xsl:include href="XForms/group.xsl"/>
    
    <!-- Include basic html elements -->
    <xsl:include href="HTML/html.xsl"/>
       
    <!-- Ignore <uiml>, <interface>, <structure> and <peers> tags -->
    <xsl:template match="uiml">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="interface">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="structure">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="peers"/>
    <xsl:template match="style"/>        
    <xsl:template match="behavior"/>

    <!-- Indentation and remove white spaces -->
    <xsl:strip-space elements="*"/>
<!--    <xsl:output method="xml" indent="yes"/>-->
    
   <!-- Ignore comments in the UIML File -->
    <xsl:template match="comment()"/>
            
</xsl:stylesheet>
