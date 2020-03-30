/*------------------------------------------------------------------------
    File        : getconfig.p
    Purpose     : Get config value from configuration table
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Tue Feb 25 17:04:38 BRT 2020
    Notes       :

        You can past more than one configuration at once in a semicolon
        separated list, but only the first match will be returned.
        It is useful when you try to get a more especific configuration
        and a default configuration. If the first one could not be found
        then try to get the second and so on.

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */

&GLOBAL-DEFINE ABLENVIRONMENTPATH
&GLOBAL-DEFINE GLOBALCONFIGPATH Robinson/globalconfig

{{&GLOBALCONFIGPATH}/storageconfig.i}


/* ***************************  Definitions  ************************** */

DEFINE INPUT  PARAMETER pcKeyList   AS CHARACTER    NO-UNDO.
DEFINE OUTPUT PARAMETER pcValue     AS CHARACTER    NO-UNDO INITIAL ?.


DEFINE VARIABLE iKeyIndex AS INTEGER NO-UNDO.


/* ***************************  Main Block  *************************** */

DO iKeyIndex = 1 TO NUM-ENTRIES(pcKeyList, ";"):
    FIND {&CONFIGURATIONTABLE} NO-LOCK WHERE {&CONFIGURATIONTABLE}.{&CONFIGURATIONKEY} = ENTRY(iKeyIndex, pcKeyList, ";") NO-ERROR.
    IF AVAILABLE {&CONFIGURATIONTABLE} THEN DO:
        ASSIGN pcValue = {&CONFIGURATIONTABLE}.{&CONFIGURATIONVALUE}.
        RETURN.
    END.
END.
