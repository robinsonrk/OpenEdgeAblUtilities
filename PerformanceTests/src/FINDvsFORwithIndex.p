/*------------------------------------------------------------------------
    File        : FINDvsFORwithIndex.p
    Description : Performance comparison between FIND and FOR
                  Using an index, for quick access.
    Syntax      :
    Author(s)   : Robinson Koprowski
    Created     : Thu Oct 15 13:58:52 BRT 2020

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
&GLOBAL-DEFINE Condicao WHERE ordem-compra.numero-ordem = RANDOM(idIni, idFim)

/* ***************************  Definitions  ************************** */

DEFINE VARIABLE numLeituras     AS INTEGER      NO-UNDO INITIAL 10000.
DEFINE VARIABLE contador1       AS INTEGER      NO-UNDO.
DEFINE VARIABLE contador2       AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempoIni        AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo1          AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo2          AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo3          AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo4          AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo5          AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo6          AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo7          AS INTEGER      NO-UNDO.
DEFINE VARIABLE tempo8          AS INTEGER      NO-UNDO.
DEFINE VARIABLE idIni           AS INTEGER      NO-UNDO.
DEFINE VARIABLE idFim           AS INTEGER      NO-UNDO.
DEFINE VARIABLE aux             AS INTEGER      NO-UNDO.


/* ***************************  Main Block  *************************** */


DO contador1 = 1 TO 10:

    ASSIGN tempoIni = MTIME.
    FOR FIRST {&Tabela} NO-LOCK: END.
    ASSIGN idIni = {&Tabela}.{&CampoIndice}.
    FOR LAST {&Tabela} NO-LOCK: END.
    ASSIGN idFim = {&Tabela}.{&CampoIndice}.
    DO contador2 = 1 TO numLeituras:
        FOR FIRST {&Tabela} NO-LOCK {&Condicao}: END.
        IF AVAILABLE {&Tabela} THEN
            ASSIGN aux = {&Tabela}.{&CampoIndice}.
    END.
    ASSIGN tempo1 = tempo1 + MTIME - tempoIni.

    ASSIGN tempoIni = MTIME.
    DO TRANSACTION:
        FOR FIRST {&Tabela} EXCLUSIVE-LOCK: END.
        ASSIGN idIni = {&Tabela}.{&CampoIndice}.
        FOR LAST {&Tabela} EXCLUSIVE-LOCK: END.
        ASSIGN idFim = {&Tabela}.{&CampoIndice}.
        DO contador2 = 1 TO numLeituras:
            FOR FIRST {&Tabela} EXCLUSIVE-LOCK {&Condicao}: END.
            IF AVAILABLE {&Tabela} THEN
                ASSIGN aux = {&Tabela}.{&CampoIndice}.
        END.
    END.
    ASSIGN tempo2 = tempo2 + MTIME - tempoIni.

    ASSIGN tempoIni = MTIME.
    FOR FIRST {&Tabela} FIELDS({&CampoIndice} {&CamposAdicionais}) NO-LOCK: END.
    ASSIGN idIni = {&Tabela}.{&CampoIndice}.
    FOR LAST {&Tabela} FIELDS({&CampoIndice} {&CamposAdicionais}) NO-LOCK: END.
    ASSIGN idFim = {&Tabela}.{&CampoIndice}.
    DO contador2 = 1 TO numLeituras:
        FOR FIRST {&Tabela} FIELDS({&CampoIndice} {&CamposAdicionais}) NO-LOCK {&Condicao}: END.
        IF AVAILABLE {&Tabela} THEN
            ASSIGN aux = {&Tabela}.{&CampoIndice}.
    END.
    ASSIGN tempo3 = tempo3 + MTIME - tempoIni.

    ASSIGN tempoIni = MTIME.
    DO TRANSACTION:
        FOR FIRST {&Tabela} FIELDS({&CampoIndice} {&CamposAdicionais}) EXCLUSIVE-LOCK: END.
        ASSIGN idIni = {&Tabela}.{&CampoIndice}.
        FOR LAST {&Tabela} FIELDS({&CampoIndice} {&CamposAdicionais}) EXCLUSIVE-LOCK: END.
        ASSIGN idFim = {&Tabela}.{&CampoIndice}.
        DO contador2 = 1 TO numLeituras:
            FOR FIRST {&Tabela} FIELDS({&CampoIndice} {&CamposAdicionais}) EXCLUSIVE-LOCK {&Condicao}: END.
            IF AVAILABLE {&Tabela} THEN
                ASSIGN aux = {&Tabela}.{&CampoIndice}.
        END.
    END.
    ASSIGN tempo4 = tempo4 + MTIME - tempoIni.

    ASSIGN tempoIni = MTIME.
    FIND FIRST {&Tabela} NO-LOCK.
    ASSIGN idIni = {&Tabela}.{&CampoIndice}.
    FIND LAST {&Tabela} NO-LOCK.
    ASSIGN idFim = {&Tabela}.{&CampoIndice}.
    DO contador2 = 1 TO numLeituras:
        FIND {&Tabela} NO-LOCK {&Condicao} NO-ERROR.
        IF AVAILABLE {&Tabela} THEN
            ASSIGN aux = {&Tabela}.{&CampoIndice}.
    END.
    ASSIGN tempo5 = tempo5 + MTIME - tempoIni.

    ASSIGN tempoIni = MTIME.
    DO TRANSACTION:
        FIND FIRST {&Tabela} EXCLUSIVE-LOCK.
        ASSIGN idIni = {&Tabela}.{&CampoIndice}.
        FIND LAST {&Tabela} EXCLUSIVE-LOCK.
        ASSIGN idFim = {&Tabela}.{&CampoIndice}.
        DO contador2 = 1 TO numLeituras:
            FIND {&Tabela} EXCLUSIVE-LOCK {&Condicao} NO-ERROR.
            IF AVAILABLE {&Tabela} THEN
                ASSIGN aux = {&Tabela}.{&CampoIndice}.
        END.
    END.
    ASSIGN tempo6 = tempo6 + MTIME - tempoIni.
    
    ASSIGN tempoIni = MTIME.
    FIND FIRST {&Tabela} NO-LOCK.
    ASSIGN idIni = {&Tabela}.{&CampoIndice}.
    FIND LAST {&Tabela} NO-LOCK.
    ASSIGN idFim = {&Tabela}.{&CampoIndice}.
    DO contador2 = 1 TO numLeituras:
        FIND FIRST {&Tabela} NO-LOCK {&Condicao} NO-ERROR.
        IF AVAILABLE {&Tabela} THEN
            ASSIGN aux = {&Tabela}.{&CampoIndice}.
    END.
    ASSIGN tempo7 = tempo7 + MTIME - tempoIni.

    ASSIGN tempoIni = MTIME.
    DO TRANSACTION:
        FIND FIRST {&Tabela} EXCLUSIVE-LOCK.
        ASSIGN idIni = {&Tabela}.{&CampoIndice}.
        FIND LAST {&Tabela} EXCLUSIVE-LOCK.
        ASSIGN idFim = {&Tabela}.{&CampoIndice}.
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
        "FIND" SKIP
        "No transaction:" tempo5 SKIP
        "Transaction:" tempo6 SKIP(1)
        "FIND FIRST" SKIP
        "No transaction:" tempo7 SKIP
        "Transaction:" tempo8
    VIEW-AS ALERT-BOX TITLE "Time in milis".
