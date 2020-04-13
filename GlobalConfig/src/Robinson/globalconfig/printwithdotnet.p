/*------------------------------------------------------------------------
    File        : printingwithdotnet.p
    Purpose     : Print a file with .Net integration
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Tue Apr 03 14:32:00 BRT 2020
    Notes       :

        This procedure was not included in externalproc.i due to
        combatibility with older versions of Progress OpenEdge. In
        case of compatibility issues in your progress version, use
        the alternatives.

        https://knowledgebase.progress.com/articles/Article/000046047

        Example:
        RUN printWithDotNet IN THIS-PROCEDURE ("acrord.dotnet", "file.pdf", "Printer name", 1).
        {Robinson/globalconfig/externalproc.i &printWithDotNet=ENABLED}

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/


/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Definitions  ************************** */

USING System.*.
USING System.Collections.Generic.*.
USING System.Diagnostics.*.
USING System.IO.*.
USING System.Linq.*.
USING System.Text.*.
USING System.Threading.Tasks.*.


DEFINE INPUT PARAMETER pPrintMode   AS CHARACTER    NO-UNDO.
DEFINE INPUT PARAMETER sFileName    AS CHARACTER    NO-UNDO.
DEFINE INPUT PARAMETER sPrinter     AS CHARACTER    NO-UNDO.
DEFINE INPUT PARAMETER iNumCopies   AS INTEGER      NO-UNDO.


DEFINE VARIABLE proc        AS System.Diagnostics.Process           NO-UNDO.
DEFINE VARIABLE startInfo   AS System.Diagnostics.ProcessStartInfo  NO-UNDO.


/* ***************************  Main Block  *************************** */

//TODO implement number of copies. Arguments or Loop?


ASSIGN startInfo = new System.Diagnostics.ProcessStartInfo()
       startInfo:FileName = sFileName.

/* Choose the verb based on whether the file is to be printed to network printer or to the default local printer */
IF sPrinter BEGINS "\\" THEN
    ASSIGN startInfo:Verb = "printto". /* prints to a network printer */
ELSE
    ASSIGN startInfo:Verb = "print". /* prints to the local default printer */

/* To print on a non-default printer with a properly initialized value for sPrinter.*/
IF sPrinter <> "" AND sPrinter <> "default" THEN DO:
    IF pPrintMode = "acrord.dotnet" THEN
        ASSIGN startInfo:Arguments = "~"" + sPrinter + "~"". /*acrord*/
    /*String.Format(@"-t ""{0}"" ""{1}""", this.Path, printerName) Foxit*/
    /*??? sumatra pdf*/
    /*...*/
END.

ASSIGN startInfo:UseShellExecute = TRUE
       startInfo:WindowStyle = System.Diagnostics.ProcessWindowStyle:HIDDEN
       startInfo:CreateNoWindow = TRUE
       proc = System.Diagnostics.Process:Start(startInfo).

/* Wait a maximum of 30 sec for the process to finish*/
/*
proc:WaitForExit(30000).

IF NOT proc:HasExited THEN DO:
    proc:Kill().
    proc:Dispose().
END.
*/
proc:WaitForExit(0).


/* *********************  Procedure Definitions  ********************** */
