<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml"/>
    <xsl:template match="/album">
        <album>
            <xsl:copy-of select="albumName"/>
            <xsl:copy-of select="albumItemCount"/>
            <xsl:copy-of select="albumCaption"/>
            <xsl:copy-of select="albumPlace"/>
            <xsl:copy-of select="albumItemCount"/>
            <images>
                <xsl:for-each select="images/image">
                    <image>
                        <filename><xsl:value-of select="itemLargeImage"/></filename>
                        <name><xsl:value-of select="itemName"/></name>
                        <caption><xsl:value-of select="itemCaption"/></caption>
                        <width><xsl:value-of select="itemWidth"/></width>
                        <height><xsl:value-of select="itemHeight"/></height>
                        
                        <thumbnail>
                            <filename><xsl:value-of select="itemThumbnailImage"/></filename>
                            <width><xsl:value-of select="itemThumbnailWidth"/></width>
                            <height><xsl:value-of select="itemThumbnailHeight"/></height>
                        </thumbnail>
                    </image>
                </xsl:for-each>
            </images>
        </album>
    </xsl:template>
</xsl:stylesheet>
