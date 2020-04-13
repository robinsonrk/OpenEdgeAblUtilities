&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
    File        : pdfnatorconfig.w
    Description : PDFNator configs
    Syntax      :
    Author(s)   : Robinson Koprowski
    Created     : Mon Mar 30 10:30:00 BRT 2020

    Notes       :

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

/* Create an unnamed pool  */
CREATE WIDGET-POOL.


/* ********************  Preprocessor Definitions  ******************** */

&GLOBAL-DEFINE PDFNATORPATH Robinson/pdfnator
&GLOBAL-DEFINE GLOBALCONFIGPATH Robinson/globalconfig
&GLOBAL-DEFINE ABLENVIRONMENTPATH 
&GLOBAL-DEFINE LOGABLERRORSPATH Robinson/logablerrors


/* ***************************  Definitions  ************************** */

{{&GLOBALCONFIGPATH}/globalconfig.i}

DEFINE VARIABLE cInitialized    AS CHARACTER    NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-13 SELECT-1 btnOk btnCancel 
&Scoped-Define DISPLAYED-OBJECTS SELECT-1 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnCancel 
     LABEL "Cancel" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btnOk 
     LABEL "Ok" 
     SIZE 15 BY 1.14.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 163 BY 1.67.

DEFINE VARIABLE SELECT-1 AS CHARACTER INITIAL "home" 
     VIEW-AS SELECTION-LIST SINGLE 
     LIST-ITEM-PAIRS "Home","home",
                     "wkhtmltopdf utility","wkhtmltopdf",
                     "Viewing & Printing Modes","viewer",
                     "Adobe Acrobat Reader","acrord",
                     "Sumatra PDF","sumatra" 
     SIZE 28 BY 15.95 NO-UNDO.

DEFINE BUTTON BUTTON-6 
     LABEL "Defaults" 
     SIZE 10 BY 1.

DEFINE BUTTON BUTTON-7 
     LABEL "Defaults" 
     SIZE 10 BY 1.

DEFINE VARIABLE cAcrordOpeningParams AS CHARACTER FORMAT "X(256)":U 
     LABEL "Opening PDF Params" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cAcrordPrintingParams AS CHARACTER FORMAT "X(256)":U 
     LABEL "Printing PDF Params" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cGlobalAcrordPath32 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Path (32bits)" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cGlobalAcrordPath64 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Path (64bits)" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cStationAcrordPath AS CHARACTER FORMAT "X(256)":U 
     LABEL "Path" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 129 BY 3.33.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 129 BY 3.33.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 129 BY 2.14.

DEFINE VARIABLE EDITOR-1 AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 128 BY 7.86 NO-UNDO.

DEFINE VARIABLE cStationName AS CHARACTER FORMAT "X(256)":U 
     LABEL "Station Name" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE BUTTON BUTTON-4 
     LABEL "Defaults" 
     SIZE 10 BY 1.

DEFINE BUTTON BUTTON-5 
     LABEL "Defaults" 
     SIZE 10 BY 1.

DEFINE VARIABLE cGlobalSumatraPath32 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Path (32bits)" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cGlobalSumatraPath64 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Path (64bits)" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cStationSumatraPath AS CHARACTER FORMAT "X(256)":U 
     LABEL "Path" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cSumatraOpeningParams AS CHARACTER FORMAT "X(256)":U 
     LABEL "Opening PDF Params" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cSumatraPrintingParams AS CHARACTER FORMAT "X(256)":U 
     LABEL "Printing PDF Params" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 129 BY 2.14.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 129 BY 3.33.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 129 BY 3.33.

DEFINE VARIABLE cGlobalOpeningMode AS CHARACTER FORMAT "X(256)":U INITIAL "auto" 
     LABEL "Opening Mode" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Auto with Associated Application","auto",
                     "PDF Viewer Path + Viewers Parameters","viewer"
     DROP-DOWN-LIST
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cGlobalPrintMode AS CHARACTER FORMAT "X(256)":U INITIAL "command.viewer" 
     LABEL "Printing Mode" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Using PDF Viewer","command.viewer",
                     "Copy to Printer","command.copy",
                     "Adobe Acrobat Reader dotNet integration","acrord.dotnet",
                     "Adobe Acrobat Reader COM Automation (needs Pro Licence)","acrord.comobj"
     DROP-DOWN-LIST
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cGlobalViewer AS CHARACTER FORMAT "X(256)":U INITIAL "acrord" 
     LABEL "PDF Viewer" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Adobe Acrobat Reader","acrord",
                     "Sumatra PDF","sumatra"
     DROP-DOWN-LIST
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cStationOpeningMode AS CHARACTER FORMAT "X(256)":U INITIAL "default" 
     LABEL "Opening Mode" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Global Default","default",
                     "Auto with Associated Application","auto",
                     "PDF Viewer Path + Viewers Parameters","viewer"
     DROP-DOWN-LIST
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cStationPrintMode AS CHARACTER FORMAT "X(256)":U INITIAL "default" 
     LABEL "Printing Mode" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Global Default","default",
                     "Using PDF Viewer","command.viewer",
                     "Copy to Printer","command.copy",
                     "Adobe Acrobat Reader dotNet integration","acrord.dotnet",
                     "Adobe Acrobat Reader COM Automation (needs Pro Licence)","acrord.comobj"
     DROP-DOWN-LIST
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cStationViewer AS CHARACTER FORMAT "X(256)":U INITIAL "default" 
     LABEL "PDF Viewer" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Global Default","default",
                     "Adobe Acrobat Reader","acrord",
                     "Sumatra PDF","sumatra"
     DROP-DOWN-LIST
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cGlobalPrinterPath AS CHARACTER FORMAT "X(256)":U 
     LABEL "Default Printer" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cStationPrinterPath AS CHARACTER FORMAT "X(256)":U 
     LABEL "Default Printer" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 129 BY 5.48.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 129 BY 5.71.

DEFINE BUTTON BUTTON-1 
     LABEL "Defaults" 
     SIZE 10 BY 1.14.

DEFINE VARIABLE cGlobalUtilityPath32 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Path (32bits)" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cGlobalUtilityPath64 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Path (64bits)" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cStationUtilityPath AS CHARACTER FORMAT "X(256)":U 
     LABEL "Path" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE VARIABLE cUtilityParams AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cmd Line Parameters" 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 129 BY 3.33.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 129 BY 2.14.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 129 BY 2.14.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     SELECT-1 AT ROW 1.24 COL 2 NO-LABEL WIDGET-ID 2
     btnOk AT ROW 17.67 COL 131 WIDGET-ID 6
     btnCancel AT ROW 17.67 COL 147 WIDGET-ID 4
     RECT-13 AT ROW 17.43 COL 2 WIDGET-ID 8
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 165.4 BY 18.43
         FONT 1 WIDGET-ID 100.

DEFINE FRAME FRAME-VIEWER
     cGlobalViewer AT ROW 1.95 COL 29 COLON-ALIGNED WIDGET-ID 26
     cGlobalOpeningMode AT ROW 3.14 COL 29 COLON-ALIGNED WIDGET-ID 30
     cGlobalPrintMode AT ROW 4.33 COL 29 COLON-ALIGNED WIDGET-ID 32
     cGlobalPrinterPath AT ROW 5.52 COL 29 COLON-ALIGNED WIDGET-ID 8
     cStationViewer AT ROW 8.14 COL 29 COLON-ALIGNED WIDGET-ID 28
     cStationOpeningMode AT ROW 9.33 COL 29 COLON-ALIGNED WIDGET-ID 34
     cStationPrintMode AT ROW 10.57 COL 29 COLON-ALIGNED WIDGET-ID 36
     cStationPrinterPath AT ROW 11.71 COL 29 COLON-ALIGNED WIDGET-ID 38
     "Default Values for the Station (blaks for global default values):" VIEW-AS TEXT
          SIZE 61 BY .62 AT ROW 7.19 COL 6 WIDGET-ID 24
     "Global Default Values:" VIEW-AS TEXT
          SIZE 26 BY .62 AT ROW 1.24 COL 6 WIDGET-ID 14
     RECT-4 AT ROW 1.48 COL 3 WIDGET-ID 12
     RECT-5 AT ROW 7.43 COL 3 WIDGET-ID 22
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 32 ROW 1.24
         SIZE 133 BY 15.95
         FONT 1
         TITLE "Viewing & Printing Modes" WIDGET-ID 300.

DEFINE FRAME FRAME-WKHTMLTOPDF
     cGlobalUtilityPath32 AT ROW 2.19 COL 29 COLON-ALIGNED WIDGET-ID 8
     cGlobalUtilityPath64 AT ROW 3.38 COL 29 COLON-ALIGNED WIDGET-ID 10
     cStationUtilityPath AT ROW 6.24 COL 29 COLON-ALIGNED WIDGET-ID 18
     cUtilityParams AT ROW 9.1 COL 29 COLON-ALIGNED WIDGET-ID 16
     BUTTON-1 AT ROW 9.1 COL 121 WIDGET-ID 30
     "Common Values:" VIEW-AS TEXT
          SIZE 18 BY .62 AT ROW 8.14 COL 6 WIDGET-ID 28
     "Default Values for the Station (blanks for global default values):" VIEW-AS TEXT
          SIZE 66 BY .62 AT ROW 5.29 COL 6 WIDGET-ID 24
     "Global Default Values:" VIEW-AS TEXT
          SIZE 26 BY .62 AT ROW 1.24 COL 6 WIDGET-ID 14
     RECT-1 AT ROW 1.48 COL 3 WIDGET-ID 12
     RECT-2 AT ROW 5.52 COL 3 WIDGET-ID 22
     RECT-3 AT ROW 8.38 COL 3 WIDGET-ID 26
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 32 ROW 1.24
         SIZE 133 BY 15.95
         FONT 1
         TITLE "wkhtmltopdf utility" WIDGET-ID 200.

DEFINE FRAME FRAME-SUMATRA
     cGlobalSumatraPath32 AT ROW 2.19 COL 29 COLON-ALIGNED WIDGET-ID 8
     cGlobalSumatraPath64 AT ROW 3.38 COL 29 COLON-ALIGNED WIDGET-ID 10
     cStationSumatraPath AT ROW 6.24 COL 29 COLON-ALIGNED WIDGET-ID 18
     cSumatraOpeningParams AT ROW 9.1 COL 29 COLON-ALIGNED WIDGET-ID 30
     BUTTON-4 AT ROW 9.1 COL 121 WIDGET-ID 38
     cSumatraPrintingParams AT ROW 10.29 COL 29 COLON-ALIGNED WIDGET-ID 36
     BUTTON-5 AT ROW 10.29 COL 121 WIDGET-ID 40
     "Global Default Values:" VIEW-AS TEXT
          SIZE 26 BY .62 AT ROW 1.24 COL 6 WIDGET-ID 14
     "Common Values:" VIEW-AS TEXT
          SIZE 18 BY .62 AT ROW 8.14 COL 6 WIDGET-ID 34
     "Default Values for the Station (blanks for global default values):" VIEW-AS TEXT
          SIZE 66 BY .62 AT ROW 5.29 COL 6 WIDGET-ID 24
     RECT-8 AT ROW 1.48 COL 3 WIDGET-ID 12
     RECT-10 AT ROW 5.52 COL 3 WIDGET-ID 22
     RECT-11 AT ROW 8.38 COL 3 WIDGET-ID 32
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 32 ROW 1.24
         SIZE 133 BY 15.95
         FONT 1
         TITLE "Sumatra PDF" WIDGET-ID 500.

DEFINE FRAME FRAME-ACRORD
     cGlobalAcrordPath32 AT ROW 2.19 COL 29 COLON-ALIGNED WIDGET-ID 8
     cGlobalAcrordPath64 AT ROW 3.38 COL 29 COLON-ALIGNED WIDGET-ID 10
     cStationAcrordPath AT ROW 6.24 COL 29 COLON-ALIGNED WIDGET-ID 18
     cAcrordOpeningParams AT ROW 9.1 COL 29 COLON-ALIGNED WIDGET-ID 30
     BUTTON-6 AT ROW 9.1 COL 121 WIDGET-ID 40
     cAcrordPrintingParams AT ROW 10.29 COL 29 COLON-ALIGNED WIDGET-ID 36
     BUTTON-7 AT ROW 10.29 COL 121 WIDGET-ID 42
     "Common Values:" VIEW-AS TEXT
          SIZE 18 BY .62 AT ROW 8.14 COL 6 WIDGET-ID 34
     "Global Default Values:" VIEW-AS TEXT
          SIZE 26 BY .62 AT ROW 1.24 COL 6 WIDGET-ID 14
     "Default Values for the Station (blanks for global default values):" VIEW-AS TEXT
          SIZE 66 BY .62 AT ROW 5.29 COL 6 WIDGET-ID 24
     RECT-6 AT ROW 1.48 COL 3 WIDGET-ID 12
     RECT-7 AT ROW 5.52 COL 3 WIDGET-ID 22
     RECT-12 AT ROW 8.38 COL 3 WIDGET-ID 38
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 32 ROW 1.24
         SIZE 133 BY 15.95
         FONT 1
         TITLE "Adobe Acrobat Reader" WIDGET-ID 400.

DEFINE FRAME FRAME-HOME
     EDITOR-1 AT ROW 1.48 COL 3 NO-LABEL WIDGET-ID 10 NO-TAB-STOP 
     cStationName AT ROW 10.29 COL 29 COLON-ALIGNED WIDGET-ID 8
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 32 ROW 1.24
         SIZE 133 BY 15.95
         FONT 1
         TITLE "Home" WIDGET-ID 600.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "PDFNator Config"
         HEIGHT             = 18.43
         WIDTH              = 165.4
         MAX-HEIGHT         = 41.57
         MAX-WIDTH          = 178.8
         VIRTUAL-HEIGHT     = 41.57
         VIRTUAL-WIDTH      = 178.8
         MAX-BUTTON         = no
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME FRAME-ACRORD:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME FRAME-HOME:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME FRAME-SUMATRA:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME FRAME-VIEWER:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME FRAME-WKHTMLTOPDF:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   NOT-VISIBLE FRAME-NAME                                               */
/* SETTINGS FOR FRAME FRAME-ACRORD
                                                                        */
/* SETTINGS FOR FRAME FRAME-HOME
                                                                        */
ASSIGN 
       EDITOR-1:READ-ONLY IN FRAME FRAME-HOME        = TRUE.

/* SETTINGS FOR FRAME FRAME-SUMATRA
                                                                        */
/* SETTINGS FOR FRAME FRAME-VIEWER
                                                                        */
/* SETTINGS FOR FRAME FRAME-WKHTMLTOPDF
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME FRAME-WKHTMLTOPDF
/* Query rebuild information for FRAME FRAME-WKHTMLTOPDF
     _Query            is NOT OPENED
*/  /* FRAME FRAME-WKHTMLTOPDF */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* PDFNator Config */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* PDFNator Config */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnCancel C-Win
ON CHOOSE OF btnCancel IN FRAME DEFAULT-FRAME /* Cancel */
DO:
    APPLY "close" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnOk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnOk C-Win
ON CHOOSE OF btnOk IN FRAME DEFAULT-FRAME /* Ok */
DO:

    IF INPUT FRAME FRAME-WKHTMLTOPDF cGlobalUtilityPath32 = "" OR INPUT FRAME FRAME-WKHTMLTOPDF cGlobalUtilityPath64 = "" THEN DO:
        MESSAGE "WKHTMLTOPDF utility path must be informed."
            VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.

    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.wkhtmltopdf32", INPUT FRAME FRAME-WKHTMLTOPDF cGlobalUtilityPath32).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.wkhtmltopdf64", INPUT FRAME FRAME-WKHTMLTOPDF cGlobalUtilityPath64).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".wkhtmltopdf", (IF INPUT FRAME FRAME-WKHTMLTOPDF cStationUtilityPath <> "" THEN INPUT FRAME FRAME-WKHTMLTOPDF cStationUtilityPath ELSE ?)).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.wkhtmltopdfparameters", INPUT FRAME FRAME-WKHTMLTOPDF cUtilityParams).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer.type", INPUT FRAME FRAME-VIEWER cGlobalViewer).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".pdfviewer.type", (IF INPUT FRAME FRAME-VIEWER cStationViewer <> "default" THEN INPUT FRAME FRAME-VIEWER cStationViewer ELSE ?)).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer32.path.sumatra", INPUT FRAME FRAME-SUMATRA cGlobalSumatraPath32).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer64.path.sumatra", INPUT FRAME FRAME-SUMATRA cGlobalSumatraPath64).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer32.path.acrord", INPUT FRAME FRAME-ACRORD cGlobalAcrordPath32).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer64.path.acrord", INPUT FRAME FRAME-ACRORD cGlobalAcrordPath64).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".pdfviewer.path.sumatra", (IF INPUT FRAME FRAME-SUMATRA cStationSumatraPath <> "" THEN INPUT FRAME FRAME-SUMATRA cStationSumatraPath ELSE ?)).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".pdfviewer.path.acrord", (IF INPUT FRAME FRAME-ACRORD cStationAcrordPath <> "" THEN INPUT FRAME FRAME-ACRORD cStationAcrordPath ELSE ?)).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer.openingmode", INPUT FRAME FRAME-VIEWER cGlobalOpeningMode).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".pdfviewer.openingmode", (IF INPUT FRAME FRAME-VIEWER cStationOpeningMode <> "default" THEN INPUT FRAME FRAME-VIEWER cStationOpeningMode ELSE ?)).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer.parameters.acrord", INPUT FRAME FRAME-ACRORD cAcrordOpeningParams).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer.parameters.sumatra", INPUT FRAME FRAME-SUMATRA cSumatraOpeningParams).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfprinter.name", INPUT FRAME FRAME-VIEWER cGlobalPrinterPath).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".pdfprinter.name", (IF INPUT FRAME FRAME-VIEWER cStationPrinterPath <> "" THEN INPUT FRAME FRAME-VIEWER cStationPrinterPath ELSE ?)).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfprinter.mode", INPUT FRAME FRAME-VIEWER cGlobalPrintMode).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("station." + cStationName + ".pdfprinter.mode", (IF INPUT FRAME FRAME-VIEWER cStationPrintMode <> "default" THEN INPUT FRAME FRAME-VIEWER cStationPrintMode ELSE ?)).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer.printparameters.sumatra", INPUT FRAME FRAME-SUMATRA cSumatraPrintingParams).
    RUN {&GLOBALCONFIGPATH}/setconfig.p ("global.pdfviewer.printparameters.acrord", INPUT FRAME FRAME-ACRORD cAcrordPrintingParams).

    APPLY "close" TO THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-WKHTMLTOPDF
&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 C-Win
ON CHOOSE OF BUTTON-1 IN FRAME FRAME-WKHTMLTOPDF /* Defaults */
DO:
    DISPLAY "--quiet --page-size A3 --copies 1 --page-offset [pageoffset] --header-left ~"[headertitle]~" --header-right ~"Page [page] of [toPage]~" ~"[fileorig]~" ~"[filedest]~"" @ cUtilityParams
        WITH FRAME FRAME-WKHTMLTOPDF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-SUMATRA
&Scoped-define SELF-NAME BUTTON-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-4 C-Win
ON CHOOSE OF BUTTON-4 IN FRAME FRAME-SUMATRA /* Defaults */
DO:
    DISPLAY "~"[filename]~"" @ cSumatraOpeningParams
        WITH FRAME FRAME-SUMATRA.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-5 C-Win
ON CHOOSE OF BUTTON-5 IN FRAME FRAME-SUMATRA /* Defaults */
DO:
    DISPLAY "-print-to ~"[printername]~" -silent ~"[filename]~"" @ cSumatraPrintingParams
        WITH FRAME FRAME-SUMATRA.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-ACRORD
&Scoped-define SELF-NAME BUTTON-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-6 C-Win
ON CHOOSE OF BUTTON-6 IN FRAME FRAME-ACRORD /* Defaults */
DO:
    DISPLAY "~"[filename]~"" @ cAcrordOpeningParams
        WITH FRAME FRAME-ACRORD.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-7 C-Win
ON CHOOSE OF BUTTON-7 IN FRAME FRAME-ACRORD /* Defaults */
DO:
    DISPLAY "/t ~"[filename]~" ~"[printername]~"" @ cAcrordPrintingParams
        WITH FRAME FRAME-ACRORD.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-HOME
&Scoped-define SELF-NAME cStationName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cStationName C-Win
ON ENTRY OF cStationName IN FRAME FRAME-HOME /* Station Name */
DO:
    ASSIGN SELF:MODIFIED = FALSE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cStationName C-Win
ON LEAVE OF cStationName IN FRAME FRAME-HOME /* Station Name */
DO:
    DEFINE VARIABLE lOk     AS LOGICAL      NO-UNDO INITIAL FALSE.
    IF SELF:MODIFIED THEN DO:
        MESSAGE "This will discard the current changes (if any) and reload the configuration to the specified station name." SKIP(1)
                "Continue?"
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Reload configs?" UPDATE lOk.
        IF lOk THEN DO:
            ASSIGN INPUT FRAME FRAME-HOME cStationName.
            RUN loadConfigs IN THIS-PROCEDURE.
        END.
        ELSE
            DISPLAY cStationName WITH FRAME FRAME-HOME.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME SELECT-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL SELECT-1 C-Win
ON VALUE-CHANGED OF SELECT-1 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN INPUT FRAME DEFAULT-FRAME SELECT-1.
    ASSIGN SELECT-1 = TRIM(SELECT-1).

    HIDE FRAME FRAME-HOME.
    HIDE FRAME FRAME-VIEWER.
    HIDE FRAME FRAME-ACRORD.
    HIDE FRAME FRAME-SUMATRA.
    HIDE FRAME FRAME-WKHTMLTOPDF.

    CASE SELECT-1:
        WHEN "home" OR WHEN ? OR WHEN "" THEN DO:
            VIEW FRAME FRAME-HOME.
        END.
        WHEN "wkhtmltopdf" OR WHEN ? OR WHEN "" THEN DO:
            VIEW FRAME FRAME-WKHTMLTOPDF.
        END.
        WHEN "viewer" THEN DO:
            VIEW FRAME FRAME-VIEWER.
        END.
        WHEN "acrord" THEN DO:
            VIEW FRAME FRAME-ACRORD.
        END.
        WHEN "sumatra" THEN DO:
            VIEW FRAME FRAME-SUMATRA.
        END.
        OTHERWISE DO:
            MESSAGE SELECT-1
                VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
        END.
    END CASE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME}
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE
    RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

    ASSIGN EDITOR-1 = "SOME HINTS" + CHR(10) + CHR(10)
                    + "Use the side menu to navigate." + CHR(10)
                    + "You can specify global configurations for all stations or a more specific configuration to a single station." + CHR(10)
                    + "Prefer to use always as possible global configurations. Set specific configurations only to exceptions." + CHR(10)
                    + "When a station does not encounter a specific configuration, the global configuration will be used." + CHR(10)
                    + "WKHTMLTOPDF path can be set relative to the PROPATH." + CHR(10)
                    + "Change the global configurations or specify the station you want to set configurations in the box bellow.".

    ASSIGN cStationName = OS-GETENV("CLIENTNAME"). /*Remote Desktop client*/
    IF cStationName = ? THEN
        ASSIGN cStationName = OS-GETENV("COMPUTERNAME").

    RUN loadConfigs IN THIS-PROCEDURE.

    RUN enable_UI.

    APPLY "VALUE-CHANGED" TO SELECT-1 IN FRAME DEFAULT-FRAME.

    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY SELECT-1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-13 SELECT-1 btnOk btnCancel 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY cGlobalAcrordPath32 cGlobalAcrordPath64 cStationAcrordPath 
          cAcrordOpeningParams cAcrordPrintingParams 
      WITH FRAME FRAME-ACRORD IN WINDOW C-Win.
  ENABLE RECT-6 RECT-7 RECT-12 cGlobalAcrordPath32 cGlobalAcrordPath64 
         cStationAcrordPath cAcrordOpeningParams BUTTON-6 cAcrordPrintingParams 
         BUTTON-7 
      WITH FRAME FRAME-ACRORD IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-ACRORD}
  DISPLAY EDITOR-1 cStationName 
      WITH FRAME FRAME-HOME IN WINDOW C-Win.
  ENABLE EDITOR-1 cStationName 
      WITH FRAME FRAME-HOME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-HOME}
  DISPLAY cGlobalSumatraPath32 cGlobalSumatraPath64 cStationSumatraPath 
          cSumatraOpeningParams cSumatraPrintingParams 
      WITH FRAME FRAME-SUMATRA IN WINDOW C-Win.
  ENABLE RECT-8 RECT-10 RECT-11 cGlobalSumatraPath32 cGlobalSumatraPath64 
         cStationSumatraPath cSumatraOpeningParams BUTTON-4 
         cSumatraPrintingParams BUTTON-5 
      WITH FRAME FRAME-SUMATRA IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-SUMATRA}
  DISPLAY cGlobalViewer cGlobalOpeningMode cGlobalPrintMode cGlobalPrinterPath 
          cStationViewer cStationOpeningMode cStationPrintMode 
          cStationPrinterPath 
      WITH FRAME FRAME-VIEWER IN WINDOW C-Win.
  ENABLE RECT-4 RECT-5 cGlobalViewer cGlobalOpeningMode cGlobalPrintMode 
         cGlobalPrinterPath cStationViewer cStationOpeningMode 
         cStationPrintMode cStationPrinterPath 
      WITH FRAME FRAME-VIEWER IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-VIEWER}
  DISPLAY cGlobalUtilityPath32 cGlobalUtilityPath64 cStationUtilityPath 
          cUtilityParams 
      WITH FRAME FRAME-WKHTMLTOPDF IN WINDOW C-Win.
  ENABLE RECT-1 RECT-2 RECT-3 cGlobalUtilityPath32 cGlobalUtilityPath64 
         cStationUtilityPath cUtilityParams BUTTON-1 
      WITH FRAME FRAME-WKHTMLTOPDF IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-WKHTMLTOPDF}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE loadConfigs C-Win 
PROCEDURE loadConfigs :
/*------------------------------------------------------------------------------
  Purpose:
  Parameters:  <none>
  Notes:
------------------------------------------------------------------------------*/

    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.wkhtmltopdf32;global.wkhtmltopdf64", OUTPUT cInitialized).
    IF cInitialized = ? THEN
        RUN {&PDFNATORPATH}/initpdfnatorconfigs.p.

    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.wkhtmltopdf32", OUTPUT cGlobalUtilityPath32).
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.wkhtmltopdf64", OUTPUT cGlobalUtilityPath64).
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".wkhtmltopdf", OUTPUT cStationUtilityPath).
    IF cStationUtilityPath = ? THEN
        ASSIGN cStationUtilityPath = "".
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.wkhtmltopdfparameters", OUTPUT cUtilityParams).
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.pdfprinter.mode", OUTPUT cGlobalPrintMode). /*acrord.comobj, acrord.dotnet, command.copy, command.viewer*/
    IF NOT CAN-DO ("acrord.comobj,acrord.dotnet,command.copy,command.viewer", cGlobalPrintMode) THEN
        ASSIGN cGlobalPrintMode = "command.viewer".
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".pdfprinter.mode", OUTPUT cStationPrintMode). /*acrord.comobj, acrord.dotnet, command.copy, command.viewer*/
    IF cStationPrintMode = ? OR NOT CAN-DO ("acrord.comobj,acrord.dotnet,command.copy,command.viewer", cStationPrintMode) THEN
        ASSIGN cStationPrintMode = "default".
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.pdfviewer.type", OUTPUT cGlobalViewer).
    IF NOT CAN-DO ("acrord,sumatra", cGlobalViewer) THEN
        ASSIGN cGlobalViewer = "acrord".
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".pdfviewer.type", OUTPUT cStationViewer).
    IF cStationViewer = ? OR NOT CAN-DO ("acrord,sumatra", cStationViewer) THEN
        ASSIGN cStationViewer = "default".
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.pdfviewer32.path.acrord", OUTPUT cGlobalAcrordPath32).
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.pdfviewer64.path.acrord", OUTPUT cGlobalAcrordPath64).
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.pdfviewer32.path.sumatra", OUTPUT cGlobalSumatraPath32).
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.pdfviewer64.path.sumatra", OUTPUT cGlobalSumatraPath64).
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".pdfviewer.path.acrord", OUTPUT cStationAcrordPath).
    IF cStationAcrordPath = ? THEN
        ASSIGN cStationAcrordPath = "".
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".pdfviewer.path.sumatra", OUTPUT cStationSumatraPath).
    IF cStationSumatraPath = ? THEN
        ASSIGN cStationSumatraPath = "".
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.pdfviewer.openingmode", OUTPUT cGlobalOpeningMode).
    IF NOT CAN-DO("auto,viewer", cGlobalOpeningMode) THEN
        ASSIGN cGlobalOpeningMode = "auto".
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".pdfviewer.openingmode", OUTPUT cStationOpeningMode).
    IF cStationOpeningMode = ? OR NOT CAN-DO("auto,viewer", cStationOpeningMode) THEN
        ASSIGN cStationOpeningMode = "default".
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.pdfviewer.parameters.acrord", OUTPUT cAcrordOpeningParams).
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.pdfviewer.parameters.sumatra", OUTPUT cSumatraOpeningParams).
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.pdfprinter.name", OUTPUT cGlobalPrinterPath).
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("station." + cStationName + ".pdfprinter.name", OUTPUT cStationPrinterPath).
    IF cStationPrinterPath = ? THEN
        ASSIGN cStationPrinterPath = "".
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.pdfviewer.printparameters.acrord", OUTPUT cAcrordPrintingParams).
    RUN {&GLOBALCONFIGPATH}/getconfig.p ("global.pdfviewer.printparameters.sumatra", OUTPUT cSumatraPrintingParams).


    DISPLAY
        cGlobalUtilityPath32
        cGlobalUtilityPath64
        cStationUtilityPath
        cUtilityParams
        WITH FRAME FRAME-WKHTMLTOPDF.

    DISPLAY
        cGlobalOpeningMode
        cStationOpeningMode
        cGlobalPrintMode
        cStationPrintMode
        cGlobalViewer
        cStationViewer
        cGlobalPrinterPath
        cStationPrinterPath
        WITH FRAME FRAME-VIEWER.

    DISPLAY
        cGlobalAcrordPath32
        cGlobalAcrordPath64
        cStationAcrordPath
        cAcrordOpeningParams
        cAcrordPrintingParams
        WITH FRAME FRAME-ACRORD.

    DISPLAY
        cGlobalSumatraPath32
        cGlobalSumatraPath64
        cStationSumatraPath
        cSumatraOpeningParams
        cSumatraPrintingParams
        WITH FRAME FRAME-SUMATRA.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

