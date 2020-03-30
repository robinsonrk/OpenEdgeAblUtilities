/*------------------------------------------------------------------------
    File        : externalproc.i
    Purpose     : Defines external procedures interfaces for SO
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Tue Mar 25 16:16:45 BRT 2020
    Notes       :

        https://knowledgebase.progress.com/articles/Article/P14886
        https://knowledgebase.progress.com/articles/Article/000045158

        Example:
        {Robinson/globalconfig/externalproc.i &associatedProgram=ANYTHINGTOENABLE
                                              &runProcess=ENABLETOO}

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/


/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Definitions  ************************** */


/* ***************************  Main Block  *************************** */


/* *********************  Procedure Definitions  ********************** */

&IF "{&WINDOW-SYSTEM}" <> "TTY" &THEN

&IF DEFINED(associatedProgram) <> 0 &THEN

PROCEDURE associatedProgram:

    DEFINE INPUT  PARAMETER cDirectory  AS CHARACTER    NO-UNDO.
    DEFINE INPUT  PARAMETER cFileName   AS CHARACTER    NO-UNDO.
    DEFINE OUTPUT PARAMETER cResult     AS CHARACTER    NO-UNDO.

    DEFINE VARIABLE iReturnCode        AS INTEGER     NO-UNDO.

    ASSIGN cResult = FILL(" ", 255).

    RUN FindExecutableA (INPUT        cFileName,
                         INPUT        cDirectory,
                         INPUT-OUTPUT cResult,
                         OUTPUT       iReturnCode ).

END PROCEDURE.

&ENDIF

&IF DEFINED(runProcess) <> 0 &THEN

PROCEDURE runProcess:

    DEFINE INPUT  PARAMETER cCommandLine    AS CHARACTER    NO-UNDO.
    DEFINE INPUT  PARAMETER iTimeout        AS INTEGER      NO-UNDO.

    DEFINE VARIABLE iApplicationName     AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iProcessAttributes   AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iThreadAttributes    AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iInheritHandles      AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iNormalPriorityClass AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iEnvironment         AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iCurrentDirectory    AS INTEGER     NO-UNDO.
    DEFINE VARIABLE lpStartupInfo        AS MEMPTR      NO-UNDO.
    DEFINE VARIABLE lpProcessInformation AS MEMPTR      NO-UNDO.
    DEFINE VARIABLE iStartupCode         AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iProcCode            AS INTEGER     NO-UNDO.


    /*Set the size for the lpStartupInfo memory region */
    SET-SIZE(lpStartupInfo) = 4 + 4 + 4 + 4 + 4 + 4 + 4 + 4 + 4 + 4 + 4 + 4 + 2 + 2 + 4 + 4 + 4 + 4.

    /* Initialize the lpStartupInfo memory regions first location with its own size */
    PUT-LONG(lpStartupInfo, 1) = GET-SIZE(lpStartupInfo).

    /* set the size for the lpProcessInformation memory region */
    SET-SIZE(lpProcessInformation) = 4 + 4 + 4 + 4.

    RUN CreateProcessA (INPUT          iApplicationName,
                        INPUT          cCommandLine,
                        INPUT          iProcessAttributes,
                        INPUT          iThreadAttributes,
                        INPUT          iInheritHandles,
                        INPUT          iNormalPriorityClass,
                        INPUT          iEnvironment,
                        INPUT          iCurrentDirectory,
                        INPUT          lpStartupInfo,
                        INPUT-OUTPUT   lpProcessInformation,
                        OUTPUT         iStartupCode).

    /* Run external process synchronously with process handle */
    RUN WaitForSingleObject (INPUT  GET-LONG(lpProcessInformation, 1),
                             INPUT  iTimeout,
                             OUTPUT iProcCode ).

    /* Windows-program execution terminated */
    /* Release the Process handle */
    RUN CloseHandle (INPUT  GET-LONG(lpProcessInformation, 1),
                     OUTPUT iProcCode ).

END PROCEDURE.

&ENDIF

&IF DEFINED(WinExec) <> 0 &THEN

PROCEDURE WinExec EXTERNAL "kernel32.dll":
    DEFINE INPUT  PARAMETER prog_name    AS CHARACTER    NO-UNDO.
    DEFINE INPUT  PARAMETER visual_style AS SHORT        NO-UNDO.
END PROCEDURE.

&ENDIF

&IF DEFINED(FindExecutableA) <> 0 OR DEFINED(associatedProgram) <> 0 &THEN

PROCEDURE FindExecutableA EXTERNAL 'SHELL32.DLL':
    DEFINE INPUT        PARAMETER pcFileName    AS CHARACTER    NO-UNDO.
    DEFINE INPUT        PARAMETER pcDirectory   AS CHARACTER    NO-UNDO.
    DEFINE INPUT-OUTPUT PARAMETER pcResult      AS CHARACTER    NO-UNDO.
    DEFINE RETURN       PARAMETER piReturnCode  AS LONG         NO-UNDO.
END PROCEDURE.

&ENDIF

&IF DEFINED(WaitForSingleObject) <> 0 OR DEFINED(runProcess) <> 0 &THEN

PROCEDURE WaitForSingleObject EXTERNAL "KERNEL32.DLL":
    DEFINE INPUT  PARAMETER piHandle        AS LONG     NO-UNDO.
    DEFINE INPUT  PARAMETER piMilliseconds  AS LONG     NO-UNDO.
    DEFINE RETURN PARAMETER piProcCode      AS LONG     NO-UNDO.
END.

&ENDIF

&IF DEFINED(CloseHandle) <> 0 OR DEFINED(runProcess) <> 0 &THEN

PROCEDURE CloseHandle EXTERNAL "KERNEL32.dll":
  DEFINE INPUT  PARAMETER piProcessHandle   AS LONG     NO-UNDO.
  DEFINE RETURN PARAMETER piProcessReturn   AS LONG     NO-UNDO.
END.

&ENDIF

&IF DEFINED(CreateProcessA) <> 0 OR DEFINED(runProcess) <> 0 &THEN

PROCEDURE CreateProcessA EXTERNAL "kernel32.dll":
    DEFINE INPUT        PARAMETER plApplicationName     AS LONG         NO-UNDO.
    DEFINE INPUT        PARAMETER lpCommandLine         AS CHARACTER    NO-UNDO.
    DEFINE INPUT        PARAMETER lpProcessAttributes   AS LONG         NO-UNDO.
    DEFINE INPUT        PARAMETER lpThreadAttributes    AS LONG         NO-UNDO.
    DEFINE INPUT        PARAMETER plInheritHandles      AS LONG         NO-UNDO.
    DEFINE INPUT        PARAMETER dwCreationFlags       AS LONG         NO-UNDO.
    DEFINE INPUT        PARAMETER lpEnvironment         AS LONG         NO-UNDO.
    DEFINE INPUT        PARAMETER lpCurrentDirectory    AS LONG         NO-UNDO.
    DEFINE INPUT        PARAMETER lppStartupInfo        AS MEMPTR       NO-UNDO.
    DEFINE INPUT-OUTPUT PARAMETER lppProcessInformation AS MEMPTR       NO-UNDO.
    DEFINE RETURN       PARAMETER piStartupCode         AS LONG         NO-UNDO.
END PROCEDURE.

&ENDIF

&IF DEFINED(ShellExecuteA) <> 0 &THEN

PROCEDURE ShellExecuteA EXTERNAL "shell32.dll":
    DEFINE INPUT PARAMETER hwnd         AS LONG         NO-UNDO. /* Handle to parent window */
    DEFINE INPUT PARAMETER lpOperation  AS CHARACTER    NO-UNDO. /* Operation to perform: open, print */
    DEFINE INPUT PARAMETER lpFile       AS CHARACTER    NO-UNDO. /* Document or executable name */
    DEFINE INPUT PARAMETER lpParameters AS CHARACTER    NO-UNDO. /* Command line parameters to executable in lpFile */
    DEFINE INPUT PARAMETER lpDirectory  AS CHARACTER    NO-UNDO. /* Default directory */
    DEFINE INPUT PARAMETER nShowCmd     AS LONG         NO-UNDO. /* Whether shown when opened: 0 hidden, 1 normal, 2 minimized, 3 maximized, 0 if lpFile is a document */
    DEFINE RETURN PARAMETER hInstance   AS LONG         NO-UNDO. /* Less than or equal to 32 */
END PROCEDURE.

&ENDIF

&ENDIF
