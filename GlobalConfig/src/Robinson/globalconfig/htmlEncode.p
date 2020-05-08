/*------------------------------------------------------------------------
    File        : htmlEncode.p
    Purpose     : External procedure to invoque htmlEncodeCommon logic.
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Tue Abr 08 11:03:25 BRT 2020
    Notes       :

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

block-level on error undo, throw.

/* ********************  Preprocessor Definitions  ******************** */

&GLOBAL-DEFINE GLOBALCONFIGPATH Robinson/globalconfig

{{&GLOBALCONFIGPATH}/htmlEncodeCommon.i}


/* ***************************  Definitions  ************************** */


/* ***************************  Main Block  *************************** */
