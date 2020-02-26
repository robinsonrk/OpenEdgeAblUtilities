/*------------------------------------------------------------------------
    File        : storageconfig.i
    Purpose     : Defines data storages
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Tue Feb 25 17:46:45 BRT 2020
    Notes       :

        For development/tests purposes, it is possible to define temporary
        tables or other resources to be used as data repository.
        The storage must be ajusted by STORAGE preprocessor
        in local user ablenvironment.i.

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

/* ********************  Preprocessor Definitions  ******************** */

{Robinson/globalconfig/globalconfig.i}


/* ***************************  Definitions  ************************** */

&IF "{&STORAGE}" = "memory" &THEN
DEFINE NEW GLOBAL SHARED TEMP-TABLE {&CONFIGURATIONTABLE} NO-UNDO
    FIELD {&CONFIGURATIONKEY} AS CHARACTER
    FIELD {&CONFIGURATIONVALUE} AS CHARACTER
    INDEX id{&CONFIGURATIONTABLE} IS PRIMARY UNIQUE {&CONFIGURATIONKEY}.
&ENDIF



/* ***************************  Main Block  *************************** */
