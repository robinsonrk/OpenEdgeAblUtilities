/*------------------------------------------------------------------------
    File        : ablenvironment.i
    Purpose     : preprocessor definitions
    Syntax      :
    Description : This include defines basic preprocessors to developers
                  and environment configurations
    Author(s)   : Robinson Koprowski
    Created     : Tue Feb 25 16:11:22 BRT 2020
    Notes       :

        You must include this file in your .gitignore so each developer,
        production, tests, deploy environments, etc., can have your own
        witout interfere others.
        The values here are used by globalconfig.i and added to
        all sources.

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

/* ********************  Preprocessor Definitions  ******************** */

&GLOBAL-DEFINE RTENVIRONMENT development
&GLOBAL-DEFINE STORAGE memory

&GLOBAL-DEFINE LOGMESSAGES VALUE(SESSION:TEMP-DIRECTORY + "ablmessages.log")

/* ***************************  Definitions  ************************** */


/* ***************************  Main Block  *************************** */

