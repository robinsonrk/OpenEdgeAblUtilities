/*------------------------------------------------------------------------
    File        : pdfnator-sample01.p
    Purpose     : Tests for PDFNator
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Tue Feb 25 16:08:43 BRT 2020
    Notes       :
        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

{Robinson/pdfnator/pdfnatorapi.i}


/* ***************************  Main Block  *************************** */

RUN insertHtmlField IN THIS-PROCEDURE ("ordernum", "456789").
RUN insertHtmlField IN THIS-PROCEDURE ("logoimage", REPLACE(SEARCH("Robinson/html2pdfmodels/images/sample-logo.jpg"), "\", "/")).
RUN insertHtmlField IN THIS-PROCEDURE ("orderdate", "09/01/2020").
RUN insertHtmlField IN THIS-PROCEDURE ("purpose", "Resale").
RUN insertHtmlField IN THIS-PROCEDURE ("terms", "18 - 14 0 0 0 0 0 D").
RUN insertHtmlField IN THIS-PROCEDURE ("carrying", "56 - Foo delivery").
RUN insertHtmlField IN THIS-PROCEDURE ("freight", "Payd").

RUN insertHtmlField IN THIS-PROCEDURE ("sellernum", "51131").
RUN insertHtmlField IN THIS-PROCEDURE ("sellername", "BRAZIL TOP SALES").
RUN insertHtmlField IN THIS-PROCEDURE ("sellerfederalid", "78.123.456/0001-99").
RUN insertHtmlField IN THIS-PROCEDURE ("sellerstateid", "45.789.123").
RUN insertHtmlField IN THIS-PROCEDURE ("selleraddress", "AVENIDA LADEIRA ACIMA, 19. SL 1103. Bairro: CENTRO").
RUN insertHtmlField IN THIS-PROCEDURE ("sellercity", "Joinville").
RUN insertHtmlField IN THIS-PROCEDURE ("sellerstateabbr", "SC").
RUN insertHtmlField IN THIS-PROCEDURE ("sellerpostalcode", "89030002").
RUN insertHtmlField IN THIS-PROCEDURE ("sellerphone", "(47) 98765-4321").
RUN insertHtmlField IN THIS-PROCEDURE ("selleremail", "someemail@somehost.com").

RUN insertHtmlField IN THIS-PROCEDURE ("custnum", "51131").
RUN insertHtmlField IN THIS-PROCEDURE ("custname", "BRAZIL TOP SALES").
RUN insertHtmlField IN THIS-PROCEDURE ("custfederalid", "78.123.456/0001-99").
RUN insertHtmlField IN THIS-PROCEDURE ("custstateid", "45.789.123").
RUN insertHtmlField IN THIS-PROCEDURE ("categoryid", "0").
RUN insertHtmlField IN THIS-PROCEDURE ("category", "Normal").
RUN insertHtmlField IN THIS-PROCEDURE ("custaddress", "AVENIDA LADEIRA ACIMA, 19. SL 1103. Bairro: CENTRO").
RUN insertHtmlField IN THIS-PROCEDURE ("custcity", "Joinville").
RUN insertHtmlField IN THIS-PROCEDURE ("custstateabbr", "SC").
RUN insertHtmlField IN THIS-PROCEDURE ("custpostalcode", "89030002").
RUN insertHtmlField IN THIS-PROCEDURE ("custphone", "(47) 98765-4321").
RUN insertHtmlField IN THIS-PROCEDURE ("custemail", "someemail@somehost.com").

RUN insertHtmlField IN THIS-PROCEDURE ("itemlist", "<tr><td>869467</td><td>Resale</td><td></td><td>40-498-6013</td><td class=~"text-right~">0.00000</td><td class=~"text-right~">0.00000</td></tr>"
                                                 + "<tr><td>869468</td><td>Resale</td><td></td><td>40-498-6013</td><td class=~"text-right~">0.00000</td><td class=~"text-right~">0.00000</td></tr>").
RUN insertHtmlField IN THIS-PROCEDURE ("ordersdescription", "SOME DETAILED DESCRIPTION FROM PRODUCTS" + CHR (10)
                                                          + "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas lectus urna, consectetur id ante nec, molestie sollicitudin justo. Curabitur dictum, ante vel varius rutrum, quam diam auctor leo, eu posuere sem erat nec sapien. Mauris justo dui, porta a sagittis non, tempor nec urna. In ac nisi arcu. Suspendisse mattis efficitur est, sed malesuada purus imperdiet eget. Vestibulum sit amet facilisis nibh, sed elementum massa. Sed metus lacus, dapibus at efficitur eget, vulputate eget augue.").
RUN insertHtmlField IN THIS-PROCEDURE ("paymentlist", "<tr><td class=~"text-right~">1</td><td class=~"text-right~">1.0000</td><td>SV</td><td class=~"text-right~">18,095.0500</td><td class=~"text-right~">0.0000</td><td class=~"text-right~">18,095.05</td><td>09/01/2020</td></tr>"
                                                    + "<tr><td class=~"text-right~">2</td><td class=~"text-right~">1.0000</td><td>SV</td><td class=~"text-right~">18,095.0500</td><td class=~"text-right~">0.0000</td><td class=~"text-right~">18,095.05</td><td>09/02/2020</td></tr>"
                                                    + "<tr><td class=~"text-right~">3</td><td class=~"text-right~">1.0000</td><td>SV</td><td class=~"text-right~">18,095.0500</td><td class=~"text-right~">0.0000</td><td class=~"text-right~">18,095.05</td><td>09/03/2020</td></tr>").

RUN insertHtmlField IN THIS-PROCEDURE ("instructions", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce nec sagittis tortor, sed sollicitudin leo. Nunc porta quam non orci." + CHR (10)
                                                     + "1 - Cras ultricies risus sit amet tristique tempor. Pellentesque quam purus, efficitur id diam ac, vulputate malesuada turpis." + CHR (10)
                                                     + "Aliquam auctor risus." + CHR (10)
                                                     + "2 - Nulla bibendum eleifend bibendum." + CHR (10)
                                                     + "CLASS aptent taciti." + CHR (10)
                                                     + "3 - Nam dictum efficitur ante id blandit. In eget porta lectus, ut lobortis lacus. Duis est sapien, fermentum ut neque eu." + CHR (10)
                                                     + "4 - Donec porttitor vitae diam eget accumsan. Integer velit ipsum, commodo quis mauris id, auctor maximus." + CHR (10)
                                                     + "5 - Aenean dui mi, malesuada ut interdum IN, blandit cursus enim. Nullam sit amet imperdiet leo. Praesent aliquam arcu quis diam ultrices, AT scelerisque erat porttitor. Mauris malesuada ultricies eros ac." + CHR (10)
                                                     + "6 - Vivamus neque leo, posuere nec." + CHR (10)
                                                     + "7 - Etiam pharetra tellus mi. Nunc et semper leo, ac suscipit.").
RUN insertHtmlField IN THIS-PROCEDURE ("total", "54.285,15").

RUN Robinson/pdfnator/pdfnatorapi.p (SEARCH("Robinson/html2pdfmodels/model-example01.html"),
                                     SESSION:TEMP-DIRECTORY + "generatedfile.pdf",
                                     "default",
                                     TRUE,
                                     0,
                                     1,
                                     TABLE ttHtmlFields).


PROCEDURE insertHtmlField:
    DEFINE INPUT  PARAMETER pcCampo AS CHARACTER    NO-UNDO.
    DEFINE INPUT  PARAMETER pcValor AS CHARACTER    NO-UNDO.

    FIND ttHtmlFields WHERE ttHtmlFields.htmlfield = pcCampo NO-ERROR.
    IF NOT AVAILABLE ttHtmlFields THEN DO:
        CREATE ttHtmlFields.
        ASSIGN ttHtmlFields.htmlfield = pcCampo.
    END.
    ASSIGN ttHtmlFields.htmlvalue = pcValor.
END PROCEDURE.
