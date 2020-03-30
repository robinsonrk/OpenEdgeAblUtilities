/*------------------------------------------------------------------------
    File        : esppdfapi.p
    Description : Generates a PDF file from merging data in a
                  HTML model file

    Syntax      :

        INPUT   pcHtmlModelFile     CHARACTER   mandatory
            Full or ralative path to the HTML file to be used as model
        INPUT   pcFileDestiny       CHARACTER   optional
            The full name and path to the PDF file to be generated.
            If a blank value is passed, a file in WORKDIR is generated
            just for printing of viewing purposes.
        INPUT   pcPrinterName       CHARACTER   optional
            Printer name or path to be used when printing.
            If no value is infomed, the file will not be printed.
            To use the default configuration, the "default" string
            must be used.
        INPUT   plOpenOnPdfViewer   LOGICAL     optional
            When TRUE the PDF file is opened in PDF Viewer.
        INPUT   piPageOffset        INTEGER     optional
            The starter page number printed on page
        INPUT   piNumCopies         INTEGER     optional
            Number of copies when printing
        INPUT   pcHeaderFile        CHARACTER   optional
            The text to be printed on PDF's left top margin.
        INPUT   plDeleteSource      LOGICAL     optional
            Delete the HTML file after being converted to PDF.
        INPUT   ttHtmlFields        TABLE       optional
            A temporary table with field/values to be replaced in
            HTML model file.

    Author(s)   : Robinson Koprowski
    Created     : Fri Feb 21 11:05:24 BRT 2020

    Notes       :

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities


        This source receives data, merge it into a model and generates a
        temporary HTML file.

        The generatted HTML file will be sent to pdfnatorapi2.p to be
        converted into a PDF file.

        Errors will be sent to log.

  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.


/* ********************  Preprocessor Definitions  ******************** */

{Robinson/globalconfig/globalconfig.i}


/* ***************************  Definitions  ************************** */

{Robinson/pdfnator/pdfnatorapi.i}
{src/web/method/cgidefs.i}


DEFINE INPUT  PARAMETER pcHtmlModelFile         AS CHARACTER    NO-UNDO.
DEFINE INPUT  PARAMETER pcFileDestiny           AS CHARACTER    NO-UNDO.
DEFINE INPUT  PARAMETER pcPrinterName           AS CHARACTER    NO-UNDO.
DEFINE INPUT  PARAMETER plOpenOnPdfViewer       AS LOGICAL      NO-UNDO.
DEFINE INPUT  PARAMETER piPageOffset            AS INTEGER      NO-UNDO.
DEFINE INPUT  PARAMETER piNumCopies             AS INTEGER      NO-UNDO.
DEFINE INPUT  PARAMETER pcHeaderTitle           AS CHARACTER    NO-UNDO.
DEFINE INPUT  PARAMETER plDeleteSource          AS LOGICAL      NO-UNDO.
DEFINE INPUT  PARAMETER TABLE FOR ttHtmlFields.


DEFINE VARIABLE cTempDir            AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cTempHtml           AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cUtilityPath        AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cUtilityParams      AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cPdfViewerPath      AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cPdfViewerParams    AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cPdfPrinterParams   AS CHARACTER    NO-UNDO.

DEFINE STREAM str-model.
DEFINE STREAM str-temp.


/* ***************************  Main Block  *************************** */

RUN initializeEnvironment IN THIS-PROCEDURE.

RUN initializeTempDir IN THIS-PROCEDURE.
RUN initializeTempHtmlFileName IN THIS-PROCEDURE.
RUN initializePdfFileName IN THIS-PROCEDURE.

RUN generateTempHtmlFile IN THIS-PROCEDURE.

RUN Robinson/pdfnator/pdfnatorapi2.p (cTempHtml,
                                      pcFileDestiny,
                                      pcPrinterName,
                                      plOpenOnPdfViewer,
                                      piPageOffset,
                                      piNumCopies,
                                      pcHeaderTitle,
                                      plDeleteSource).

RETURN "".


/* **********************  Internal procedures  *********************** */

PROCEDURE initializeEnvironment:

    IF SEARCH(pcHtmlModelFile) = ? THEN DO:
        RUN Robinson/logablerrors/log.p (SUBSTITUTE("HTML model file not found. &1", pcHtmlModelFile)).
        RETURN ERROR.
    END.

END PROCEDURE.


PROCEDURE initializeTempDir:

    DEFINE VARIABLE cFileLock   AS CHARACTER    NO-UNDO.

    ASSIGN cTempDir = SESSION:TEMP-DIRECTORY + "pdf-utility"
           cFileLock = cTempDir + "/_THIS_DIRECTORY_CAN_BE_SAFELY_DELETED.txt".

    IF SEARCH(cFileLock) = ? THEN DO:
        OS-CREATE-DIR VALUE(cTempDir).
        DO ON ERROR UNDO, LEAVE:
            OUTPUT STREAM str-temp TO VALUE(cFileLock) CONVERT TARGET "UTF-8".
            PUT STREAM str-temp UNFORMATTED "This directory is used to put temporary files from generating PDF files by PDFNator OpenEdge ABL Utility and can be safely deleted.".
            OUTPUT STREAM str-temp CLOSE.
        END.
    END.

    IF SEARCH(cFileLock) = ? THEN
        ASSIGN cTempDir = SESSION:TEMP-DIRECTORY.

END PROCEDURE.


PROCEDURE initializeTempHtmlFileName:

    DEFINE VARIABLE iSeqTempFile AS INTEGER NO-UNDO.

    DO WHILE SEARCH(cTempDir + "/temp-" + STRING(iSeqTempFile) + ".html") <> ?:
        ASSIGN iSeqTempFile = iSeqTempFile + 1.
    END.

    ASSIGN cTempHtml = cTempDir + "/temp-" + STRING(iSeqTempFile) + ".html".

END PROCEDURE.


PROCEDURE initializePdfFileName:

    IF pcFileDestiny = "" THEN DO:

        DEFINE VARIABLE iSeqTempFile AS INTEGER NO-UNDO.

        DO WHILE SEARCH(cTempDir + "/temp-" + STRING(iSeqTempFile, "999999") + ".pdf") <> ?:
            ASSIGN iSeqTempFile = iSeqTempFile + 1.
        END.

        ASSIGN pcFileDestiny = cTempDir + "/temp-" + STRING(iSeqTempFile) + ".pdf".

    END.

END PROCEDURE.


PROCEDURE generateTempHtmlFile:

    DEFINE VARIABLE cLinha AS CHARACTER NO-UNDO.

    INPUT STREAM str-model FROM VALUE(SEARCH(pcHtmlModelFile)) CONVERT SOURCE "UTF-8".
    OUTPUT STREAM str-temp TO VALUE(cTempHtml) CONVERT TARGET "UTF-8".

    REPEAT:
        IMPORT STREAM str-model UNFORMATTED cLinha.

        FOR EACH ttHtmlFields NO-LOCK:
            ASSIGN cLinha = REPLACE(cLinha, "[" + ttHtmlFields.htmlfield + "]", html-encode(ttHtmlFields.htmlvalue)).
        END.

        PUT STREAM str-temp UNFORMATTED cLinha SKIP.

    END.

    INPUT STREAM str-model CLOSE.
    OUTPUT STREAM str-temp CLOSE.

END PROCEDURE.
