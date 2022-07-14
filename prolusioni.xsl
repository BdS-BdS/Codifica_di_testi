<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml">

    
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <html lang="it">
            <head>
                <meta charset="UTF-8"/>
                <script src="prolusioni.js"></script>
                <link href='https://fonts.googleapis.com/css?family=ZCOOL XiaoWei' rel='stylesheet'/>
                <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
                <link href='https://fonts.googleapis.com/css?family=Beth Ellen' rel='stylesheet'/>
                <link rel="stylesheet" href="stile.css"/>
                <link rel="icon" type="image/x-icon" href="favicon.ico"/>
                <title><xsl:value-of select="//tei:titleStmt/tei:title[@type='main']"/></title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
            </head>
            <body>
                <nav>
                    <a href="#edizioneDigitale">Edizione digitale</a>
                    <a href="#manoscritto">Manoscritto</a>
                    <a href="#testoFrancese">Testo francese</a>
                    <a href="#traduzioneItaliana">Traduzione italiana</a>
                    <a href="#bibliografia">Bibliografia</a>
                    <a href="#glossario">Glossario</a>
                </nav>

                <section id="edizioneDigitale">
                    <xsl:call-template name="creaSezioneEdizioneDigitale"/>
                </section>                              

                <section id="manoscritto">
                    <xsl:call-template name="creaSezioneManoscritto"/>
                </section> 
                
                <section id="testoFrancese">
                    <div id="contenitoreTrascrizione" class="contenitoreInfo">
                        <xsl:apply-templates select="//tei:text[@xml:lang='fr']" mode="trascrizione"/>
                    </div>

                    <div id="contenitorePericopi" class="contenitoreInfo">
                        <xsl:call-template name="creaSezionePericopi"/>
                    </div>

                    <div id="contenitoreTermini" class="contenitoreInfo">
                        <xsl:call-template name="creaSezioneTermini"/>
                    </div>

                    <div id="contenitoreDate" class="contenitoreInfo">
                        <xsl:call-template name="creaSezioneDate"/>
                    </div>

                    <div id="contenitoreCancellature" class="contenitoreInfo">
                        <xsl:apply-templates select="//tei:text[@xml:lang='fr']" mode="cancellature"/>
                    </div>

                    <div id="contenitoreAggiunte" class="contenitoreInfo">
                        <xsl:apply-templates select="//tei:text[@xml:lang='fr']" mode="aggiunte"/>
                    </div>

                    <div id="contenitoreInterventi" class="contenitoreInfo">
                        <xsl:call-template name="creaSezioneInterventi"/>
                    </div>

                    <div>
                        <div id="selezionaInfo">
                            <p>Seleziona l'informazione che ti interessa</p>
                            <label class="container" id="radioTrascrizione">Trascrizione di Bouquet ed Engler
                                <input type="radio" name="radio" id="checked"/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="container" id="radioPericopi">Divisione in pericopi
                                <input type="radio" name="radio"/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="container" id="radioTermini">Elementi terminologici
                                <input type="radio" name="radio"/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="container" id="radioDate">Date o eventi databili e toponimi
                                <input type="radio" name="radio"/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="container" id="radioCancellature">Cancellature di Ferdinand de Saussure
                                <input type="radio" name="radio"/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="container" id="radioAggiunte">Aggiunte di Ferdinand de Saussure
                                <input type="radio" name="radio"/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="container" id="radioInterventi">Interventi di Bouquet ed Engler
                                <input type="radio" name="radio"/>
                                <span class="checkmark"></span>
                            </label>
                        </div>
                    </div>
                </section>

                <section id="traduzioneItaliana">
                    <xsl:call-template name="creaSezioneTraduzione"/>
                </section>

                <section id="bibliografia">
                    <h2><xsl:value-of select="//tei:back/tei:listBibl/tei:head"/></h2>
                    <xsl:apply-templates select="//tei:back/tei:listBibl/tei:bibl"/>
                </section>

                <section id="glossario">
                    <h2><xsl:value-of select="//tei:back/tei:list/tei:head"/></h2>
                    <div>
                        <xsl:call-template name="creaSezioneGlossario"/>                                       
                    </div>
                </section>

                <footer>
                    <p><xsl:value-of select="//tei:editionStmt/tei:edition"/></p>
                    <p><xsl:value-of select="//tei:titleStmt/tei:respStmt"/></p>
                </footer>
            </body>
        </html>
    </xsl:template>






    <xsl:template name="creaSezioneEdizioneDigitale">
        <p id="autore"><xsl:value-of select="//tei:titleStmt/tei:author"/></p>
        <h1><xsl:value-of select="//tei:titleStmt/tei:title[@type='main']"/></h1>
        <xsl:apply-templates select="//tei:titleStmt/tei:title[@type='sub']"/>
        <div id="contenitoreResp">
            <xsl:apply-templates select="//tei:editionStmt/tei:respStmt"/>
        </div>
        <p><xsl:value-of select="//tei:projectDesc/tei:p"/></p>
        <p><xsl:apply-templates select="//tei:punctuation/tei:p"/></p>
        <p><xsl:apply-templates select="//tei:normalization/tei:p"/></p>
    </xsl:template>

    <xsl:template name="creaSezioneManoscritto">
        <h2>Fonte primaria</h2>
        <div>
            <div id="contenitoreFoto">
                <div>
                    <button type="button" id="pulsanteSinistro">&#60;</button>
                    <p id="nomeFoto">Carta 8 (fronte)</p>
                    <button type="button" id="pulsanteDestro">&#62;</button>
                </div>
                <xsl:for-each select="//tei:surface/tei:graphic">
                    <img class="fronte" alt="carta del manoscritto">
                        <xsl:attribute name="src"><xsl:value-of select="current()/@url"/></xsl:attribute>
                        <xsl:attribute name="id"><xsl:value-of select="current()/@xml:id"/></xsl:attribute>
                    </img>
                </xsl:for-each>
            </div>
            <table>
                <tr>
                    <td>Tipo</td>
                    <td><xsl:apply-templates select="//tei:origin"/></td>
                </tr>
                <tr>
                    <td>Lingua</td>
                    <td><xsl:value-of select="//tei:langUsage"/></td>
                </tr>
                <tr>
                    <td>Mani</td>
                    <td><xsl:value-of select="//tei:handDesc"/></td>
                </tr>
                <tr>
                    <td>Condizioni</td>
                    <td><xsl:value-of select="//tei:condition"/></td>
                </tr>
                <tr>
                    <td>Numerazione</td>
                    <td><xsl:value-of select="//tei:foliation"/></td>
                </tr>
                <tr>
                    <td>Supporto fisico</td>
                    <td><xsl:value-of select="//tei:support"/></td>
                </tr>
                <tr>
                    <td>Contenuti</td>
                    <td>Appunti composti da <xsl:value-of select="count(//tei:msItem)"/> prolusioni.</td>
                </tr>
                <tr>
                    <td>Grandezza</td>
                    <td><xsl:value-of select="//tei:supportDesc/tei:extent"/></td>
                </tr>
                <tr>
                    <td>Acquisizione</td>
                    <td><xsl:value-of select="//tei:acquisition"/></td>
                </tr>
                <tr>
                    <td>Segnatura</td>
                    <td><xsl:value-of select="//tei:msIdentifier/tei:idno"/></td>
                </tr>
            </table>
        </div>
    </xsl:template>

    <xsl:template name="creaSezionePericopi">
        <h2><xsl:value-of select="//tei:segmentation//tei:head"/></h2>
        <xsl:apply-templates select="//tei:segmentation//tei:list/tei:item"/>
    </xsl:template>

    <xsl:template name="creaSezioneTermini">
         <div class="legenda">
            <p>Molti elementi terminologici sono presenti nel glossario, cliccaci sopra per andare direttamente alla loro definizione</p>
        </div>
        <xsl:apply-templates select="//tei:text[@xml:lang='fr']" mode="termini"/>
    </xsl:template>

    <xsl:template name="creaSezioneDate">
        <div class="legenda">
            <h3>Legenda:</h3>
            <span class="spanDate">Date o eventi databili</span>
            <span class="spanGeogName">Toponimi</span>
        </div>
        <xsl:apply-templates select="//tei:text[@xml:lang='fr']" mode="date"/>
    </xsl:template>

    <xsl:template name="incrementaContatore">
        <xsl:param name="i"/>
        <xsl:param name="dimGap"/>
        <xsl:if test="$dimGap > $i">
            <xsl:value-of select="'x'"/> 
            <xsl:call-template name="incrementaContatore">
                <xsl:with-param name="i" select="$i+1"/>
                <xsl:with-param name="dimGap" select="$dimGap"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="creaSezioneInterventi">
        <div class="legenda">
            <h3>Legenda:</h3>
            <span class="spanSic">[Presente nel manoscritto]</span>
            <span class="spanCorr">Presente nella trascrizione</span><br/>
            <p>Passa con il cursore sul testo per ulteriori informazioni</p>
        </div>
        <xsl:apply-templates select="//tei:text[@xml:lang='fr']" mode="interventi"/>
    </xsl:template>

    <xsl:template name="creaSezioneTraduzione">
        <h2>Traduzione italiana</h2>
        <p><em class="bold">Clicca sul manoscritto</em> per selezionare la pericope che vuoi tradurre (adesso è già selezionata la prima), poi <em class="bold">clicca sul "foglio" vuoto</em> (a destra del manoscritto) <em class="bold">e trascina</em> per vedere la traduzione.</p>
        <button type="button" id="nuovoFoglio">Nuovo foglio</button>
        <div id="contenitoreTraduzione">
            <div>
                <xsl:apply-templates select="//tei:graphic"/>
            </div>
            <div id="divCanvas">
                <canvas id="canvas"></canvas>
                <span id="cliccaTrascina">Clicca su questo "foglio" e trascina (da sinistra a destra)</span>
                
            </div>
        </div>
        <xsl:apply-templates select="//tei:text[@xml:lang='it']//tei:ab"/>
    </xsl:template>

    <xsl:template name="creaSezioneGlossario">
        <xsl:for-each select="//tei:back/tei:list/tei:label">
            <xsl:sort select="tei:term[@xml:lang='fr']"/>
            <xsl:variable name="glossTarget">#<xsl:value-of select="current()/tei:term[@xml:lang='fr']/@xml:id"/></xsl:variable>
            <details>
                <summary class="bold">
                    <xsl:attribute name="id"><xsl:value-of select="current()/tei:term[@xml:lang='fr']/@xml:id"/></xsl:attribute>
                    <xsl:value-of select="current()/tei:term[@xml:lang='fr']"/> (<xsl:value-of select="current()/tei:term[@xml:lang='it']"/>)
                </summary>
                <p><xsl:value-of select="//tei:gloss[@target= $glossTarget]"/></p>
            </details>
        </xsl:for-each>
    </xsl:template>








    <!--sezione edizione digitale-->
    <xsl:template match="//tei:titleStmt/tei:title[@type='sub']">
        <h2><xsl:value-of select="current()"/></h2>
    </xsl:template>

    <xsl:template match="//tei:editionStmt/tei:respStmt">
        <div>
            <h3><xsl:value-of select="current()/tei:resp"/></h3>
            <xsl:apply-templates select="current()/tei:persName"/>
        </div>
    </xsl:template>

    <xsl:template match="//tei:respStmt/tei:persName">
        <p><xsl:value-of select="current()"/></p>
    </xsl:template>

    <xsl:template match="//tei:gi">
        &#60;<xsl:value-of select="current()"/>&#62;
    </xsl:template>


    <!--sezione manoscritto-->
    <xsl:template match="//tei:foreign">
        <em><xsl:value-of select="current()"/></em>
    </xsl:template>


    <!--sezione trascrizione-->
    <xsl:template match="//tei:fw" mode="trascrizione">
        <h2>Trascrizione carta <xsl:value-of select="current()"/> di Prolusioni 3</h2>
    </xsl:template>

    <xsl:template match="//tei:del" mode="trascrizione">
        <span class="nascondiDel"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:sic" mode="trascrizione">
        <span class="nascondiSic"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:abbr" mode="trascrizione">
        <span class="nascondiAbbr"><xsl:value-of select="current()"/></span>      
    </xsl:template>
    
    <xsl:template match="//tei:emph" mode="trascrizione">
        <span class="spanEmph" title="la sottolineatura è presente nel manoscritto"><xsl:value-of select="current()"/></span>      
    </xsl:template>


    <!--sezione pericopi-->
    <xsl:template match="//tei:segmentation//tei:item">
        <table>
            <tr>
                <td>Pericope <xsl:value-of select="@n"/></td>
                <td><xsl:value-of select="current()/tei:seg"/></td>
            </tr>
            <tr>
                <td>Descrizione</td>
                <td><xsl:value-of select="current()/tei:desc"/></td>
            </tr>
        </table>
    </xsl:template>


    <!--sezione termini-->
    <xsl:template match="//tei:fw" mode="termini">
        <h2>Carta <xsl:value-of select="current()"/> di Prolusioni 3</h2>
    </xsl:template>

    <xsl:template match="//tei:del" mode="termini">
        <span class="nascondiDel"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:sic" mode="termini">
        <span class="nascondiSic"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:abbr" mode="termini">
        <span class="nascondiAbbr"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:term" mode="termini">
        <span class="spanTerm">
            <xsl:choose>
                <xsl:when test="@ref">
                    <a>
                        <xsl:attribute name="href"><xsl:value-of select="@ref"/></xsl:attribute>
                        <xsl:attribute name="title">clicca per andare al glossario</xsl:attribute>
                        <xsl:value-of select="string-join(current()//text()[not(ancestor::tei:abbr)], '')"/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="string-join(current()//text()[not(ancestor::tei:abbr)], '')"/>
                </xsl:otherwise>
            </xsl:choose>
        </span>      
    </xsl:template>


    <!--sezione date-->
    <xsl:template match="//tei:fw" mode="date">
        <h2>Carta <xsl:value-of select="current()"/> di Prolusioni 3</h2>
    </xsl:template>

    <xsl:template match="//tei:del" mode="date">
        <span class="nascondiDel"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:sic" mode="date">
        <span class="nascondiSic"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:abbr" mode="date">
        <span class="nascondiAbbr"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:date" mode="date">
        <span class="spanDate">
            <xsl:value-of select="string-join(current()//text()[not(ancestor::tei:del | ancestor::tei:abbr)], '')"/>
        </span>      
    </xsl:template>

    <xsl:template match="//tei:geogName" mode="date">
        <span class="spanGeogName"><xsl:value-of select="current()"/></span>      
    </xsl:template>


    <!--sezione cancellature-->
    <xsl:template match="//tei:fw" mode="cancellature">
        <h2>Carta <xsl:value-of select="current()"/> di Prolusioni 3</h2>
    </xsl:template>

    <xsl:template match="//tei:sic" mode="cancellature">
        <span class="nascondiSic"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:abbr" mode="cancellature">
        <span class="nascondiAbbr"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:del[not(*)]" mode="cancellature">
            <span class="spanDel"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:gap" mode="cancellature">
        <span class="spanGap" title="testo illegibile sotto la cancellatura">
            <xsl:call-template name="incrementaContatore">
                <xsl:with-param name="i" select="0"/>
                <xsl:with-param name="dimGap" select="@quantity"/>
            </xsl:call-template>
        </span>      
    </xsl:template>


    <!--sezione aggiunte-->
    <xsl:template match="//tei:fw" mode="aggiunte">
        <h2>Carta <xsl:value-of select="current()"/> di Prolusioni 3</h2>
    </xsl:template>

    <xsl:template match="//tei:del" mode="aggiunte">
        <span class="nascondiDel"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:sic" mode="aggiunte">
        <span class="nascondiSic"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:abbr" mode="aggiunte">
        <span class="nascondiAbbr"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:add" mode="aggiunte">
        <span class="spanAdd">
            <xsl:value-of select="string-join(current()//text()[not(ancestor::tei:abbr)], '')"/>
        </span>      
    </xsl:template>


    <!--sezione interventi-->
    <xsl:template match="//tei:fw" mode="interventi">
        <h2>Carta <xsl:value-of select="current()"/> di Prolusioni 3</h2>
    </xsl:template>

    <xsl:template match="//tei:sic" mode="interventi">
        <span class="spanSic" title="presente nel manoscritto">[<xsl:value-of select="current()"/>]</span>      
    </xsl:template>

    <xsl:template match="//tei:corr" mode="interventi">
        <span class="spanCorr" title="correzione di Bouquet ed Engler"><xsl:value-of select="current()"/></span>      
    </xsl:template>

    <xsl:template match="//tei:abbr" mode="interventi">
        <span class="spanAbbr" title="abbreviazione presente nel manoscritto">[<xsl:value-of select="current()"/>]</span>      
    </xsl:template>

    <xsl:template match="//tei:expan" mode="interventi">
        <span class="spanExpan" title="scioglimento di Bouquet ed Engler"><xsl:value-of select="current()"/></span>      
    </xsl:template>



    <!--sezione traduzione-->
    <xsl:template match="//tei:graphic">        
        <img alt="carta del manoscritto" class="traduzione">
            <xsl:attribute name="src"><xsl:value-of select="current()/@url"/></xsl:attribute>
            <xsl:attribute name="usemap">#mappa<xsl:value-of select="current()/@xml:id"/></xsl:attribute>
        </img><br/>
        <map>
            <xsl:attribute name="name">mappa<xsl:value-of select="current()/@xml:id"/></xsl:attribute>
            <xsl:apply-templates select="parent::node()/tei:zone[substring (@xml:id, 1, 5) = 'peric']"/>
        </map>
    </xsl:template>

    <xsl:template match="//tei:surface/tei:zone[substring (@xml:id, 1, 5) = 'peric']">
        <area shape="poly" href="#traduzioneItaliana">
            <xsl:attribute name="coords"><xsl:value-of select="@points"/></xsl:attribute>
            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
        </area>
    </xsl:template>

    <xsl:template match="//tei:text[@xml:lang='it']//tei:ab">
        <p class="traduzionePericope">
            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
            <xsl:value-of select="current()"/>
        </p>
    </xsl:template>

    <!--sezione bibliografia-->
    <xsl:template match="//tei:bibl">
        <p class="bold"><xsl:value-of select="current()/tei:note"/></p>
        <p>
            <xsl:for-each select="current()/tei:author">
                <xsl:value-of select="current()//tei:forename"/><xsl:value-of select="current()//tei:surname"/>, 
            </xsl:for-each>
            <xsl:choose>
                <xsl:when test="current()/tei:title[@type]">
                    <cite><xsl:value-of select="current()/tei:title[@type='main']"/><xsl:value-of select="current()/tei:title[@type='sub']"/></cite>,
                </xsl:when>
                <xsl:otherwise>
                    <cite><xsl:value-of select="current()/tei:title"/></cite>,
                </xsl:otherwise>
            </xsl:choose>     
            <xsl:value-of select="current()/tei:pubPlace"/>,
            <xsl:value-of select="current()/tei:publisher"/>,
            <xsl:value-of select="current()/tei:date"/>,
            <xsl:value-of select="current()/tei:citedRange"/>.
        </p>
    </xsl:template>
</xsl:stylesheet>