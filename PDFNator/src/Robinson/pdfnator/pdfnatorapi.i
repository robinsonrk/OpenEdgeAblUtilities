/*------------------------------------------------------------------------
    File        : esppdfapi.i
    Purpose     : Defines temporary table(s) used by pdfnatorapi.p
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Fri Feb 21 11:05:38 BRT 2020
    Notes       :

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Definitions  ************************** */

DEFINE TEMP-TABLE ttHtmlFields NO-UNDO
    FIELD htmlfield AS CHARACTER
    FIELD htmlvalue AS CHARACTER
    INDEX idHtmlFields AS PRIMARY UNIQUE htmlfield.

/* ***************************  Main Block  *************************** */


/* **********************  Internal procedures  *********************** */

PROCEDURE insertHtmlField:
    DEFINE INPUT  PARAMETER pcCampo AS CHARACTER    NO-UNDO.
    DEFINE INPUT  PARAMETER pcValor AS CHARACTER    NO-UNDO.

    FIND ttHtmlFields WHERE ttHtmlFields.htmlfield = pcCampo NO-ERROR.
    IF pcValor <> ? THEN DO:
        IF NOT AVAILABLE ttHtmlFields THEN DO:
            CREATE ttHtmlFields.
            ASSIGN ttHtmlFields.htmlfield = pcCampo.
        END.
        ASSIGN ttHtmlFields.htmlvalue = pcValor.
    END.
    ELSE IF AVAILABLE ttHtmlFields THEN
        DELETE ttHtmlFields.

END PROCEDURE.

PROCEDURE clearHtmlFields:
    empty temp-table ttHtmlFields.
END PROCEDURE.
