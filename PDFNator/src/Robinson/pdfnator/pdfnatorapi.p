/*------------------------------------------------------------------------
    File        : esppdfapi.p
    Description : Generates a PDF file from data

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

        The Web Kit HTML To PDF (wkhtmltopdf - https://wkhtmltopdf.org/)
        utility is used to convert this temporary HTML file to a PDF file.
        This tool must be downloaded and put in a path with runtime
        access. The *wkhtmltopdf* file path must be ajusted in
        configuration table.

        Optionally the generated PDF file can be openned on a PDF Viwer
        or sent directly to a printer.

        You can use your PDF Viewer of preference ajusting the
        *pdfviewer* key on configuration table.

        Errors will be sent to log.

  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.


/* ********************  Preprocessor Definitions  ******************** */

{Robinson/globalconfig/globalconfig.i}


/* ***************************  Definitions  ************************** */

{Robinson/pdfnator/pdfnatorapi.i}
/*{src/web/method/cgidefs.i}*/


DEFINE INPUT  PARAMETER pcHtmlModelFile         AS CHARACTER    NO-UNDO.
DEFINE INPUT  PARAMETER pcFileDestiny           AS CHARACTER    NO-UNDO.
DEFINE INPUT  PARAMETER pcPrinterName           AS CHARACTER    NO-UNDO.
DEFINE INPUT  PARAMETER plOpenOnPdfViewer       AS LOGICAL      NO-UNDO.
DEFINE INPUT  PARAMETER piPageOffset            AS INTEGER      NO-UNDO.
DEFINE INPUT  PARAMETER piNumCopies             AS INTEGER      NO-UNDO.
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

RUN generatePdfFile IN THIS-PROCEDURE.

IF pcPrinterName <> "" THEN
    RUN printPdfFile IN THIS-PROCEDURE.

IF plOpenOnPdfViewer THEN
    RUN openPdfFile IN THIS-PROCEDURE.

RETURN "".


/* **********************  Internal procedures  *********************** */

PROCEDURE initializeEnvironment:

    DEFINE VARIABLE cStationName AS CHARACTER NO-UNDO.

&IF "{&WINDOW-SYSTEM}" = "TTY" &THEN
    ASSIGN cStationName = OS-GETENV("HOSTNAME").
&ELSE
    ASSIGN cStationName = OS-GETENV("COMPUTERNAME").
&ENDIF


&IF "{&STORAGE}" <> "database" &THEN
    RUN Robinson/globalconfig/setconfig.p ("station." + cStationName + ".wkhtmltopdf", SEARCH("wkhtmltox64/bin/wkhtmltopdf.exe")).
    RUN Robinson/globalconfig/setconfig.p ("global.wkhtmltopdf32", SEARCH("wkhtmltox32/bin/wkhtmltopdf.exe")).
    RUN Robinson/globalconfig/setconfig.p ("global.wkhtmltopdf64", SEARCH("wkhtmltox64/bin/wkhtmltopdf.exe")).
    RUN Robinson/globalconfig/setconfig.p ("global.wkhtmltopdfparameters", "--page-size A3 --copies 1 --page-offset [pageoffset] --header-right ~"Page [page] from [toPage]~" ~"[fileorig]~" ~"[filedest]~""). //page and toPage will be filled by wkhtmltopdf
    RUN Robinson/globalconfig/setconfig.p ("station." + cStationName + ".pdfviewer", "C:~\Program Files~\SumatraPDF~\SumatraPDF.exe").
    RUN Robinson/globalconfig/setconfig.p ("global.pdfviewer32", "C:~\Program Files (x86)~\SumatraPDF~\SumatraPDF.exe").
    RUN Robinson/globalconfig/setconfig.p ("global.pdfviewer64", "C:~\Program Files~\SumatraPDF~\SumatraPDF.exe").
    RUN Robinson/globalconfig/setconfig.p ("global.pdfviewerparameters", "~"[filename]~"").
    RUN Robinson/globalconfig/setconfig.p ("station." + cStationName + ".pdfprinter", "HP Deskjet 4620 series (Rede)"). //"~\~\printserver~\pdfprinter"
    RUN Robinson/globalconfig/setconfig.p ("global.pdfprinter", "~\~\printserver~\pdfprinter").
    RUN Robinson/globalconfig/setconfig.p ("global.pdfprinterparameters", "-print-to [printername] -print-settings ~"[numcopies]x~" -silent ~"[filename]~"").
&ENDIF


    IF SEARCH(pcHtmlModelFile) = ? THEN DO:
        RUN Robinson/logablerrors/log.p (SUBSTITUTE("HTML model file not found. &1", pcHtmlModelFile)).
        RETURN ERROR.
    END.

    RUN Robinson/globalconfig/getconfig.p ("station." + cStationName + ".wkhtmltopdf;global.wkhtmltopdf" + STRING(PROCESS-ARCHITECTURE), OUTPUT cUtilityPath).
    IF SEARCH(cUtilityPath) = ? THEN DO:
        RUN Robinson/logablerrors/log.p (SUBSTITUTE("wkhtmltopdf utility path not found in config-sistema table to station &1 and process architecture &2", cStationName, PROCESS-ARCHITECTURE)).
        RETURN ERROR.
    END.

    RUN Robinson/globalconfig/getconfig.p ("station." + cStationName + ".wkhtmltopdfparameters;global.wkhtmltopdfparameters", OUTPUT cUtilityParams).
    IF cUtilityParams = ? THEN DO:
        RUN Robinson/logablerrors/log.p ("wkhtmltopdf utility parameters not found in config-sistema table").
        RETURN ERROR.
    END.

    IF pcPrinterName <> "" OR plOpenOnPdfViewer THEN DO:
        RUN Robinson/globalconfig/getconfig.p ("station." + cStationName + ".pdfviewer;global.pdfviewer" + STRING(PROCESS-ARCHITECTURE), OUTPUT cPdfViewerPath).
        IF SEARCH(cPdfViewerPath) = ? THEN DO:
            RUN Robinson/logablerrors/log.p (SUBSTITUTE("PDF Viewer utility path not found in config-sistema table to station &1 and process architecture &2", cStationName, PROCESS-ARCHITECTURE)).
            RETURN ERROR.
        END.

        RUN Robinson/globalconfig/getconfig.p ("station." + cStationName + ".pdfviewerparameters;global.pdfviewerparameters", OUTPUT cPdfViewerParams).
        IF cPdfViewerParams = ? THEN DO:
            RUN Robinson/logablerrors/log.p ("PDF Viewer parameters not found in config-sistema table").
            RETURN ERROR.
        END.

    END.

    IF pcPrinterName = "default" THEN DO:
        RUN Robinson/globalconfig/getconfig.p ("station." + cStationName + ".pdfprinter;global.pdfprinter", OUTPUT pcPrinterName).
        IF pcPrinterName = ? THEN DO:
            RUN Robinson/logablerrors/log.p ("PDF default printer not found in config-sistema table").
            RETURN ERROR.
        END.
    END.

    IF pcPrinterName <> "" THEN DO:
        RUN Robinson/globalconfig/getconfig.p ("station." + cStationName + ".pdfprinterparameters;global.pdfprinterparameters", OUTPUT cPdfPrinterParams).
        IF cPdfPrinterParams = ? THEN DO:
            RUN Robinson/logablerrors/log.p ("PDF printer parameters not found in config-sistema table").
            RETURN ERROR.
        END.
    END.

    IF piNumCopies < 1 THEN
        ASSIGN piNumCopies = 1.

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
            ASSIGN cLinha = REPLACE(cLinha, "[" + ttHtmlFields.htmlfield + "]", /*html-encode(*/ ttHtmlFields.htmlvalue /*)*/ ).
        END.

        PUT STREAM str-temp UNFORMATTED cLinha SKIP.

    END.

    INPUT STREAM str-model CLOSE.
    OUTPUT STREAM str-temp CLOSE.

END PROCEDURE.


PROCEDURE generatePdfFile:

    DEFINE VARIABLE cCommandLine       AS CHARACTER NO-UNDO.
    DEFINE VARIABLE cCommandParameters AS CHARACTER NO-UNDO.

    ASSIGN cUtilityParams = REPLACE (cUtilityParams, "[pageoffset]", STRING(piPageOffset))
           cUtilityParams = REPLACE (cUtilityParams, "[fileorig]", cTempHtml)
           cUtilityParams = REPLACE (cUtilityParams, "[filedest]", pcFileDestiny).

    ASSIGN cCommandLine = cUtilityPath + " " + cUtilityParams.

&IF "{&WINDOW-SYSTEM}" <> "TTY" &THEN
    RUN WinExec (INPUT cCommandLine, INPUT 0).
&ELSE
    OS-COMMAND NO-WAIT VALUE(cCommandLine).
&ENDIF

END PROCEDURE.


PROCEDURE printPdfFile:

    DEFINE VARIABLE cCommandLine AS CHARACTER NO-UNDO.

    ASSIGN cPdfPrinterParams = REPLACE (cPdfPrinterParams, "[printername]", pcPrinterName)
           cPdfPrinterParams = REPLACE (cPdfPrinterParams, "[numcopies]", STRING(piNumCopies))
           cPdfPrinterParams = REPLACE (cPdfPrinterParams, "[filename]", pcFileDestiny).

    ASSIGN cCommandLine = cPdfViewerPath + " " + cPdfPrinterParams.

&IF "{&WINDOW-SYSTEM}" <> "TTY" &THEN
    RUN WinExec (INPUT cCommandLine, INPUT 0).
&ELSE
    OS-COMMAND NO-WAIT VALUE(cCommandLine).
&ENDIF

END PROCEDURE.


PROCEDURE openPdfFile:

    DEFINE VARIABLE cCommandLine AS CHARACTER NO-UNDO.

    ASSIGN cPdfViewerParams = REPLACE (cPdfViewerParams, "[filename]", pcFileDestiny).

    ASSIGN cCommandLine = cPdfViewerPath + " " + cPdfViewerParams.

&IF "{&WINDOW-SYSTEM}" <> "TTY" &THEN
    RUN WinExec (INPUT cCommandLine, INPUT 0).
&ELSE
    OS-COMMAND NO-WAIT VALUE(cCommandLine).
&ENDIF

END PROCEDURE.


&IF "{&WINDOW-SYSTEM}" <> "TTY" &THEN
PROCEDURE WinExec EXTERNAL "kernel32.dll":
    DEFINE INPUT  PARAMETER prog_name    AS CHARACTER    NO-UNDO.
    DEFINE INPUT  PARAMETER visual_style AS SHORT        NO-UNDO.
END PROCEDURE.
&ENDIF
