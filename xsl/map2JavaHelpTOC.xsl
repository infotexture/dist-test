<?xml version="1.0" encoding="UTF-8" ?>
<!-- (c) Copyright IBM Corp. 2004, 2005 All Rights Reserved. -->

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- stylesheet imports -->
<xsl:import href="xslhtml/map2TOC.xsl"/>

<xsl:output
    method="xml"
    omit-xml-declaration="no"
    encoding="ISO-8859-1"
    doctype-public="-//Sun Microsystems Inc.//DTD JavaHelp TOC Version 1.0//EN"
    doctype-system="http://java.sun.com/products/javahelp/toc_1_0.dtd"
    indent="yes"
/>

<xsl:template match="*[contains(@class,' map/map ')]" mode="toctop">
  <toc version="1.0">
    <xsl:apply-templates select="*[contains(@class,' map/topicref ')]"/>
  </toc>
</xsl:template>

<xsl:template match="*[contains(@class,' map/topicref ')]" mode="tocentry">
  <xsl:param name="infile"/>
  <xsl:param name="outroot"/>
  <xsl:param name="outfile"/>
  <xsl:param name="nodeID"/>
  <xsl:param name="isFirst"/>
  <xsl:param name="subtopicNodes"/>
  <xsl:param name="title"/>
  <xsl:choose>
  <xsl:when test="@toc and translate(@toc, 
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')='no'">
    <xsl:variable name="results">
      <xsl:apply-templates select="$subtopicNodes"/>
    </xsl:variable>
    <xsl:text/>
  </xsl:when>
  <xsl:when test="$title">
    <tocitem text="{$title}">
      <xsl:if test="$outroot and $outroot!=''">
        <xsl:attribute name="target">
          <xsl:value-of select="translate($outroot, '\/.', '___')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="$subtopicNodes"/>
    </tocitem>
  </xsl:when>
  <xsl:otherwise>
    <xsl:apply-templates select="$subtopicNodes"/>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>