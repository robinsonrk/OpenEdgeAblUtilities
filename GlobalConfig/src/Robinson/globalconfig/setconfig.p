
/*------------------------------------------------------------------------
    File        : setconfig.p
    Purpose     : Sets the configuration key/value pairs in the STORAGE
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Tue Feb 25 17:02:01 BRT 2020
    Notes       :

        Once one keyname can be passed here.
        The configuration value will be serialized and can be retrieved
        later throught its key.

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.


/* ********************  Preprocessor Definitions  ******************** */

{Robinson/globalconfig/storageconfig.i}


/* ***************************  Definitions  ************************** */

DEFINE INPUT  PARAMETER pcKeyName   AS CHARACTER    NO-UNDO.
DEFINE INPUT  PARAMETER pcValue     AS CHARACTER    NO-UNDO.


/* ***************************  Main Block  *************************** */

FIND {&CONFIGURATIONTABLE} EXCLUSIVE-LOCK WHERE {&CONFIGURATIONTABLE}.{&CONFIGURATIONKEY} = pcKeyName NO-ERROR.

IF NOT AVAILABLE {&CONFIGURATIONTABLE} THEN DO:
    CREATE {&CONFIGURATIONTABLE}.
    ASSIGN {&CONFIGURATIONTABLE}.{&CONFIGURATIONKEY} = pcKeyName.
END.

ASSIGN {&CONFIGURATIONTABLE}.{&CONFIGURATIONVALUE} = pcValue.
