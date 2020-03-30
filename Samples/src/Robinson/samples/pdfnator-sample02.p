/*------------------------------------------------------------------------
    File        : pdfnator-sample02.p
    Purpose     : Sample to PDFNator
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Mon Mar 02 17:29:36 BRT 2020
    Notes       :

        Generates a HTML file to be converted to PDF.

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.


/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Definitions  ************************** */

DEFINE VARIABLE cBaseArq    AS CHARACTER    NO-UNDO INITIAL "samplefilename".
DEFINE VARIABLE cArquivo    AS CHARACTER    NO-UNDO.
DEFINE VARIABLE iCont       AS INTEGER      NO-UNDO.
DEFINE VARIABLE deTotal     AS DECIMAL      NO-UNDO DECIMALS 4.


DEFINE TEMP-TABLE ttOrdem NO-UNDO
    FIELD nr-ordem-compra AS INTEGER
    FIELD destino AS CHARACTER
    FIELD it-fornec AS CHARACTER
    FIELD it-codigo AS CHARACTER
    FIELD perc-ipi AS DECIMAL  DECIMALS 4
    FIELD vl-ipi AS DECIMAL DECIMALS 4
    FIELD narrativa-item AS CHARACTER
    FIELD narrativa-ordem AS CHARACTER
    INDEX idOrdem IS PRIMARY UNIQUE nr-ordem-compra.

DEFINE TEMP-TABLE ttParcela NO-UNDO
    FIELD nr-ordem-compra LIKE ttOrdem.nr-ordem-compra
    FIELD nr-parcela AS INTEGER
    FIELD quantidade AS DECIMAL DECIMALS 4
    FIELD unid-medida AS CHARACTER
    FIELD pre-uni AS DECIMAL DECIMALS 4
    FIELD val-desconto AS DECIMAL DECIMALS 4
    FIELD val-enc-fin AS DECIMAL DECIMALS 4
    FIELD pre-total AS DECIMAL
    FIELD dt-entrega AS DATE
    FIELD ref-item AS CHARACTER
    INDEX idParcela IS PRIMARY UNIQUE nr-ordem-compra nr-parcela.


DEFINE STREAM str-out.

/* ***************************  Main Block  *************************** */


RUN Robinson/samples/loadfakedata.p (OUTPUT TABLE ttOrdem, OUTPUT TABLE ttParcela).


ASSIGN cArquivo = SESSION:TEMP-DIRECTORY + cBaseArq + ".html".

OUTPUT STREAM str-out TO VALUE (cArquivo) CONVERT TARGET "utf-8".

PUT STREAM str-out UNFORMATTED '<!DOCTYPE html>' SKIP.
PUT STREAM str-out UNFORMATTED '<html lang="pt-BR">' SKIP.
PUT STREAM str-out UNFORMATTED '<head>' SKIP.
PUT STREAM str-out UNFORMATTED '    <meta CHARSET="utf-8" />' SKIP.
PUT STREAM str-out UNFORMATTED '    <meta NAME="viewport" content="width=device-width, initial-scale=1.0" />' SKIP.
PUT STREAM str-out UNFORMATTED '    <TITLE>Purchase Order ' "387.603" '</TITLE>' SKIP.
PUT STREAM str-out UNFORMATTED '    <meta NAME="description" content="Free Web tutorials" />' SKIP.
PUT STREAM str-out UNFORMATTED '    <meta NAME="keywords" content="HTML,CSS,XML,JavaScript" />' SKIP.
PUT STREAM str-out UNFORMATTED '    <meta NAME="author" content="John Doe" />' SKIP.

PUT STREAM str-out UNFORMATTED '    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous" />' SKIP.

PUT STREAM str-out UNFORMATTED '<style>' SKIP.
PUT STREAM str-out UNFORMATTED '.h1, h1 ~{' SKIP.
PUT STREAM str-out UNFORMATTED '    font-size: 1.8rem;' SKIP.
PUT STREAM str-out UNFORMATTED '}' SKIP.
PUT STREAM str-out UNFORMATTED '.lead ~{' SKIP.
PUT STREAM str-out UNFORMATTED '    font-size: 1.1rem;' SKIP.
PUT STREAM str-out UNFORMATTED '}' SKIP.
PUT STREAM str-out UNFORMATTED 'p ~{' SKIP.
PUT STREAM str-out UNFORMATTED '    margin: 0;' SKIP.
PUT STREAM str-out UNFORMATTED '}' SKIP.
PUT STREAM str-out UNFORMATTED '#report-logo ~{' SKIP.
PUT STREAM str-out UNFORMATTED '    float: left;' SKIP.
PUT STREAM str-out UNFORMATTED '    margin-top: 1rem;' SKIP.
PUT STREAM str-out UNFORMATTED '}' SKIP.
PUT STREAM str-out UNFORMATTED '#report-header ~{' SKIP.
PUT STREAM str-out UNFORMATTED '    margin-left: 240px;' SKIP.
PUT STREAM str-out UNFORMATTED '}' SKIP.
PUT STREAM str-out UNFORMATTED '.linha-assinatura ~{' SKIP.
PUT STREAM str-out UNFORMATTED '    /*padding: 0 10px;*/' SKIP.
PUT STREAM str-out UNFORMATTED '    text-align: center;' SKIP.
PUT STREAM str-out UNFORMATTED '}' SKIP.
PUT STREAM str-out UNFORMATTED '#report-assinaturas ~{' SKIP.
PUT STREAM str-out UNFORMATTED '    margin-top: 10rem;' SKIP.
PUT STREAM str-out UNFORMATTED '}' SKIP.
PUT STREAM str-out UNFORMATTED '#report-assinaturas td ~{' SKIP.
PUT STREAM str-out UNFORMATTED '    padding: 0 10px;' SKIP.
PUT STREAM str-out UNFORMATTED '    width: 33%;' SKIP.
PUT STREAM str-out UNFORMATTED '}' SKIP.
PUT STREAM str-out UNFORMATTED '#report-assinaturas td div ~{' SKIP.
PUT STREAM str-out UNFORMATTED '    width: 100%;' SKIP.
PUT STREAM str-out UNFORMATTED '    border-top: 1px solid black;' SKIP.
PUT STREAM str-out UNFORMATTED '    text-align: center;' SKIP.
PUT STREAM str-out UNFORMATTED '}' SKIP.
PUT STREAM str-out UNFORMATTED '#report-cabec,' SKIP.
PUT STREAM str-out UNFORMATTED '#report-emitente,' SKIP.
PUT STREAM str-out UNFORMATTED '#report-entrega,' SKIP.
PUT STREAM str-out UNFORMATTED '#report-itens,' SKIP.
PUT STREAM str-out UNFORMATTED '#report-narrativa,' SKIP.
PUT STREAM str-out UNFORMATTED '#report-parcelas,' SKIP.
PUT STREAM str-out UNFORMATTED '#report-mensagens,' SKIP.
PUT STREAM str-out UNFORMATTED '#report-comentarios,' SKIP.
PUT STREAM str-out UNFORMATTED '#report-assinaturas ~{' SKIP.
PUT STREAM str-out UNFORMATTED '    page-break-inside : avoid;' SKIP.
PUT STREAM str-out UNFORMATTED '}' SKIP.
PUT STREAM str-out UNFORMATTED 'pre ~{' SKIP.
PUT STREAM str-out UNFORMATTED '    white-space: pre-wrap;       /* Since CSS 2.1 */' SKIP.
PUT STREAM str-out UNFORMATTED '    white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */' SKIP.
PUT STREAM str-out UNFORMATTED '    white-space: -pre-wrap;      /* Opera 4-6 */' SKIP.
PUT STREAM str-out UNFORMATTED '    white-space: -o-pre-wrap;    /* Opera 7 */' SKIP.
PUT STREAM str-out UNFORMATTED '    word-wrap: break-word;       /* Internet Explorer 5.5+ */' SKIP.
PUT STREAM str-out UNFORMATTED '}' SKIP.
PUT STREAM str-out UNFORMATTED '</style>' SKIP.

PUT STREAM str-out UNFORMATTED '</head>' SKIP.
PUT STREAM str-out UNFORMATTED '<body>' SKIP.

PUT STREAM str-out UNFORMATTED '    <!-- Will print AT the TOP OF every PAGE -->' SKIP.
PUT STREAM str-out UNFORMATTED '    <div id="report-cabec" class="container">' SKIP.

PUT STREAM str-out UNFORMATTED '        <div id="report-logo">' SKIP.
PUT STREAM str-out UNFORMATTED '            <img src="file:///' REPLACE(SEARCH("Robinson/html2pdfmodels/images/sample-logo.jpg"), "\", "/") '" WIDTH="224" HEIGHT="125" />' SKIP.
PUT STREAM str-out UNFORMATTED '        </div>' SKIP.

PUT STREAM str-out UNFORMATTED '        <div id="report-header">' SKIP.

PUT STREAM str-out UNFORMATTED '            <h1 id="h1">Purchase Order #' "387.603" '</h1>' SKIP.
PUT STREAM str-out UNFORMATTED '            <p>Purchase date: ' "28/02/2020" '</p>' SKIP.
PUT STREAM str-out UNFORMATTED '            <p>Destination: ' "Resale" '</p>' SKIP.
PUT STREAM str-out UNFORMATTED '            <p>Terms: ' "67" ' - ' "45 0 0 0 0 0 D" '</p>' SKIP.
PUT STREAM str-out UNFORMATTED '            <p>Freighter: ' "99.999" ' - ' "GERAL" '</p>' SKIP.
PUT STREAM str-out UNFORMATTED '            <p>Cost: ' "Payd" '</p>' SKIP.

PUT STREAM str-out UNFORMATTED '        </div>' SKIP.

PUT STREAM str-out UNFORMATTED '        <hr />' SKIP.

PUT STREAM str-out UNFORMATTED '    </div>' SKIP.

PUT STREAM str-out UNFORMATTED '    <!-- PAGE content -->' SKIP.

PUT STREAM str-out UNFORMATTED '    <div id="report-emitente" class="container">' SKIP.

PUT STREAM str-out UNFORMATTED '        <p><strong>Buyer:</strong> ' "3005" ' - ' "BUY EVERYTHING COMPANY - INC" ' - ' "BUYEVER" '</p>' SKIP.
PUT STREAM str-out UNFORMATTED '        <p>Federal Id: ' "34.345.678/4573-37" ' - State Id: ' "23645056755679567" '</p>' SKIP.

PUT STREAM str-out UNFORMATTED '        <address>' SKIP.
PUT STREAM str-out UNFORMATTED '            Address: ' "IRIRIU AV" ', ' "3509" '<br />' SKIP.
PUT STREAM str-out UNFORMATTED '            City: ' "JOINVILLE" ' - ' "SC" '. Postal Code: ' "89200-000" '<br />' SKIP.
PUT STREAM str-out UNFORMATTED '            Phone: ' "47 5555-1398" '<br />' SKIP.
PUT STREAM str-out UNFORMATTED '            E-mail: ' "someaddress@somehost.com" SKIP.
PUT STREAM str-out UNFORMATTED '        </address>' SKIP.

PUT STREAM str-out UNFORMATTED '    </div>' SKIP.

PUT STREAM str-out UNFORMATTED '    <div id="report-entrega" class="container">' SKIP.

PUT STREAM str-out UNFORMATTED '        <p><strong>Delivery:</strong> ' "103" ' - ' "BUY EVERYTHING STORAGE - INC" '</p>' SKIP.
PUT STREAM str-out UNFORMATTED '        <p>Federal Id: ' "56.123.456/1210-07" ' - State Id: ' "1271599370593" '</p>' SKIP.

PUT STREAM str-out UNFORMATTED '        <address>' SKIP.
PUT STREAM str-out UNFORMATTED '            Endereço: ' "RODOVIA BR 101" ', ' "KM 42,1" '<br />' SKIP.
PUT STREAM str-out UNFORMATTED '            City: ' "JOINVILLE" '. Postal Code: ' "89200-001" '<br />' SKIP.
PUT STREAM str-out UNFORMATTED '        </address>' SKIP.

PUT STREAM str-out UNFORMATTED '    </div>' SKIP.

PUT STREAM str-out UNFORMATTED '    <div id="report-itens" class="container">' SKIP.

FOR EACH ttOrdem NO-LOCK,
    EACH ttParcela NO-LOCK WHERE ttParcela.nr-ordem-compra = ttOrdem.nr-ordem-compra
        BY ttOrdem.nr-ordem-compra:

    ASSIGN deTotal = deTotal + ttParcela.quantidade * ttParcela.pre-uni.

PUT STREAM str-out UNFORMATTED '        <table id="ttItemOrdem" class="table table-sm">' SKIP.
PUT STREAM str-out UNFORMATTED '            <thead>' SKIP.
PUT STREAM str-out UNFORMATTED '                <tr>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <th scope="col" width="8%">Request</th>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <th scope="col" width="10%">Cause</th>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <th scope="col" width="12%">Item</th>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <th width="8%" class="text-right">Qty</th>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <th width="5%">Un</th>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <th width="10%" class="text-right">Unit Price</th>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <th scope="col" width="8%" class="text-right">Tax</th>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <th scope="col" class="text-right">Tax Value</th>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <th width="12%" class="text-right">Total Price</th>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <th width="5%" class="text-right">Pa</th>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <th width="10%">Promissed</th>' SKIP.
PUT STREAM str-out UNFORMATTED '                </tr>' SKIP.
PUT STREAM str-out UNFORMATTED '            </thead>' SKIP.
PUT STREAM str-out UNFORMATTED '            <tbody>' SKIP.

PUT STREAM str-out UNFORMATTED '                <tr>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <td>' ttOrdem.nr-ordem-compra '</td>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <td>' ttOrdem.destino '</td>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <td>' ttOrdem.it-codigo '</td>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <td class="text-right">' TRIM(STRING(ttParcela.quantidade, "->>>,>>>,>>9.9999")) '</td>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <td>' ttParcela.unid-medida '</td>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <td class="text-right">' TRIM(STRING(ttParcela.pre-uni, "->>>,>>>,>>9.9999")) '</td>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <td class="text-right">' TRIM(STRING(ttOrdem.perc-ipi, "->>>,>>>,>>9.99")) '</td>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <td class="text-right">' TRIM(STRING(ttOrdem.vl-ipi, "->>>,>>>,>>9.99")) '</td>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <td class="text-right">' TRIM(STRING (ttParcela.pre-total, "->>>,>>>,>>9.99")) '</td>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <td class="text-right">' ttParcela.nr-parcela '</td>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <td>' STRING(ttParcela.dt-entrega, "99/99/9999") '</td>' SKIP.
PUT STREAM str-out UNFORMATTED '                </tr>' SKIP.

    IF ttOrdem.narrativa-ordem <> "" THEN DO:

PUT STREAM str-out UNFORMATTED '                <tr>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <td>&nbsp;</td>' SKIP.
PUT STREAM str-out UNFORMATTED '                    <td colspan="10" class="report-narrativa-ordem">' SKIP.
PUT STREAM str-out UNFORMATTED '                        <p><span class="lead">Request Observations:</span> '.

DO iCont = 1 TO NUM-ENTRIES(ttOrdem.narrativa-ordem, CHR(10)):
    PUT STREAM str-out UNFORMATTED (IF iCont > 1 THEN "<p>" ELSE "") ENTRY(iCont, ttOrdem.narrativa-ordem, CHR(10)) "</p>" SKIP.
END.

PUT STREAM str-out UNFORMATTED '                    </td>' SKIP.
PUT STREAM str-out UNFORMATTED '                </tr>' SKIP.

    END.

PUT STREAM str-out UNFORMATTED '            </tbody>' SKIP.
PUT STREAM str-out UNFORMATTED '        </table>' SKIP.

END.

PUT STREAM str-out UNFORMATTED '    </div>' SKIP.

PUT STREAM str-out UNFORMATTED '    <div id="report-mensagens" class="container">' SKIP.

PUT STREAM str-out UNFORMATTED '        <p class="lead text-center">Purchase Messages</p>' SKIP.
PUT STREAM str-out UNFORMATTED '<pre>' SKIP.

PUT STREAM str-out UNFORMATTED '1 - PAYMENTS WILL BE MADE EXCLUSIVELY WITH A BANK CURRENT ACCOUNT.' SKIP.
PUT STREAM str-out UNFORMATTED 'THEREFORE, ANY DUPLICATES WHICH MAY BE ISSUED OR PRESENTED FOR CHARGING WILL BE NULL, WHEREAS THE BUYER IS RELEASED TO ACCEPT IT OR PAY IT.' SKIP.
PUT STREAM str-out UNFORMATTED '2 - PLEASE PLACE THE PURCHASE ORDER NUMBER IN THE BODY OF THE INVOICE.' SKIP.
PUT STREAM str-out UNFORMATTED '3 - MATERIAL IN DISAGREEMENT WITH THE PURCHASE ORDER WILL HAVE TOTAL RETURNS WITH FREIGHT ON THE SUPPLIER~'S ACCOUNT.' SKIP.
PUT STREAM str-out UNFORMATTED '4 - THE DELIVERY ADDRESS MUST BE USED' SKIP.
PUT STREAM str-out UNFORMATTED '5 - PLEASE RESPECT THE DELIVERY TIMES AS AGREED IN THE PURCHASE ORDER. WE WILL NOT ACCEPT EARLY BILLING. BILL ONLY AFTER THE VEHICLE ARRIVES AT THE PRODUCT COLLECTION PLACE.' SKIP.
PUT STREAM str-out UNFORMATTED '6 - VISIT OUR WEBSITE FOR MORE INFORMATION: WWW.SOMESITE.COM.BR' SKIP.

PUT STREAM str-out UNFORMATTED '</pre>' SKIP.

PUT STREAM str-out UNFORMATTED '    </div>' SKIP.

PUT STREAM str-out UNFORMATTED '    <div id="report-comentarios" class="container">' SKIP.

PUT STREAM str-out UNFORMATTED '        <p class="lead text-center">Coments</p>' SKIP.
PUT STREAM str-out UNFORMATTED '        <pre>' SKIP.

PUT STREAM str-out UNFORMATTED 'Fiscal Document: 902' SKIP.
PUT STREAM str-out UNFORMATTED 'Responsible Buyer: VAR' SKIP.
PUT STREAM str-out UNFORMATTED 'E-procurement number: 78995554' SKIP.

PUT STREAM str-out UNFORMATTED '        </pre>' SKIP.

PUT STREAM str-out UNFORMATTED '    </div>' SKIP.

PUT STREAM str-out UNFORMATTED '    <div id="report-assinaturas" class="container">' SKIP.

PUT STREAM str-out UNFORMATTED '        <table class="table table-borderless">' SKIP.
PUT STREAM str-out UNFORMATTED '            <tr>' SKIP.
PUT STREAM str-out UNFORMATTED '                <td><div>Verified by</div></td>' SKIP.
PUT STREAM str-out UNFORMATTED '                <td><div>Manager</div></td>' SKIP.
PUT STREAM str-out UNFORMATTED '                <td><div>Director</div></td>' SKIP.
PUT STREAM str-out UNFORMATTED '            </tr>' SKIP.
PUT STREAM str-out UNFORMATTED '        </table>' SKIP.

PUT STREAM str-out UNFORMATTED '        <hr />' SKIP.

PUT STREAM str-out UNFORMATTED '        <p class="lead text-right">Total: ' TRIM(STRING(deTotal, "->>,>>>,>>>,>>9.99")) '</p>' SKIP.

PUT STREAM str-out UNFORMATTED '    </div>' SKIP.

PUT STREAM str-out UNFORMATTED '    <!-- Optional JavaScript -->' SKIP.
PUT STREAM str-out UNFORMATTED '    <!-- jQuery FIRST, THEN Popper.js, THEN Bootstrap JS' SKIP.
PUT STREAM str-out UNFORMATTED '    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>' SKIP.
PUT STREAM str-out UNFORMATTED '    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>' SKIP.
PUT STREAM str-out UNFORMATTED '    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>' SKIP.
PUT STREAM str-out UNFORMATTED '    -->' SKIP.
PUT STREAM str-out UNFORMATTED '</body>' SKIP.
PUT STREAM str-out UNFORMATTED '</html>' SKIP.


OUTPUT STREAM str-out CLOSE.


RUN Robinson/pdfnator/pdfnatorapi2.p (cArquivo,
                                      SESSION:TEMP-DIRECTORY + cBaseArq + ".pdf",
                                      "",
                                      TRUE,
                                      0,
                                      1,
                                      "Purchase Order 387.603",
                                      TRUE).
