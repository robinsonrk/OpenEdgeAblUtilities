/*------------------------------------------------------------------------
    File        : getconfigordefault.p
    Purpose     : Get config from configuration table or default value if
                  not found
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Wed Feb 26 16:44:17 BRT 2020
    Notes       :

        Just like the getconfig.p, but if none of the configuration is
        found, the default value is returned.

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Definitions  ************************** */

DEFINE INPUT  PARAMETER pcKeyList           AS CHARACTER    NO-UNDO.
DEFINE INPUT  PARAMETER pcDefaultValue      AS CHARACTER    NO-UNDO.
DEFINE OUTPUT PARAMETER pcRetrievedValue    AS CHARACTER    NO-UNDO.


/* ***************************  Main Block  *************************** */

RUN Robinson/globalconfig/getconfig.p (pcKeyList, OUTPUT pcRetrievedValue).
IF pcRetrievedValue = ? THEN
    ASSIGN pcRetrievedValue = pcDefaultValue.
