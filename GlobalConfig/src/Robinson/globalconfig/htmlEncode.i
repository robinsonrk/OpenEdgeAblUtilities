/*------------------------------------------------------------------------
    File        : htmlEncode.i
    Purpose     : Include containing functions to translate character
                  strings to HTML standard.
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Fri Abr 08 10:00:00 BRT 2020
    Notes       :

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/


/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Definitions  ************************** */


/* *********************  Function Definitions  ********************** */

function htmlEncodeHtmlChars returns character (originalString as character):
    define variable encodedString   as character    no-undo.
    run htmlEncodeChars in this-procedure (originalString, "html", output encodedString).
    return encodedString.
end function.

function htmlEncodeUrlChars returns character (originalString as character):
    define variable encodedString   as character    no-undo.
    run htmlEncodeChars in this-procedure (originalString, "url", output encodedString).
    return encodedString.
end function.

function htmlEncodeQspChars returns character (originalString as character):
    define variable encodedString   as character    no-undo.
    run htmlEncodeChars in this-procedure (originalString, "qsp", output encodedString).
    return encodedString.
end function.


/* ***************************  Main Block  *************************** */


/* **********************  Procedure Definitions  ******************** */

procedure htmlEncodeChars:

{{&GLOBALCONFIGPATH}/htmlEncodeCommon.i}

end procedure.
