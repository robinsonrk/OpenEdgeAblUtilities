/*------------------------------------------------------------------------
    File        : initpdfnatorconfigs.p
    Description : Initializes PDFNator configs
    Syntax      :
    Author(s)   : Robinson Koprowski
    Created     : Mon Mar 30 18:27:00 BRT 2020

    Notes       :

        In production, this program must be executed once.
        After that, please, use pdfnatorconfig.w to edit configurations.

        It will override all configurations to default values.

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.


/* ********************  Preprocessor Definitions  ******************** */

&GLOBAL-DEFINE GLOBALCONFIGPATH Robinson/globalconfig
&GLOBAL-DEFINE LOGABLERRORSPATH Robinson/logablerrors


/* ***************************  Definitions  ************************** */

DEFINE VARIABLE cStationName    AS CHARACTER    NO-UNDO.


/* ***************************  Main Block  *************************** */

RUN {&LOGABLERRORSPATH}/log.p ("Initializing PDFNator configs.").

ASSIGN cStationName = OS-GETENV("COMPUTERNAME").

RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.wkhtmltopdf32", "wkhtmltox32/bin/wkhtmltopdf.exe").
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.wkhtmltopdf64", "wkhtmltox64/bin/wkhtmltopdf.exe").
/*RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".wkhtmltopdf", "wkhtmltox64/bin/wkhtmltopdf.exe").*/
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.wkhtmltopdfparameters", "--quiet --page-size A3 --copies 1 --page-offset [pageoffset] --header-left ~"[headertitle]~" --header-right ~"Page [page] of [toPage]~" ~"[fileorig]~" ~"[filedest]~""). //page and toPage will be filled by wkhtmltopdf
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer.type", "sumatra"). /*acrord,sumatra*/
/*RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".pdfviewer.type", "sumatra").*/
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer32.path.sumatra", "C:~\Program Files (x86)~\SumatraPDF~\SumatraPDF.exe").
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer64.path.sumatra", "C:~\Program Files~\SumatraPDF~\SumatraPDF.exe").
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer32.path.acrord", "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe").
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer64.path.acrord", "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe").
/*RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".pdfviewer.path.sumatra", "C:~\Program Files~\SumatraPDF~\SumatraPDF.exe").
RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".pdfviewer.path.acrord", "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe").*/
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer.openingmode", "auto"). // auto,viewer
/*RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".pdfviewer.openingmode", "auto"). // auto,viewer */
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer.parameters.acrord", "~"[filename]~"").
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer.parameters.sumatra", "~"[filename]~"").
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfprinter.name", "~\~\printserver~\pdfprinter").
/*RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".pdfprinter.name", "HP Deskjet 4620 series (Rede)").*/
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfprinter.mode", "command.viewer"). /*acrord.comobj, command.copy, command.viewer. acrobat reader acrord.comobj must be professional , free reader doesn't work*/
/*RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".pdfprinter.mode", "command.viewer").*/
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer.printparameters.sumatra", "-print-to ~"[printername]~" -silent ~"[filename]~"").
RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer.printparameters.acrord", "/t ~"[filename]~" ~"[printername]~""). /*quando Adobe Reader*/
