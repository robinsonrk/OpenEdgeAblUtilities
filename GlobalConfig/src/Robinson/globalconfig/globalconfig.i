/*------------------------------------------------------------------------
    File        : globalconfig.i
    Purpose     : The global definitions for the entire application
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Mon Feb 24 14:24:25 BRT 2020
    Notes       :

        Here are defined preprocessors and other objects to be seen in the
        entire application.
        Some of this objects can/must be defined in ablenvironment.i for
        localized user environment configuration.

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

/*the configuration cannot be defined more than once in de source,
  GLOBALCONFIG preprocessor ensure this.*/
&IF DEFINED(GLOBALCONFIG) = 0 &THEN
    &GLOBAL-DEFINE GLOBALCONFIG TRUE

/* ********************  Preprocessor Definitions  ******************** */

    {ablenvironment.i}

    &IF DEFINED (CONFIGURATIONTABLE) = 0 &THEN
        &GLOBAL-DEFINE CONFIGURATIONTABLE configurationtable
    &ENDIF

    &IF DEFINED (CONFIGURATIONKEY) = 0 &THEN
        &GLOBAL-DEFINE CONFIGURATIONKEY configkey
    &ENDIF

    &IF DEFINED (CONFIGURATIONVALUE) = 0 &THEN
        &GLOBAL-DEFINE CONFIGURATIONVALUE configvalue
    &ENDIF

/* ***************************  Definitions  ************************** */



/* ***************************  Main Block  *************************** */

    &IF "{&RTENVIRONMENT}" <> "development" AND "{&RTENVIRONMENT}" <> "production" AND "{&RTENVIRONMENT}" <> "test" &THEN
        &MESSAGE Runtime Environment must be either 'production', 'development' or 'test'.
        RETURN.
    &ENDIF

    &IF "{&STORAGE}" <> "memory" AND "{&STORAGE}" <> "initializedb" AND "{&STORAGE}" <> "database" &THEN
        &MESSAGE Storage must be either 'memory', 'initializedb' or 'database'.
        RETURN.
    &ENDIF

&ENDIF
