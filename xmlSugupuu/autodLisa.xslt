<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
   <xsl:output method="html" indent="yes" encoding="utf-8"/>

    <xsl:template match="/">
      <h3>Autode üldkogus xml jadas</h3>
      <br></br>
      Kasutame count() funktsiooni
      <xsl:value-of select="count(autod/auto)"/>
      
      <hr></hr>
      
      <h3>Autode regnumbrid mis on vaaasta=2000</h3>
      <br></br>
      Kasutame count() funktsiooni
      <xsl:value-of select="count(autod/auto[vaasta=2000])"/>
      
      <hr></hr>
      
      <h3>Auto regnumbrid mis algavad 2</h3>
      <p>
        Kautame starts-with funktsiooni
      </p>
      <ul>
        <xsl:for-each select="autod/auto[starts-with(registrinumber, 2)]">
          <xsl:sort select="vaasta" order="descending"/>
          <li>
            <xsl:value-of select="concat(mark, ', ', registrinumber, ', ', vaasta)"/>
          </li>
        </xsl:for-each>
      </ul>
      <h2>Autod tabelina</h2>
      <table>
        <tr>
          <th>Reg number</th>
          <th>Mark</th>
          <th>Väljastamise aasta</th>
          <th>Omanik</th>
        </tr>
        <xsl:for-each select="autod/auto">
          <tr>
            <td>
              <xsl:value-of select="registrinumber"/>
            </td>
            <td>
              <xsl:value-of select="mark"/>
            </td>
            <td>
              <xsl:value-of select="vaasta"/>
            </td>
            <td>
              <xsl:value-of select="omanik"/>
            </td>
          </tr>
        </xsl:for-each>
      </table>

      <hr></hr>
      
      <h2>1. Trüki välja (eralda komaga) auto regitrinumbri numbrite osa</h2>
        <xsl:for-each select="autod/auto">
            <xsl:value-of select="concat(substring(registrinumber, 1, 3), ', ')"/>
        </xsl:for-each>
      
      <hr></hr>
      
      <h2>2. Trüki välja (eralda komaga) omaniku nime viimane täht</h2>
      <xsl:for-each select="autod/auto">
            <xsl:value-of select="concat(substring(omanik, string-length(omanik), 1), ', ')"/>
        </xsl:for-each>
      
      <hr></hr>
      
      <h2>3. Auto omanikud, mis siseldavad A täht: </h2>
      <xsl:for-each select="autod/auto">
        <xsl:if test="contains(omanik, 'a')">
          <xsl:value-of select="concat(omanik, ', ')"/>
        </xsl:if>
      </xsl:for-each>
      
      <hr></hr>
      
      <h2>4. Leia, mitme auto registrimärgi numberitest viimane on 2</h2>
      <xsl:if test="substring(registrinumber, string-length(registrinumber), 1) = '2'">
        <xsl:value-of select="registrinumber"/>
      </xsl:if>
      
      <hr></hr>
      
      <h2>5. Teata iga registrinumbri puhul, millises kuus auto ülevaatus</h2>
      <table>
          <tr>
            <th>Reg number</th>
            <th>Mark</th>
            <th>Väljastamise aasta</th>
            <th>Omanik</th>
            <th>Ülevatuse kuu</th>
          </tr>
          <xsl:for-each select="autod/auto">
            <tr>
              <td>
                <xsl:value-of select="registrinumber"/>
              </td>
              <td>
                <xsl:value-of select="mark"/>
              </td>
              <td>
                <xsl:value-of select="vaasta"/>
              </td>
              <xsl:if test="contains(omanik, 'a')">
                <td bgcolor="yellow">
                  <xsl:value-of select="omanik"/>
                </td>
              </xsl:if>
              <xsl:if test="not(contains(omanik, 'a'))">
                <td>
                  <xsl:value-of select="omanik"/>
                </td>
              </xsl:if>
              <xsl:if test="number(substring(registrinumber, 3, 1)+2)>=9">
                <td bgcolor="red">
                  <xsl:value-of select="substring(registrinumber, 3, 1)+2"/>
                </td>
              </xsl:if>
              <xsl:if test="number(substring(registrinumber, 3, 1)+2) &lt; 9">
                <td bgcolor="green">
                  <xsl:value-of select="substring(registrinumber, 3, 1)+2"/>
                </td>
              </xsl:if>
            </tr>
          </xsl:for-each>
        </table>
      
      <hr></hr>
      
      <h2>1. Kui registrinumbri esimene number vastab aastaarvu viimasele numbrile, muutub märgi taust oranžiks.</h2>
      <h2>2. Kui omaniku nime tähtede arv on sama, mis auto mark, siis värvige taust siniseks.</h2>
      <table>
          <tr>
            <th>Reg number</th>
            <th>Mark</th>
            <th>Väljastamise aasta</th>
            <th>Omanik</th>
            <th>Ülevatuse kuu</th>
          </tr>
          <xsl:for-each select="autod/auto">
            <tr>
              <xsl:if test="substring(registrinumber, 1, 1) = substring(vaasta , 4, 4)">
                <td bgcolor="orange">
                  <xsl:value-of select="registrinumber"/>
                </td>
              </xsl:if>
              <xsl:if test="not(substring(registrinumber, 1, 1) = substring(vaasta , 4, 4))">
                <td>
                  <xsl:value-of select="registrinumber"/>
                </td>
              </xsl:if>
              <xsl:if test="number(string-length(omanik)) = number(string-length(mark))">
                <td bgcolor="blue">
                  <xsl:value-of select="mark"/>
                </td>
              </xsl:if>
              <xsl:if test="not(number(string-length(omanik)) = number(string-length(mark)))">
                <td>
                  <xsl:value-of select="mark"/>
                </td>
              </xsl:if>
              <td>
                <xsl:value-of select="vaasta"/>
              </td>
              <xsl:if test="number(string-length(omanik)) = number(string-length(mark))">
                <td bgcolor="blue">
                  <xsl:value-of select="omanik"/>
                </td>
              </xsl:if>
              <xsl:if test="not(number(string-length(omanik)) = number(string-length(mark)))">
                <td>
                  <xsl:value-of select="omanik"/>
                </td>
              </xsl:if>
              <xsl:if test="number(substring(registrinumber, 3, 1)+2)>=9">
                <td bgcolor="red">
                  <xsl:value-of select="substring(registrinumber, 3, 1)+2"/>
                </td>
              </xsl:if>
              <xsl:if test="number(substring(registrinumber, 3, 1)+2) &lt; 9">
                <td bgcolor="green">
                  <xsl:value-of select="substring(registrinumber, 3, 1)+2"/>
                </td>
              </xsl:if>
            </tr>
          </xsl:for-each>
        </table>
    </xsl:template>
</xsl:stylesheet>
