/*------------------------------------------------------------------------
    File        : htmlEncodeCommon.i
    Purpose     : Include containing logic to translate character strings
                  to HTML standard.
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Fri Abr 08 09:47:39 BRT 2020
    Notes       :

        Licensed via LGPLv3

        Check for improvements at
        https://github.com/robinsonrk/OpenEdgeAblUtilities

  ----------------------------------------------------------------------*/

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Definitions  ************************** */

define input  parameter originalString  as character    no-undo.
define input  parameter encodingType    as character    no-undo. /* html: htmltext / url: entire url / qsp: query string parameter value only */
define output parameter encodedString   as character    no-undo case-sensitive.


/* ***************************  Main Block  *************************** */

assign encodedString = originalString.

/*Special HTML codes*/

assign encodedString = replace(encodedString, chr(38),  "&amp;")    /* ampersand &#38; */
       encodedString = replace(encodedString, chr(9),   "&#09;")    /* horizontal tab */
       encodedString = replace(encodedString, chr(10),  "&#10;")    /* line feed */
       encodedString = replace(encodedString, chr(13),  "&#13;")    /* carriage return / enter */
.

/*Regular HTML character codes*/

assign encodedString = replace(encodedString, chr(60),  "&lt;")     /* less than &#60; */
       encodedString = replace(encodedString, chr(62),  "&gt;")     /* greater than &#62; */
       encodedString = replace(encodedString, chr(92),  "&#92;")    /* backslash */
       encodedString = replace(encodedString, chr(94),  "&#94;")    /* caret / circumflex */
       encodedString = replace(encodedString, chr(96),  "&#96;")    /* grave / accent */
       encodedString = replace(encodedString, chr(123), "&#123;")   /* left curly bracket */
       encodedString = replace(encodedString, chr(125), "&#125;")   /* right curly bracket */
       encodedString = replace(encodedString, chr(126), "&#126;")   /* tilde */
       /*encodedString = replace(encodedString, "0", "&#48;")       * zero */
       /*encodedString = replace(encodedString, "1", "&#49;")       * one */
       /*encodedString = replace(encodedString, "2", "&#50;")       * two */
       /*encodedString = replace(encodedString, "3", "&#51;")       * three */
       /*encodedString = replace(encodedString, "4", "&#52;")       * four */
       /*encodedString = replace(encodedString, "5", "&#53;")       * five */
       /*encodedString = replace(encodedString, "6", "&#54;")       * six */
       /*encodedString = replace(encodedString, "7", "&#55;")       * seven */
       /*encodedString = replace(encodedString, "8", "&#56;")       * eight */
       /*encodedString = replace(encodedString, "9", "&#57;")       * nine */
       /*encodedString = replace(encodedString, "A", "&#65;")       */
       /*encodedString = replace(encodedString, "B", "&#66;")       */
       /*encodedString = replace(encodedString, "C", "&#67;")       */
       /*encodedString = replace(encodedString, "D", "&#68;")       */
       /*encodedString = replace(encodedString, "E", "&#69;")       */
       /*encodedString = replace(encodedString, "F", "&#70;")       */
       /*encodedString = replace(encodedString, "G", "&#71;")       */
       /*encodedString = replace(encodedString, "H", "&#72;")       */
       /*encodedString = replace(encodedString, "I", "&#73;")       */
       /*encodedString = replace(encodedString, "J", "&#74;")       */
       /*encodedString = replace(encodedString, "K", "&#75;")       */
       /*encodedString = replace(encodedString, "L", "&#76;")       */
       /*encodedString = replace(encodedString, "M", "&#77;")       */
       /*encodedString = replace(encodedString, "N", "&#78;")       */
       /*encodedString = replace(encodedString, "O", "&#79;")       */
       /*encodedString = replace(encodedString, "P", "&#80;")       */
       /*encodedString = replace(encodedString, "Q", "&#81;")       */
       /*encodedString = replace(encodedString, "R", "&#82;")       */
       /*encodedString = replace(encodedString, "S", "&#83;")       */
       /*encodedString = replace(encodedString, "T", "&#84;")       */
       /*encodedString = replace(encodedString, "U", "&#85;")       */
       /*encodedString = replace(encodedString, "V", "&#86;")       */
       /*encodedString = replace(encodedString, "W", "&#87;")       */
       /*encodedString = replace(encodedString, "X", "&#88;")       */
       /*encodedString = replace(encodedString, "Y", "&#89;")       */
       /*encodedString = replace(encodedString, "Z", "&#90;")       */
       /*encodedString = replace(encodedString, "_", "&#95;")       * underscore */
       /*encodedString = replace(encodedString, "a", "&#97;")       */
       /*encodedString = replace(encodedString, "b", "&#98;")       */
       /*encodedString = replace(encodedString, "c", "&#99;")       */
       /*encodedString = replace(encodedString, "d", "&#100;")      */
       /*encodedString = replace(encodedString, "e", "&#101;")      */
       /*encodedString = replace(encodedString, "f", "&#102;")      */
       /*encodedString = replace(encodedString, "g", "&#103;")      */
       /*encodedString = replace(encodedString, "h", "&#104;")      */
       /*encodedString = replace(encodedString, "i", "&#105;")      */
       /*encodedString = replace(encodedString, "j", "&#106;")      */
       /*encodedString = replace(encodedString, "k", "&#107;")      */
       /*encodedString = replace(encodedString, "l", "&#108;")      */
       /*encodedString = replace(encodedString, "m", "&#109;")      */
       /*encodedString = replace(encodedString, "n", "&#110;")      */
       /*encodedString = replace(encodedString, "o", "&#111;")      */
       /*encodedString = replace(encodedString, "p", "&#112;")      */
       /*encodedString = replace(encodedString, "q", "&#113;")      */
       /*encodedString = replace(encodedString, "r", "&#114;")      */
       /*encodedString = replace(encodedString, "s", "&#115;")      */
       /*encodedString = replace(encodedString, "t", "&#116;")      */
       /*encodedString = replace(encodedString, "u", "&#117;")      */
       /*encodedString = replace(encodedString, "v", "&#118;")      */
       /*encodedString = replace(encodedString, "w", "&#119;")      */
       /*encodedString = replace(encodedString, "x", "&#120;")      */
       /*encodedString = replace(encodedString, "y", "&#121;")      */
       /*encodedString = replace(encodedString, "z", "&#122;")      */
.

if encodingType = "html" then
    assign encodedString = replace(encodedString, chr(32),  "&nbsp;")   /* non-breaking space &#160; */
           encodedString = replace(encodedString, chr(34),  "&quot;")   /* double quote &#34; */
           encodedString = replace(encodedString, chr(39),  "&apos;")   /* single quote &#39; */
           
    .

if encodingType = "url" or encodingType = "qsp" then
    assign encodedString = replace(encodedString, chr(32),  "&#32;")    /* space */
           encodedString = replace(encodedString, chr(34),  "&#34")     /* double quote ; */
           encodedString = replace(encodedString, chr(39),  "&#39;")    /* single quote  */
           encodedString = replace(encodedString, chr(33),  "&#33;")    /* exclamation mark */
           encodedString = replace(encodedString, chr(35),  "&#35;")    /* number */
           encodedString = replace(encodedString, chr(36),  "&#36;")    /* dollar */
           encodedString = replace(encodedString, chr(37),  "&#37;")    /* percent */
           encodedString = replace(encodedString, chr(40),  "&#40;")    /* left parenthesis */
           encodedString = replace(encodedString, chr(41),  "&#41;")    /* right parenthesis */
           encodedString = replace(encodedString, chr(42),  "&#42;")    /* asterisk */
           encodedString = replace(encodedString, chr(91),  "&#91;")    /* left square bracket */
           encodedString = replace(encodedString, chr(93),  "&#93;")    /* right square bracket */
           encodedString = replace(encodedString, chr(124), "&#124;")   /* vertical bar */
    .

if encodingType = "qsp" then
    assign encodedString = replace(encodedString, chr(43),  "&#43;")    /* plus */
           encodedString = replace(encodedString, chr(44),  "&#44;")    /* comma */
           encodedString = replace(encodedString, chr(45),  "&#45;")    /* minus */
           encodedString = replace(encodedString, chr(46),  "&#46;")    /* period */
           encodedString = replace(encodedString, chr(47),  "&#47;")    /* slash */
           encodedString = replace(encodedString, chr(58),  "&#58;")    /* colon */
           encodedString = replace(encodedString, chr(59),  "&#59;")    /* semicolon */
           encodedString = replace(encodedString, chr(61),  "&#61;")    /* equality sign */
           encodedString = replace(encodedString, chr(63),  "&#63;")    /* question mark */
           encodedString = replace(encodedString, chr(64),  "&#64;")    /* at sign */
    .

/*Extra codes*/

assign encodedString = replace(encodedString, chr(128), "&euro;")   /* euro &#8364; */
       encodedString = replace(encodedString, chr(161), "&iexcl;")  /* inverted exclamation mark &#161; */
       encodedString = replace(encodedString, chr(162), "&cent;")   /* cent sign &#162; */
       encodedString = replace(encodedString, chr(163), "&pound;")  /* pound sign &#163; */
       encodedString = replace(encodedString, chr(164), "&curren;") /* currency sign &#164; */
       encodedString = replace(encodedString, chr(165), "&yen;")    /* yen sign &#165; */
       encodedString = replace(encodedString, chr(166), "&brvbar;") /* broken bar &#166; */
       encodedString = replace(encodedString, chr(167), "&sect;")   /* section sign &#167; */
       encodedString = replace(encodedString, chr(168), "&uml;")    /* diaeresis &#168; */
       encodedString = replace(encodedString, chr(169), "&copy;")   /* copyright sign &#169; */
       encodedString = replace(encodedString, chr(170), "&ordf;")   /* feminine ordinal indicator &#170; */
       encodedString = replace(encodedString, chr(171), "&laquo;")  /* left pointing guillemet &#171; */
       encodedString = replace(encodedString, chr(172), "&not;")    /* not sign &#172; */
       encodedString = replace(encodedString, chr(173), "&shy;")    /* soft hyphen &#173; */
       encodedString = replace(encodedString, chr(174), "&reg;")    /* registered sign &#174; */
       encodedString = replace(encodedString, chr(175), "&macr;")   /* macron &#175; */
       encodedString = replace(encodedString, chr(176), "&deg;")    /* degree sign &#176; */
       encodedString = replace(encodedString, chr(177), "&plusmn;") /* plus-minus sign &#177; */
       encodedString = replace(encodedString, chr(178), "&sup2;")   /* superscript two &#178; */
       encodedString = replace(encodedString, chr(179), "&sup3;")   /* superscript three &#179; */
       encodedString = replace(encodedString, chr(180), "&acute;")  /* acute accent &#180; */
       encodedString = replace(encodedString, chr(181), "&micro;")  /* micro sign &#181; */
       encodedString = replace(encodedString, chr(182), "&para;")   /* paragraph sign &#182; */
       encodedString = replace(encodedString, chr(183), "&middot;") /* middle dot &#183; */
       encodedString = replace(encodedString, chr(184), "&cedil;")  /* spacing cedilla &#184; */
       encodedString = replace(encodedString, chr(185), "&sup1;")   /* superscript one &#185; */
       encodedString = replace(encodedString, chr(186), "&ordm;")   /* masculine ordinal indicator &#186; */
       encodedString = replace(encodedString, chr(187), "&raquo;")  /* right pointing guillemet &#187; */
       encodedString = replace(encodedString, chr(188), "&frac14;") /* fraction one quarter &#188; */
       encodedString = replace(encodedString, chr(189), "&frac12;") /* fraction one half &#189; */
       encodedString = replace(encodedString, chr(190), "&frac34;") /* fraction three quarters &#190; */
       encodedString = replace(encodedString, chr(191), "&iquest;") /* inverted question mark &#191; */
       encodedString = replace(encodedString, chr(192), "&Agrave;") /* capital A with grave &#192; */
       encodedString = replace(encodedString, chr(193), "&Aacute;") /* capital A with acute &#193; */
       encodedString = replace(encodedString, chr(194), "&Acirc;")  /* capital A with circumflex &#194; */
       encodedString = replace(encodedString, chr(195), "&Atilde;") /* capital A with tilde &#195; */
       encodedString = replace(encodedString, chr(196), "&Auml;")   /* capital A with diaeresis &#196; */
       encodedString = replace(encodedString, chr(197), "&Aring;")  /* capital A with ring &#197; */
       encodedString = replace(encodedString, chr(198), "&AElig;")  /* capital AE &#198; */
       encodedString = replace(encodedString, chr(199), "&Ccedil;") /* capital C with cedilla &#199; */
       encodedString = replace(encodedString, chr(200), "&Egrave;") /* capital E with grave &#200; */
       encodedString = replace(encodedString, chr(201), "&Eacute;") /* capital E with acute &#201; */
       encodedString = replace(encodedString, chr(202), "&Ecirc;")  /* capital E with circumflex &#202; */
       encodedString = replace(encodedString, chr(203), "&Euml;")   /* capital E with diaeresis &#203; */
       encodedString = replace(encodedString, chr(204), "&Igrave;") /* capital I with grave &#204; */
       encodedString = replace(encodedString, chr(205), "&Iacute;") /* capital I with acute &#205; */
       encodedString = replace(encodedString, chr(206), "&Icirc;")  /* capital I with circumflex &#206; */
       encodedString = replace(encodedString, chr(207), "&Iuml;")   /* capital I with diaeresis &#207; */
       encodedString = replace(encodedString, chr(208), "&ETH;")    /* capital ETH &#208; */
       encodedString = replace(encodedString, chr(209), "&Ntilde;") /* capital N with tilde &#209; */
       encodedString = replace(encodedString, chr(210), "&Ograve;") /* capital O with grave &#210; */
       encodedString = replace(encodedString, chr(211), "&Oacute;") /* capital O with acute &#211; */
       encodedString = replace(encodedString, chr(212), "&Ocirc;")  /* capital O with circumflex &#212; */
       encodedString = replace(encodedString, chr(213), "&Otilde;") /* capital O with tilde &#213; */
       encodedString = replace(encodedString, chr(214), "&Ouml;")   /* capital O with diaeresis &#214; */
       encodedString = replace(encodedString, chr(215), "&times;")  /* multiplication sign &#215; */
       encodedString = replace(encodedString, chr(216), "&Oslash;") /* capital O with stroke &#216; */
       encodedString = replace(encodedString, chr(217), "&Ugrave;") /* capital U with grave &#217; */
       encodedString = replace(encodedString, chr(218), "&Uacute;") /* capital U with acute &#218; */
       encodedString = replace(encodedString, chr(219), "&Ucirc;")  /* capital U with circumflex &#219; */
       encodedString = replace(encodedString, chr(220), "&Uuml;")   /* capital U with diaeresis &#220; */
       encodedString = replace(encodedString, chr(221), "&Yacute;") /* capital Y with acute &#221; */
       encodedString = replace(encodedString, chr(222), "&THORN;")  /* capital THORN &#222; */
       encodedString = replace(encodedString, chr(223), "&szlig;")  /* small sharp s &#223; */
       encodedString = replace(encodedString, chr(224), "&agrave;") /* small a with grave &#224; */
       encodedString = replace(encodedString, chr(225), "&aacute;") /* small a with acute &#225; */
       encodedString = replace(encodedString, chr(226), "&acirc;")  /* small a with circumflex &#226; */
       encodedString = replace(encodedString, chr(227), "&atilde;") /* small a with tilde &#227; */
       encodedString = replace(encodedString, chr(228), "&auml;")   /* small a with diaeresis &#228; */
       encodedString = replace(encodedString, chr(229), "&aring;")  /* small a with ring above &#229; */
       encodedString = replace(encodedString, chr(230), "&aelig;")  /* small ae &#230; */
       encodedString = replace(encodedString, chr(231), "&ccedil;") /* small c with cedilla &#231; */
       encodedString = replace(encodedString, chr(232), "&egrave;") /* small e with grave &#232; */
       encodedString = replace(encodedString, chr(233), "&eacute;") /* small e with acute &#233; */
       encodedString = replace(encodedString, chr(234), "&ecirc;")  /* small e with circumflex &#234; */
       encodedString = replace(encodedString, chr(235), "&euml;")   /* small e with diaeresis &#235; */
       encodedString = replace(encodedString, chr(236), "&igrave;") /* small i with grave &#236; */
       encodedString = replace(encodedString, chr(237), "&iacute;") /* small i with acute &#237; */
       encodedString = replace(encodedString, chr(238), "&icirc;")  /* small i with circumflex &#238; */
       encodedString = replace(encodedString, chr(239), "&iuml;")   /* small i with diaeresis &#239; */
       encodedString = replace(encodedString, chr(240), "&eth;")    /* small eth &#240; */
       encodedString = replace(encodedString, chr(241), "&ntilde;") /* small n with tilde &#241; */
       encodedString = replace(encodedString, chr(242), "&ograve;") /* small o with grave &#242; */
       encodedString = replace(encodedString, chr(243), "&oacute;") /* small o with acute &#243; */
       encodedString = replace(encodedString, chr(244), "&ocirc;")  /* small o with circumflex &#244; */
       encodedString = replace(encodedString, chr(245), "&otilde;") /* small o with tilde &#245; */
       encodedString = replace(encodedString, chr(246), "&ouml;")   /* small o with diaeresis &#246; */
       encodedString = replace(encodedString, chr(247), "&divide;") /* division sign &#247; */
       encodedString = replace(encodedString, chr(248), "&oslash;") /* small o with stroke &#248; */
       encodedString = replace(encodedString, chr(249), "&ugrave;") /* small u with grave &#249; */
       encodedString = replace(encodedString, chr(250), "&uacute;") /* small u with acute &#250; */
       encodedString = replace(encodedString, chr(251), "&ucirc;")  /* small u with circumflex &#251; */
       encodedString = replace(encodedString, chr(252), "&uuml;")   /* small u with diaeresis &#252; */
       encodedString = replace(encodedString, chr(253), "&yacute;") /* small y with acute &#253; */
       encodedString = replace(encodedString, chr(254), "&thorn;")  /* small thorn &#254; */
       encodedString = replace(encodedString, chr(255), "&yuml;")   /* small y with diaeresis &#255; */
.

/*HTML math symbols codes*/

assign encodedString = replace(encodedString, chr(149), "&bull;")   /* bullet &#8226; */
       /*encodedString = replace(encodedString, , "&#9702;")        * white bullet */
       /*encodedString = replace(encodedString, , "&#8729;")        * bullet operator */
       /*encodedString = replace(encodedString, , "&#8227;")        * triangular bullet */
       /*encodedString = replace(encodedString, , "&#8259;")        * hyphen bullet */
       /*encodedString = replace(encodedString, , "&infin;")        * infinity &#8734; */
       encodedString = replace(encodedString, chr(137), "&permil;") /* per-mille &#8240; */
       /*encodedString = replace(encodedString, , "&dagger;")       * hermitian &#8224; */
       encodedString = replace(encodedString, chr(151), "&mdash;")  /* &#8212; */
       /*encodedString = replace(encodedString, , "&perp;")         * &#8869; */
       /*encodedString = replace(encodedString, , "&par;")          * &#8741; */
.

/*Other currency codes*/

/*
assign /-*encodedString = replace(encodedString, , "&#8377;")        * indian Rupee *-/
       /-*encodedString = replace(encodedString, , "&#8360;")        * rupee *-/
       /-*encodedString = replace(encodedString, , "&#8369;")        * peso *-/
       /-*encodedString = replace(encodedString, , "&#8361;")        * korean won *-/
       /-*encodedString = replace(encodedString, , "&#3647;")        * thai baht *-/
       /-*encodedString = replace(encodedString, , "&#8363;")        * dong *-/
       /-*encodedString = replace(encodedString, , "&#8362;")        * shekel *-/
.
*/

/*Intellectual property codes*/

assign /*encodedString = replace(encodedString, , "&#8471;")        * sound recording copyright */
       encodedString = replace(encodedString, chr(153), "&trade;")  /* trademark &#8482; */
       /*encodedString = replace(encodedString, , "&#8480;")        * service mark */
.

/*Greek alphabet codes*/
/*
assign encodedString = replace(encodedString, , "&alpha;")          /-* small alpha &#945; *-/
       encodedString = replace(encodedString, , "&beta;")           /-* small beta &#946; *-/
       encodedString = replace(encodedString, , "&gamma;")          /-* small gamma &#947; *-/
       encodedString = replace(encodedString, , "&delta;")          /-* small delta &#948; *-/
       encodedString = replace(encodedString, , "&epsilon;")        /-* small epsilon &#949; *-/
       encodedString = replace(encodedString, , "&zeta;")           /-* small zeta &#950; *-/
       encodedString = replace(encodedString, , "&eta;")            /-* small eta &#951; *-/
       encodedString = replace(encodedString, , "&theta;")          /-* small theta &#952; *-/
       encodedString = replace(encodedString, , "&iota;")           /-* small iota &#953; *-/
       encodedString = replace(encodedString, , "&kappa;")          /-* small kappa &#954; *-/
       encodedString = replace(encodedString, , "&lambda;")         /-* small lambda &#955; *-/
       encodedString = replace(encodedString, , "&mu;")             /-* small mu &#956; *-/
       encodedString = replace(encodedString, , "&nu;")             /-* small nu &#957; *-/
       encodedString = replace(encodedString, , "&xi;")             /-* small xi &#958; *-/
       encodedString = replace(encodedString, , "&omicron;")        /-* small omicron &#959; *-/
       encodedString = replace(encodedString, , "&pi;")             /-* small pi &#960; *-/
       encodedString = replace(encodedString, , "&rho;")            /-* small rho &#961; *-/
       encodedString = replace(encodedString, , "&sigma;")          /-* small sigma &#963;*-/
       encodedString = replace(encodedString, , "&tau;")            /-* small tau &#964; *-/
       encodedString = replace(encodedString, , "&upsilon;")        /-* small upsilon &#965; *-/
       encodedString = replace(encodedString, , "&phi;")            /-* small phi &#966; *-/
       encodedString = replace(encodedString, , "&chi;")            /-* small chi &#967; *-/
       encodedString = replace(encodedString, , "&psi;")            /-* small psi &#968; *-/
       encodedString = replace(encodedString, , "&omega;")          /-* small omega &#969; *-/
       encodedString = replace(encodedString, , "&Alpha;")          /-* capital alpha &#913; *-/
       encodedString = replace(encodedString, , "&Beta;")           /-* capital beta &#914; *-/
       encodedString = replace(encodedString, , "&Gamma;")          /-* capital gamma &#915; *-/
       encodedString = replace(encodedString, , "&Delta;")          /-* capital delta &#916; *-/
       encodedString = replace(encodedString, , "&Epsilon;")        /-* capital epsilon &#917; *-/
       encodedString = replace(encodedString, , "&Zeta;")           /-* capital zeta &#918; *-/
       encodedString = replace(encodedString, , "&Eta;")            /-* capital eta &#919; *-/
       encodedString = replace(encodedString, , "&Theta;")          /-* capital theta &#920; *-/
       encodedString = replace(encodedString, , "&Iota;")           /-* capital iota &#921; *-/
       encodedString = replace(encodedString, , "&Kappa;")          /-* capital kappa &#922; *-/
       encodedString = replace(encodedString, , "&Lambda;")         /-* capital lambda &#923; *-/
       encodedString = replace(encodedString, , "&Mu;")             /-* capital mu &#924; *-/
       encodedString = replace(encodedString, , "&Nu;")             /-* capital nu &#925; *-/
       encodedString = replace(encodedString, , "&Xi;")             /-* capital xi &#926; *-/
       encodedString = replace(encodedString, , "&Omicron;")        /-* capital omicron &#927; *-/
       encodedString = replace(encodedString, , "&Pi;")             /-* capital pi &#928; *-/
       encodedString = replace(encodedString, , "&Rho;")            /-* capital rho &#929; *-/
       encodedString = replace(encodedString, , "&Sigma;")          /-* capital sigma &#931; *-/
       encodedString = replace(encodedString, , "&Tau;")            /-* capital tau &#932; *-/
       encodedString = replace(encodedString, , "&Upsilon;")        /-* capital upsilon &#933; *-/
       encodedString = replace(encodedString, , "&Phi;")            /-* capital phi &#934; *-/
       encodedString = replace(encodedString, , "&Chi;")            /-* capital chi &#935; *-/
       encodedString = replace(encodedString, , "&Psi;")            /-* capital psi &#936; *-/
       encodedString = replace(encodedString, , "&Omega;")          /-* capital omega &#937; *-/
.
*/
