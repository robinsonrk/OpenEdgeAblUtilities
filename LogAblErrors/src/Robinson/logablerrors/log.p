/*------------------------------------------------------------------------
    File        : log.p
    Purpose     : Log messages to a standardized text file
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Tue Feb 25 16:23:38 BRT 2020
    Notes       :

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.


/* ********************  Preprocessor Definitions  ******************** */

&GLOBAL-DEFINE ABLENVIRONMENTPATH
&GLOBAL-DEFINE GLOBALCONFIGPATH Robinson/globalconfig

{{&GLOBALCONFIGPATH}/globalconfig.i}


/* ***************************  Definitions  ************************** */

DEFINE INPUT  PARAMETER pcMessage   AS CHARACTER    NO-UNDO.


DEFINE STREAM str-log.


/* ***************************  Main Block  *************************** */

OUTPUT STREAM str-log TO VALUE({&LOGMESSAGES}) CONVERT TARGET "UTF-8" APPEND.
PUT STREAM str-log UNFORMATTED STRING(TODAY, "99/99/9999") " " STRING(TIME, "HH:MM:SS") " " pcMessage SKIP.
OUTPUT STREAM str-log CLOSE.
