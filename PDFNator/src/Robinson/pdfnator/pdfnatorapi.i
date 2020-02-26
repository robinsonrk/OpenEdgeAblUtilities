/*------------------------------------------------------------------------
    File        : esppdfapi.i
    Purpose     : Defines temporary table(s) used by pdfnatorapi
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
