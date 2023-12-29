<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common" xmlns:func="http://exslt.org/functions"
    xmlns:str="http://exslt.org/strings" xmlns:date="http://exslt.org/dates-and-times"
    xmlns:regexp="http://exslt.org/regular-expressions"
    extension-element-prefixes="str exsl func date regexp"
    exclude-result-prefixes="exsl func str date regexp" xmlns:srw="http://www.loc.gov/zing/srw/"
    xmlns:mods="http://www.loc.gov/mods/v3" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:srw_dc="info:srw/schema/1/dc-v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:dcterms="http://purl.org/dc/terms/" xmlns:mets="http://www.loc.gov/METS/"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:ead="urn:isbn:1-931666-22-9">
    <xsl:output encoding="UTF-8" method="xml" indent="yes" omit-xml-declaration="no"/>
    <!-- identifier part of institution -->
    <xsl:param name="institution">hstad_</xsl:param>
    <xsl:template match="/">
        <xsl:element name="mets:mets">
            <xsl:namespace name="xsi" select="'http://www.w3.org/2001/XMLSchema-instance'"/>
            <xsl:namespace name="mets" select="'http://www.loc.gov/METS/'"/>
            <xsl:namespace name="mods" select="'http://www.loc.gov/mods/v3'"/>
            <xsl:attribute name="xsi:schemaLocation">http://www.loc.gov/METS/
                http://www.loc.gov/standards/mets/version18/mets.xsd</xsl:attribute>
            <xsl:element name="mets:metsHdr">
                <xsl:element name="mets:agent">
                    <xsl:attribute name="ROLE">CREATOR</xsl:attribute>
                    <xsl:element name="mets:name">ArchivDarmstadt-Skript Knepper 07/2021</xsl:element>
                </xsl:element>
            </xsl:element>
            <xsl:message>
                <xsl:text>Processing </xsl:text>
                <xsl:value-of select="base-uri()"/>
            </xsl:message>
            <xsl:for-each select="//ead:c[@level = 'file']">
                <xsl:element name="mets:dmdSec">
                    <xsl:attribute name="ID" select="concat('md-archivdarmstadt-', @id)"/>
                    <xsl:element name="mets:mdWrap">
                        <xsl:attribute name="MIMETYPE">text/xml</xsl:attribute>
                        <xsl:attribute name="MDTYPE">MODS</xsl:attribute>
                        <xsl:element name="mets:xmlData">
                            <xsl:element name="mods:mods">
                                <xsl:element name="mods:recordInfo">
                                    <xsl:element name="mods:recordIdentifier">
                                        <xsl:value-of select="$institution"/>
                                        <xsl:value-of
                                            select="lower-case(translate(//ead:dsc/ead:c/ead:did/ead:unitid[not(@type)],' ','_'))"/>
                                        <xsl:text>_nr_</xsl:text>
                                        <xsl:value-of select="replace(ead:did/ead:unitid[not(@type)],'/','--')"/>
                                    </xsl:element>
                                </xsl:element>
                                <xsl:element name="mods:titleInfo">
                                    <xsl:element name="mods:title">
                                        <xsl:value-of
                                            select="normalize-space(string-join(ead:did/ead:unittitle, ' '))"
                                        />
                                    </xsl:element>
                                </xsl:element>
                                <xsl:element name="mods:abstract">
                                    <xsl:attribute name="type">partial contents</xsl:attribute>
                                    <xsl:attribute name=" displayLabel">Enthält</xsl:attribute>
                                    <xsl:value-of
                                        select="normalize-space(string-join(ead:did/ead:abstract, '; '))"
                                    />
                                </xsl:element>
                                <xsl:element name="mods:typeOfResource">
                                    <xsl:text>text</xsl:text>
                                </xsl:element>
                                <xsl:element name="mods:location">
                                    <xsl:element name="mods:physicalLocation">Hessisches Staatsarchiv Darmstadt</xsl:element>
                                    <xsl:element name="mods:physicalLocation"><xsl:attribute name="authority" select="'marcorg'"/>DE-2556</xsl:element>
                                    <xsl:element name="mods:shelfLocator">
                                        <xsl:value-of
                                            select="//ead:dsc/ead:c/ead:did/ead:unitid[not(@type)]"/>
                                        <xsl:text> Nr. </xsl:text>
                                        <xsl:value-of select="ead:did/ead:unitid[not(@type)]"/>
                                    </xsl:element>
                                </xsl:element>
                                <xsl:for-each select="ead:otherfindaid/ead:extref">
                                    <xsl:element name="mods:location">
                                        <xsl:element name="mods:url">
                                            <xsl:attribute name="displayLabel"
                                                select="normalize-space(.)"/>
                                            <xsl:value-of select="./@xlink:href"/>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:for-each>
                                <xsl:for-each select="ead:index/ead:indexentry/ead:geogname/text()">
                                    <xsl:element name="mods:subject">
                                        <xsl:element name="mods:geographic">
                                            <xsl:value-of select="normalize-space(.)"/>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:for-each>
                                <xsl:for-each select="ead:index/ead:indexentry/ead:subject/text()">
                                    <xsl:element name="mods:subject">
                                        <xsl:element name="mods:topic">
                                            <xsl:value-of select="normalize-space(.)"/>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:for-each>
                                <xsl:for-each select="ead:index/ead:indexentry/ead:persname/text()">
                                    <xsl:element name="mods:subject">
                                        <xsl:element name="mods:name">
                                            <xsl:attribute name="type" select="'personal'"/>
                                            <xsl:element name="namePart">
                                                <xsl:value-of select="normalize-space(.)"/>
                                            </xsl:element>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:for-each>
                                <xsl:for-each select="ead:odd/ead:p/text()">
                                    <xsl:element name="mods:subject">
                                        <xsl:element name="mods:topic">
                                            <xsl:value-of select="normalize-space(.)"/>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:for-each>
                                <xsl:element name="mods:originInfo">
                                    <xsl:choose>
                                        <xsl:when test="ead:did/ead:unitdate[@normal]">
                                            <xsl:element name="mods:dateCreated">
                                                <xsl:attribute name="point" select="'start'"/>
                                                <xsl:attribute name="encoding" select="'w3cdtf'"/>
                                                <xsl:attribute name="keyDate" select="'yes'"/>
                                                <xsl:value-of
                                                  select="substring-before(ead:did/ead:unitdate[@normal][1]/@normal, '/')"
                                                />
                                            </xsl:element>
                                            <xsl:element name="mods:dateCreated">
                                                <xsl:attribute name="point" select="'end'"/>
                                                <xsl:attribute name="encoding" select="'w3cdtf'"/>
                                                <xsl:value-of
                                                  select="substring-after(ead:did/ead:unitdate[@normal][1]/@normal, '/')"
                                                />
                                            </xsl:element>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:element name="mods:dateCreated">
                                                <xsl:value-of select="ead:did/ead:unitdate"/>
                                            </xsl:element>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:element name="mods:issuance">
                                        <xsl:text>monographic</xsl:text>
                                    </xsl:element>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            <xsl:element name="mets:structMap">
                <xsl:attribute name="TYPE">logical</xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="text()"/>

    <xsl:template match="ead:c[@level = 'class']">
        <xsl:message>
            <xsl:text>Found class: </xsl:text>
            <xsl:value-of select="normalize-space(string-join(ead:did/ead:unittitle, ' '))"/>
        </xsl:message>
        <xsl:element name="mets:div">
            <xsl:attribute name="TYPE">classification</xsl:attribute>
            <xsl:attribute name="ID" select="concat('md-archivdarmstadt-', @id)"/>
            <xsl:attribute name="LABEL" select="ead:did/ead:unittitle"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="ead:c[@level = 'file']">
        <xsl:message>
            <xsl:text>Found file: </xsl:text>
            <xsl:value-of select="normalize-space(string-join(ead:did/ead:unittitle, ' '))"/>
        </xsl:message>
        <xsl:element name="mets:div">
            <xsl:attribute name="TYPE">document</xsl:attribute>
            <xsl:attribute name="DMDID" select="concat('md-archivdarmstadt-', @id)"/>
            <xsl:attribute name="LABEL">Verzeichnungseinheit</xsl:attribute>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
