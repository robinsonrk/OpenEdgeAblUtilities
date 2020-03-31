/*------------------------------------------------------------------------
    File        : pdfnatorapi2.p
    Description : Generates a PDF file from data

    Syntax      :

        INPUT   pcHtmlToConvert     CHARACTER   mandatory
            Full or ralative path to the HTML file to be converted
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

    Author(s)   : Robinson Koprowski
    Created     : Fri Mar 06 17:28:47 BRT 2020

    Notes       :

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities


        This program converts a HTML file into a PDF.

        The Web Kit HTML To PDF (wkhtmltopdf - https://wkhtmltopdf.org/)
        utility is used to convert this HTML file into a PDF file.
        This tool must be downloaded and put in a path with runtime
        access. The *wkhtmltopdf* file path must be ajusted in
        configuration table.

        Optionally the generated PDF file can be openned on a PDF Viwer
        or sent directly to a printer.

        You can use your PDF Viewer of preference ajusting the
        *pdfviewer* key on configuration table.

        Use the pdfnatorconfig.w to adjust all the configurations needed
        before executing this api.

        Errors will be sent to log.

  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.


/* ********************  Preprocessor Definitions  ******************** */

&GLOBAL-DEFINE PDFNATORPATH Robinson/pdfnator
&GLOBAL-DEFINE GLOBALCONFIGPATH Robinson/globalconfig
&GLOBAL-DEFINE ABLENVIRONMENTPATH 
&GLOBAL-DEFINE LOGABLERRORSPATH Robinson/logablerrors

{{&GLOBALCONFIGPATH}/globalconfig.i}


/* ***************************  Definitions  ************************** */

DEFINE INPUT  PARAMETER pcHtmlToConvert         AS CHARACTER    NO-UNDO.
DEFINE INPUT  PARAMETER pcFileDestiny           AS CHARACTER    NO-UNDO.
DEFINE INPUT  PARAMETER pcPrinterName           AS CHARACTER    NO-UNDO.
DEFINE INPUT  PARAMETER plOpenOnPdfViewer       AS LOGICAL      NO-UNDO.
DEFINE INPUT  PARAMETER piPageOffset            AS INTEGER      NO-UNDO.
DEFINE INPUT  PARAMETER piNumCopies             AS INTEGER      NO-UNDO.
DEFINE INPUT  PARAMETER pcHeaderTitle           AS CHARACTER    NO-UNDO.
DEFINE INPUT  PARAMETER plDeleteSource          AS LOGICAL      NO-UNDO.



DEFINE VARIABLE cTempDir            AS CHARACTER    NO-UNDO.

DEFINE VARIABLE cUtilityPath        AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cUtilityParams      AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cPdfViewerPath      AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cViewMode           AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cViewerParameters   AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cPrintMode          AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cPdfPrinterParams   AS CHARACTER    NO-UNDO.

DEFINE STREAM str-model.
DEFINE STREAM str-temp.


/* ***************************  Main Block  *************************** */

RUN initializeEnvironment IN THIS-PROCEDURE.

RUN initializePdfFileName IN THIS-PROCEDURE.

RUN generatePdfFile IN THIS-PROCEDURE.

IF pcPrinterName <> "" THEN
    RUN printPdfFile IN THIS-PROCEDURE.

&IF "{&WINDOW-SYSTEM}" <> "TTY" &THEN

IF plOpenOnPdfViewer THEN
    RUN openPdfFile IN THIS-PROCEDURE.

&ENDIF

RETURN "".


/* **********************  Internal procedures  *********************** */

PROCEDURE initializeEnvironment:

    DEFINE VARIABLE cInitialized    AS CHARACTER    NO-UNDO.
    DEFINE VARIABLE cStationName    AS CHARACTER    NO-UNDO.
    DEFINE VARIABLE cPdfViewerType  AS CHARACTER    NO-UNDO.


    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.wkhtmltopdf32;global.wkhtmltopdf64", OUTPUT cInitialized).
    IF cInitialized = ? THEN DO :
&IF "{&STORAGE}" = "memory" &THEN
        RUN {&PDFNATORPATH}/initpdfnatorconfigs.p.
&ELSE
        RUN {&LOGABLERRORSPATH}/log.p ("PDFNator configs not initialized yet. Please, execute {&PDFNATORPATH}/pdfnatorconfig.w.").
        RETURN ERROR.
&ENDIF
    END.

&IF "{&WINDOW-SYSTEM}" = "TTY" &THEN
    ASSIGN cStationName = OS-GETENV("HOSTNAME").
&ELSE
    ASSIGN cStationName = OS-GETENV("COMPUTERNAME").
&ENDIF


    IF SEARCH(pcHtmlToConvert) = ? THEN DO:
        RUN {&LOGABLERRORSPATH}/log.p (SUBSTITUTE("HTML file to be converted not found. &1", pcHtmlToConvert)).
        RETURN ERROR.
    END.

    RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".wkhtmltopdf;global.wkhtmltopdf" + STRING(PROCESS-ARCHITECTURE), OUTPUT cUtilityPath).
    ASSIGN cUtilityPath = "~"" + SEARCH(cUtilityPath) + "~"".
    IF cUtilityPath = ? THEN DO:
        RUN {&LOGABLERRORSPATH}/log.p (SUBSTITUTE("wkhtmltopdf utility path not found in config-sistema table to station &1 and process architecture &2", cStationName, PROCESS-ARCHITECTURE)).
        RETURN ERROR.
    END.

    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.wkhtmltopdfparameters", OUTPUT cUtilityParams).
    IF cUtilityParams = ? THEN DO:
        RUN {&LOGABLERRORSPATH}/log.p ("wkhtmltopdf utility parameters not found in config-sistema table").
        RETURN ERROR.
    END.

&IF "{&WINDOW-SYSTEM}" <> "TTY" &THEN

    IF pcPrinterName <> "" THEN DO:
        RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".printmode;global.pdfprinter.mode", OUTPUT cPrintMode). /*acrord.comobj, command.copy, command.viewer*/
        IF NOT CAN-DO ("acrord.comobj,command.copy,command.viewer", cPrintMode) THEN DO:
            RUN {&LOGABLERRORSPATH}/log.p ("print mode for pdf files was not set, using command.copy instead").
            ASSIGN cPrintMode = "command.copy".
        END.
    END.

    IF (pcPrinterName <> "" AND cPrintMode = "command.viewer") OR plOpenOnPdfViewer THEN DO:

        RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".pdfviewer.type;global.pdfviewer.type", OUTPUT cPdfViewerType).
        IF NOT CAN-DO ("acrord,sumatra", cPdfViewerType) THEN DO:
            RUN {&LOGABLERRORSPATH}/log.p (SUBSTITUTE("PDF Viewer Type not found in config-sistema table to station &1 and process architecture &2", cStationName, PROCESS-ARCHITECTURE)).
            RETURN ERROR.
        END.

        RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".pdfviewer.path." + cPdfViewerType + ";global.pdfviewer" + STRING(PROCESS-ARCHITECTURE) + ".path." + cPdfViewerType, OUTPUT cPdfViewerPath).
        ASSIGN cPdfViewerPath = "~"" + SEARCH(cPdfViewerPath) + "~"".
        IF cPdfViewerPath = ? THEN DO:
            RUN {&LOGABLERRORSPATH}/log.p (SUBSTITUTE("PDF Viewer utility path not found in config-sistema table to station &1 and process architecture &2", cStationName, PROCESS-ARCHITECTURE)).
            RETURN ERROR.
        END.

        RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".pdfviewer.openingmode;global.pdfviewer.openingmode", OUTPUT cViewMode).
        IF NOT CAN-DO("auto,viewer", cViewMode) THEN DO:
            ASSIGN cViewMode = "auto".
            RUN {&LOGABLERRORSPATH}/log.p ("Incorrect information for PDF opening mode. Using 'auto'.").
        END.

        IF cViewMode <> "auto" THEN DO:

            RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".pdfviewer.parameters." + cPdfViewerType + ";global.pdfviewer.parameters." + cPdfViewerType, OUTPUT cViewerParameters).
            IF cViewerParameters = ? THEN DO:
                RUN {&LOGABLERRORSPATH}/log.p (SUBSTITUTE("PDF Viewer opening parameters not set in config-sistema table to station &1", cStationName)).
                RETURN ERROR.
            END.

        END.

    END.

    IF pcPrinterName = "default" AND cPrintMode <> "acrord.comobj" THEN DO:
        RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".pdfprinter.name;global.pdfprinter.name", OUTPUT pcPrinterName).
        IF pcPrinterName = ? THEN DO:
            RUN {&LOGABLERRORSPATH}/log.p ("PDF default printer not found in config-sistema table").
            RETURN ERROR.
        END.
    END.

&ENDIF

    IF pcPrinterName <> "" AND cPrintMode = "command.viewer" THEN DO:
        RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.pdfviewer.printparameters." + cPdfViewerType, OUTPUT cPdfPrinterParams).
        IF cPdfPrinterParams = ? THEN DO:
            RUN {&LOGABLERRORSPATH}/log.p ("PDF printer parameters not found in config-sistema table").
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


PROCEDURE initializePdfFileName:

    IF pcFileDestiny = "" THEN DO:

        DEFINE VARIABLE iSeqTempFile AS INTEGER NO-UNDO.

        RUN initializeTempDir IN THIS-PROCEDURE.

        DO WHILE SEARCH(cTempDir + "/temp-" + STRING(iSeqTempFile, "999999") + ".pdf") <> ?:
            ASSIGN iSeqTempFile = iSeqTempFile + 1.
        END.

        ASSIGN pcFileDestiny = cTempDir + "/temp-" + STRING(iSeqTempFile) + ".pdf".

    END.

END PROCEDURE.


PROCEDURE generatePdfFile:

    DEFINE VARIABLE cCommandLine       AS CHARACTER NO-UNDO.
    DEFINE VARIABLE cCommandParameters AS CHARACTER NO-UNDO.

    ASSIGN cUtilityParams = REPLACE(cUtilityParams, "[pageoffset]", STRING(piPageOffset))
           cUtilityParams = REPLACE(cUtilityParams, "[fileorig]", pcHtmlToConvert)
           cUtilityParams = REPLACE(cUtilityParams, "[filedest]", pcFileDestiny)
           cUtilityParams = REPLACE(cUtilityParams, "[headertitle]", pcHeaderTitle).

    ASSIGN cCommandLine = cUtilityPath + " " + cUtilityParams.

&IF "{&WINDOW-SYSTEM}" <> "TTY" &THEN
    RUN runProcess (INPUT cCommandLine, 30000). /*wait 30 seconds*/
&ELSE
    OS-COMMAND SILENT VALUE(cCommandLine).
&ENDIF

    IF plDeleteSource THEN
        OS-DELETE VALUE(pcHtmlToConvert).

END PROCEDURE.


PROCEDURE printPdfFile:

&IF "{&WINDOW-SYSTEM}" <> "TTY" &THEN

    CASE cPrintMode: /*, command.copy, */
        WHEN "acrord.comobj" THEN RUN printPdfFileCom IN THIS-PROCEDURE.
        WHEN "command.viewer" THEN RUN printPdfFileViewer IN THIS-PROCEDURE.
        WHEN "command.copy" THEN RUN printPdfFileCopy IN THIS-PROCEDURE.
    END CASE.

&ELSE

    RUN printPdfFileCopy IN THIS-PROCEDURE.

&ENDIF

END PROCEDURE.


&IF "{&WINDOW-SYSTEM}" <> "TTY" &THEN

PROCEDURE printPdfFileCom:

    DEFINE VARIABLE hAcroExchAVDocs AS COM-HANDLE   NO-UNDO.
    DEFINE VARIABLE hAcroExchPDDoc  AS COM-HANDLE   NO-UNDO.
    DEFINE VARIABLE hAcroExchApp    AS COM-HANDLE   NO-UNDO.
    DEFINE VARIABLE iNumberOfPages  AS INTEGER      NO-UNDO.

    /* Create required Acrobat object instances */
    CREATE "AcroExch.App" hAcroExchApp.
    CREATE "AcroExch.AVDoc" hAcroExchAVDocs.
    CREATE "AcroExch.PDDoc" hAcroExchPDDoc.

    hAcroExchAVDocs:Open ("~"" + pcFileDestiny + "~"", "").
    ASSIGN hAcroExchPDDoc = hAcroExchAVDocs:GetPDDoc
           iNumberOfPages = hAcroExchPDDoc:GetNumPages.

    /* Internal Adobe page numbering starts at 0 */
    hAcroExchAVDocs:PrintPages(0, iNumberOfPages - 1, 2, TRUE, FALSE).
    hAcroExchAVDocs:Close(TRUE).

    /* Close the acrobat application */
    hAcroExchApp:EXIT.

    /* Perform cleanup and housekeeping */
    RELEASE OBJECT hAcroExchAVDocs.
    RELEASE OBJECT hAcroExchPDDoc.
    RELEASE OBJECT hAcroExchApp.

END PROCEDURE.


PROCEDURE printPdfFileViewer:

    DEFINE VARIABLE cCommandLine    AS CHARACTER    NO-UNDO.
    DEFINE VARIABLE iCont           AS INTEGER      NO-UNDO.

    ASSIGN cPdfPrinterParams = REPLACE (cPdfPrinterParams, "[printername]", pcPrinterName)
           cPdfPrinterParams = REPLACE (cPdfPrinterParams, "[filename]", pcFileDestiny).

    ASSIGN cCommandLine = cPdfViewerPath + " " + cPdfPrinterParams.

    DO iCont = 1 TO piNumCopies:
        RUN runProcess (INPUT cCommandLine, 30000).
    END.

END PROCEDURE.

&ENDIF


PROCEDURE printPdfFileCopy:

    DEFINE VARIABLE iCont           AS INTEGER      NO-UNDO.

&IF "{&WINDOW-SYSTEM}" <> "TTY" &THEN

    DO iCont = 1 TO piNumCopies:
        OS-COPY VALUE ("~"" + pcFileDestiny + "~"") VALUE ("~"" + pcPrinterName + "~"").
    END.

&ELSE

    DEFINE VARIABLE cCommandLine    AS CHARACTER    NO-UNDO.

    ASSIGN cCommandLine = "lp -d ~"<printer-name>~" ~"<pdf_file_name>~""
           cCommandLine = REPLACE(cCommandLine, "<printer-name>", pcPrinterName)
           cCommandLine = REPLACE(cCommandLine, "<pdf_file_name>", pcFileDestiny).

    DO iCont = 1 TO piNumCopies:
        OS-COMMAND NO-WAIT VALUE(cCommandLine).
    END.

&ENDIF

END PROCEDURE.

&IF "{&WINDOW-SYSTEM}" <> "TTY" &THEN

PROCEDURE openPdfFile:

    DEFINE VARIABLE hInstance       AS INTEGER      NO-UNDO.
    DEFINE VARIABLE cCommandLine    AS CHARACTER    NO-UNDO.

    IF cViewMode = "auto" THEN
        ASSIGN cCommandLine = "~"" + pcFileDestiny + "~"".
    ELSE
        ASSIGN cCommandLine = cPdfViewerPath + " " + cViewerParameters
               cCommandLine = REPLACE(cCommandLine, "[filename]", pcFileDestiny).

    RUN ShellExecuteA (INPUT 0,
                       INPUT "open",
                       INPUT pcFileDestiny,
                       INPUT "",
                       INPUT "",
                       INPUT 0,
                       OUTPUT hInstance).

END PROCEDURE.

&ENDIF

{{&GLOBALCONFIGPATH}/externalproc.i &runProcess=ENABLE
                                    &ShellExecuteA=ENABLE}

