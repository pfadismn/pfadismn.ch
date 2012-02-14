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
            
            <thumbnail>
                <filename>
                    <xsl:value-of select="images/image[1]/itemThumbnailImage"/>
                </filename>
                <width>
                    <xsl:value-of select="images/image[1]/itemThumbnailWidth"/>
                </width>
                <height>
                    <xsl:value-of select="images/image[1]/itemThumbnailHeight"/>
                </height>
            </thumbnail>
        </album>
    </xsl:template>
</xsl:stylesheet>
