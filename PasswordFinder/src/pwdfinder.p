/*------------------------------------------------------------------------
    File        : pwdfinder.p
    Purpose     : Tries to break a encoded string using brute force
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Wed Mar 04 13:55:12 BRT 2020
    Notes       :

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Definitions  ************************** */

DEFINE VARIABLE iEncodeType         AS INTEGER      NO-UNDO INITIAL 2. /*0 - abl encode, 1 - sha1, 2 - sha2 substring*/
DEFINE VARIABLE iComprMaxSenha      AS INTEGER      NO-UNDO INITIAL 8.
DEFINE VARIABLE iTesteComprimento   AS INTEGER      NO-UNDO.
DEFINE VARIABLE cSenhaEncontrada    AS CHARACTER    NO-UNDO.
DEFINE VARIABLE iContTentativas     AS INT64        NO-UNDO.
DEFINE VARIABLE cSenhaQuebrar       AS CHARACTER    NO-UNDO INITIAL "6AW2cBkCQgp1Y9UudRc6wzgtPBQ=".
DEFINE VARIABLE cDicionarios        AS CHARACTER    NO-UNDO EXTENT 4 INITIAL ["0,1,2,3,4,5,6,7,8,9",
                                                                              "abc,123,456,asd,asdf,senha,qwe,qwer,1234",
                                                                              "0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,-,@,#,$",
                                                                              "0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,!,-,@,#,$"].
DEFINE VARIABLE cCaracteres         AS CHARACTER    NO-UNDO.

DEFINE VARIABLE inicio              AS DATETIME     NO-UNDO.

DEFINE STREAM str-out.
DEFINE STREAM str-in.


/* ***************************  Main Block  *************************** */

ASSIGN inicio = NOW.

RUN pwdFinder IN THIS-PROCEDURE (OUTPUT cSenhaEncontrada).


MESSAGE "Senha encontrada:" cSenhaEncontrada SKIP "Início:" STRING (inicio, "99/99/9999 HH:MM:SS") SKIP "Segundos:" INTERVAL(NOW , inicio, "seconds") SKIP "Tentativas:" TRIM(STRING(iContTentativas, ">>>,>>>,>>>,>>>,>>>,>>>,>>9")) VIEW-AS ALERT-BOX.


/* **********************  Internal procedures  *********************** */

PROCEDURE pwdFinder:

    DEFINE OUTPUT PARAMETER cEncontrado         AS CHARACTER    NO-UNDO INITIAL ?.

    DEFINE VARIABLE lOk         AS LOGICAL      NO-UNDO.
    DEFINE VARIABLE iCharRange  AS INTEGER      NO-UNDO.


    RUN pwdTentativa IN THIS-PROCEDURE ("", OUTPUT lOk).
    IF lOk THEN DO:
        ASSIGN cEncontrado = "".
        RETURN.
    END.

    DO iCharRange = 1 TO EXTENT(cDicionarios):
        ASSIGN cCaracteres = cDicionarios[iCharRange].
        DO iTesteComprimento = 1 TO iComprMaxSenha:
            RUN crackGen IN THIS-PROCEDURE (1, "", OUTPUT cEncontrado).
            IF cEncontrado <> ? THEN
                RETURN.
        END.
    END.

END PROCEDURE.


PROCEDURE crackGen:

    DEFINE INPUT  PARAMETER iNivel              AS INTEGER      NO-UNDO.
    DEFINE INPUT  PARAMETER cPrefixo            AS CHARACTER    NO-UNDO.
    DEFINE OUTPUT PARAMETER cEncontrado         AS CHARACTER    NO-UNDO INITIAL ?.

    DEFINE VARIABLE iCont   AS INTEGER      NO-UNDO.
    DEFINE VARIABLE lOk     AS LOGICAL      NO-UNDO.


    DO iCont = 1 TO NUM-ENTRIES(cCaracteres):
        IF iNivel < iTesteComprimento AND LENGTH (cPrefixo + ENTRY(iCont, cCaracteres)) < iComprMaxSenha THEN DO:
            RUN crackGen IN THIS-PROCEDURE (iNivel + 1, cPrefixo + ENTRY(iCont, cCaracteres), OUTPUT cEncontrado).
            IF cEncontrado <> ? THEN
                RETURN.
        END.
        ELSE DO :
            RUN pwdTentativa IN THIS-PROCEDURE (cPrefixo + ENTRY(iCont, cCaracteres), OUTPUT lOk).
            IF lOk THEN DO:
                ASSIGN cEncontrado = cPrefixo + ENTRY(iCont, cCaracteres).
                RETURN.
            END.
        END.
    END.

END PROCEDURE.


PROCEDURE pwdTentativa:

    DEFINE INPUT  PARAMETER cTentativa  AS CHARACTER    NO-UNDO.
    DEFINE OUTPUT PARAMETER lOk         AS LOGICAL      NO-UNDO.

    DEFINE VARIABLE cLinha  AS CHARACTER    NO-UNDO.


    ASSIGN iContTentativas = iContTentativas + 1.

    IF iContTentativas MOD 100000 = 0 THEN DO:

        INPUT STREAM str-in FROM C:\Temp\pwdcontinua.txt CONVERT SOURCE "iso8859-1".
        IMPORT STREAM str-in UNFORMATTED cLinha.
        INPUT STREAM str-in CLOSE.

    END.


    IF ETIME > 10000 OR cLinha = "Encerrar" THEN DO:

        /*Zera arquivo*/
        OUTPUT STREAM str-out TO C:\Temp\pwdlist.txt CONVERT TARGET "UTF-8".
        PUT STREAM str-out UNFORMATTED
            "Início..........: " STRING (inicio, "99/99/9999 HH:MM:SS") SKIP
            "Segundos........: " INTERVAL(NOW , inicio, "seconds") SKIP
            "Tentativas......: " TRIM(STRING(iContTentativas, ">>>,>>>,>>>,>>>,>>>,>>>,>>9")) SKIP
            "Última tentativa: " cTentativa.
        OUTPUT STREAM str-out CLOSE.

        IF cLinha = "Encerrar" THEN
            RETURN ERROR.

        ETIME (TRUE).

    END.

    IF iEncodeType = 1 /*sha1*/ THEN
        ASSIGN lOk = (cSenhaQuebrar = STRING(SHA1-DIGEST(LOWER(cTentativa)))).
    ELSE IF iEncodeType = 2 /*sha2 substring*/ THEN
        ASSIGN lOk = (cSenhaQuebrar = SUBSTRING(STRING(SHA1-DIGEST(LOWER(cTentativa))), 7)).
    ELSE /*abl encode*/
        ASSIGN lOk = (cSenhaQuebrar = ENCODE(cTentativa)).

END PROCEDURE.
