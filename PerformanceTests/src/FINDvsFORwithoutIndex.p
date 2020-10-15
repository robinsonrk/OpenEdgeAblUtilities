/*------------------------------------------------------------------------
    File        : FINDvsFORwithoutIndex.p
    Description : Performance comparison between FIND and FOR.
                  Not using an index, forcing table scan.
    Syntax      :
    Author(s)   : Robinson Koprowski
    Created     : Thu Oct 15 14:11:11 BRT 2020

    Notes       :

        The goal is to unmask the urban legend that FOR is faster than FIND
        on searching for individual records.

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.


/* ********************  Preprocessor Definitions  ******************** */

&GLOBAL-DEFINE Tabela ordem-compra
&GLOBAL-DEFINE CampoIndice numero-ordem
&GLOBAL-DEFINE CamposAdicionais situacao
&GLOBAL-DEFINE Condicao WHERE ordem-compra.situacao = RANDOM(1, 3) AND ordem-compra.nr-dias-taxa >= RANDOM(0, 10) AND ordem-compra.nr-dias-taxa <= RANDOM(0, 10) AND (ordem-compra.dep-almoxar = "xxx" OR ordem-compra.dep-almoxar = "yyy")

/* ***************************  Definitions  ************************** */

DEFINE VARIABLE numLeituras     AS INTEGER      NO-UNDO INITIAL 20.
DEFINE VARIABLE contador1       AS INTEGER      NO-UNDO.
DEFINE VARIABLE contador2       AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempoIni        AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo1          AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo2          AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo3          AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo4          AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo7          AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo8          AS INTEGER      NO-UNDO.
DEFINE VARIABLE aux             AS INTEGER      NO-UNDO.


/* ***************************  Main Block  *************************** */


DO contador1 = 1 TO 10:

    ASSIGN tempoIni = MTIME.
    DO contador2 = 1 TO numLeituras:
        FOR FIRST {&Tabela} NO-LOCK {&Condicao}: END.
        IF AVAILABLE {&Tabela} THEN
            ASSIGN aux = {&Tabela}.{&CampoIndice}.
    END.
    ASSIGN tempo1 = tempo1 + MTIME - tempoIni.

    ASSIGN tempoIni = MTIME.
    DO TRANSACTION:
        DO contador2 = 1 TO numLeituras:
            FOR FIRST {&Tabela} EXCLUSIVE-LOCK {&Condicao}: END.
            IF AVAILABLE {&Tabela} THEN
                ASSIGN aux = {&Tabela}.{&CampoIndice}.
        END.
    END.
    ASSIGN tempo2 = tempo2 + MTIME - tempoIni.

    ASSIGN tempoIni = MTIME.
    DO contador2 = 1 TO numLeituras:
        FOR FIRST {&Tabela} FIELDS({&CampoIndice} {&CamposAdicionais}) NO-LOCK {&Condicao}: END.
        IF AVAILABLE {&Tabela} THEN
            ASSIGN aux = {&Tabela}.{&CampoIndice}.
    END.
    ASSIGN tempo3 = tempo3 + MTIME - tempoIni.

    ASSIGN tempoIni = MTIME.
    DO TRANSACTION:
        DO contador2 = 1 TO numLeituras:
            FOR FIRST {&Tabela} FIELDS({&CampoIndice} {&CamposAdicionais}) EXCLUSIVE-LOCK {&Condicao}: END.
            IF AVAILABLE {&Tabela} THEN
                ASSIGN aux = {&Tabela}.{&CampoIndice}.
        END.
    END.
    ASSIGN tempo4 = tempo4 + MTIME - tempoIni.
    
    ASSIGN tempoIni = MTIME.
    DO contador2 = 1 TO numLeituras:
        FIND FIRST {&Tabela} NO-LOCK {&Condicao} NO-ERROR.
        IF AVAILABLE {&Tabela} THEN
            ASSIGN aux = {&Tabela}.{&CampoIndice}.
    END.
    ASSIGN tempo7 = tempo7 + MTIME - tempoIni.

    ASSIGN tempoIni = MTIME.
    DO TRANSACTION:
        DO contador2 = 1 TO numLeituras:
            FIND FIRST {&Tabela} EXCLUSIVE-LOCK {&Condicao} NO-ERROR.
            IF AVAILABLE {&Tabela} THEN
                ASSIGN aux = {&Tabela}.{&CampoIndice}.
        END.
    END.
    ASSIGN tempo8 = tempo8 + MTIME - tempoIni.

END.

MESSAGE 
        "FOR FIRST - WITHOUT FIELDS" SKIP
        "No transaction:" tempo1 SKIP
        "Transaction:" tempo2 SKIP(1)
        "FOR FIRST - COM FIELDS" SKIP
        "No transaction:" tempo3 SKIP
        "Transaction:" tempo4 SKIP(1)
        "FIND FIRST" SKIP
        "No transaction:" tempo7 SKIP
        "Transaction:" tempo8
    VIEW-AS ALERT-BOX TITLE "Time in milis".
