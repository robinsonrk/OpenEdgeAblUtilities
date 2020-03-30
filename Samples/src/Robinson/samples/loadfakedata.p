/*------------------------------------------------------------------------
    File        : loadfakedata.p
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : Robinson Koprowski
    Created     : Thu Mar 26 16:58:35 BRT 2020
    Notes       :
  ----------------------------------------------------------------------*/

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE TEMP-TABLE ttOrdem NO-UNDO
    FIELD nr-ordem-compra AS INTEGER
    FIELD destino AS CHARACTER
    FIELD it-fornec AS CHARACTER
    FIELD it-codigo AS CHARACTER
    FIELD perc-ipi AS DECIMAL  DECIMALS 4
    FIELD vl-ipi AS DECIMAL DECIMALS 4
    FIELD narrativa-item AS CHARACTER
    FIELD narrativa-ordem AS CHARACTER
    INDEX idOrdem IS PRIMARY UNIQUE nr-ordem-compra.

DEFINE TEMP-TABLE ttParcela NO-UNDO
    FIELD nr-ordem-compra LIKE ttOrdem.nr-ordem-compra
    FIELD nr-parcela AS INTEGER
    FIELD quantidade AS DECIMAL DECIMALS 4
    FIELD unid-medida AS CHARACTER
    FIELD pre-uni AS DECIMAL DECIMALS 4
    FIELD val-desconto AS DECIMAL DECIMALS 4
    FIELD val-enc-fin AS DECIMAL DECIMALS 4
    FIELD pre-total AS DECIMAL
    FIELD dt-entrega AS DATE
    FIELD ref-item AS CHARACTER
    INDEX idParcela IS PRIMARY UNIQUE nr-ordem-compra nr-parcela.


DEFINE OUTPUT PARAMETER TABLE FOR ttOrdem.
DEFINE OUTPUT PARAMETER TABLE FOR ttParcela.


/* ***************************  Main Block  *************************** */


CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879338
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0952'
       ttOrdem.it-codigo = '25-255-0952'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO, PRINCIPIO ATIVO : IBUPROFENO  600 MG, CADA DRÁGEA CONTÉM: IBUPROFENO 600'
                              + 'MG.EXCIPIENTES: CELULOSE MICROCRISTALINA, GLICOLATO AMIDO SÓDICO, SÍLICA PRECIPITADA AMORFA,'
                              + 'ESTEARATO DE MAGNÉSIO, TALCO, OPADRY, CORANTE F.S  CAIXA COM 20 COMPRIMIDOS'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO, PRINCIPIO ATIVO : IBUPROFENO  600 MG, CADA DRÁGEA CONTÉM: IBUPROFENO 600'
                               + 'MG.EXCIPIENTES: CELULOSE MICROCRISTALINA, GLICOLATO AMIDO SÓDICO, SÍLICA PRECIPITADA AMORFA,'
                               + 'ESTEARATO DE MAGNÉSIO, TALCO, OPADRY, CORANTE F.S  CAIXA COM 20 COMPRIMIDOS'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879338
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 10
       ttParcela.unid-medida = 'CX'
       ttParcela.pre-uni = 16.99
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 169.9
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879340
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0963'
       ttOrdem.it-codigo = '25-255-0963'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO, ANALGESICO, PRINCIPIO ATIVO CODEINA 30MG , REFERENCIA: CODEX 30MG-12CP;'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO, ANALGESICO, PRINCIPIO ATIVO CODEINA 30MG , REFERENCIA: CODEX 30MG-12CP;'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879340
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'CX'
       ttParcela.pre-uni = 30.95
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 30.95
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879341
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0474'
       ttOrdem.it-codigo = '25-255-0474'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'DIPIRONA GOTAS, EMBALAGEM FRASCO(20 ML)'
       ttOrdem.narrativa-ordem = 'DIPIRONA GOTAS, EMBALAGEM FRASCO(20 ML)'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879341
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 3.5
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 3.5
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879342
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0503'
       ttOrdem.it-codigo = '25-255-0503'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'POMADA SULFADIAZINA DE PRATA PARA QUEIMADURA, MANIPULADA, 100 GRAMAS.'
       ttOrdem.narrativa-ordem = 'POMADA SULFADIAZINA DE PRATA PARA QUEIMADURA, MANIPULADA, 100 GRAMAS.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879342
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 3
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 18.67
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 56.01
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879343
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0945'
       ttOrdem.it-codigo = '25-255-0945'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO TANDENE 125MG, ANTIFLAMATORIO, ANALGESICO.'
                              + 'FORNECIDO EM CAIXA C/ 30 COMPRIMIDOS'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO TANDENE 125MG, ANTIFLAMATORIO, ANALGESICO.'
                               + 'FORNECIDO EM CAIXA C/ 30 COMPRIMIDOS'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879343
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'CX'
       ttParcela.pre-uni = 29.99
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 29.99
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879344
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-1126'
       ttOrdem.it-codigo = '25-255-1126'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO DESLORATADINA 5MG, ANTIALERGICO.'
                              + 'FORNECIDO EM CAIXA CONTENDO 30 COMPRIMIDOS REVESTIDOS.'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO DESLORATADINA 5MG, ANTIALERGICO.'
                               + 'FORNECIDO EM CAIXA CONTENDO 30 COMPRIMIDOS REVESTIDOS.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879344
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 10
       ttParcela.unid-medida = 'CX'
       ttParcela.pre-uni = 49.99
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 499.9
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879345
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-258-0046'
       ttOrdem.it-codigo = '25-258-0046'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'SERINGA DESCARTAVEL CAPACIDADE: 5 ML.'
       ttOrdem.narrativa-ordem = 'SERINGA DESCARTAVEL CAPACIDADE: 5 ML.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879345
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 3
       ttParcela.unid-medida = 'PC '
       ttParcela.pre-uni = 1
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 3
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879347
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-1077'
       ttOrdem.it-codigo = '25-255-1077'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO ANTINFLAMATORIO A BASE DE CLORIDRATO DE CICLOBENZAPRINA,  10MG FRONECISDO EM EMBALAGENS'
                              + 'COM 15 COMPRIMIDOS, REFERENCIA: MUSCULARE E OMIOZAN'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO ANTINFLAMATORIO A BASE DE CLORIDRATO DE CICLOBENZAPRINA,  10MG FRONECISDO EM EMBALAGENS'
                               + 'COM 15 COMPRIMIDOS, REFERENCIA: MUSCULARE E OMIOZAN'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879347
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'CX'
       ttParcela.pre-uni = 14.2
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 14.2
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879347
       ttParcela.nr-parcela = 2
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'CX'
       ttParcela.pre-uni = 14.2
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 14.2
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879347
       ttParcela.nr-parcela = 3
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'CX'
       ttParcela.pre-uni = 14.2
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 14.2
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879348
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0828'
       ttOrdem.it-codigo = '25-255-0828'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO CETOPROFENO 100 MG. ANTIINFLAMATORIO E ANALGESICO, FORNECIDO EM CAIXA COM 20 COMPRIMIDOS'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO CETOPROFENO 100 MG. ANTIINFLAMATORIO E ANALGESICO, FORNECIDO EM CAIXA COM 20 COMPRIMIDOS'
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879349
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0586'
       ttOrdem.it-codigo = '25-255-0586'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO, ANTINFLAMATORIO, PRICIPIO ATIVO: TOBRAMICINA E DEXAMETAZONA, REFERENCIA:  TOBREX'
                              + 'COLIRIO, 5 ML.'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO, ANTINFLAMATORIO, PRICIPIO ATIVO: TOBRAMICINA E DEXAMETAZONA, REFERENCIA:  TOBREX'
                               + 'COLIRIO, 5 ML.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879349
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 35.16
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 35.16
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879350
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0457'
       ttOrdem.it-codigo = '25-255-0457'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO ANALGESICO EM COMPRIMIDOS, CLORIDRATO DE TRAMADOL 50MG, INDICADO PARA ALIVIO DE DOR,'
                              + 'INTENSIDADE MODERADA A GRAVE.'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO ANALGESICO EM COMPRIMIDOS, CLORIDRATO DE TRAMADOL 50MG, INDICADO PARA ALIVIO DE DOR,'
                               + 'INTENSIDADE MODERADA A GRAVE.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879350
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 27.43
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 27.43
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879351
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0665'
       ttOrdem.it-codigo = '25-255-0665'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'LORATADINA 10 MG COM 12 COMPRIMIDOS.'
                              + 'ACIDO CITRICO BENZOATO DE SODIO; GLICEROL, PROPILENOGLICOL, SACAROSE.'
                              + 'MEDICAMENTO HISTAMINICO QUE AJUDAM REDUZIR SINTOMAS DA ALERGIA.'
       ttOrdem.narrativa-ordem = 'LORATADINA 10 MG COM 12 COMPRIMIDOS.'
                               + 'ACIDO CITRICO BENZOATO DE SODIO; GLICEROL, PROPILENOGLICOL, SACAROSE.'
                               + 'MEDICAMENTO HISTAMINICO QUE AJUDAM REDUZIR SINTOMAS DA ALERGIA.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879351
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 6
       ttParcela.unid-medida = 'CX'
       ttParcela.pre-uni = 11
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 66
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879352
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0951'
       ttOrdem.it-codigo = '25-255-0951'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO POMADA ONCILEG 30GR, PARA QUEIMADURA.'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO POMADA ONCILEG 30GR, PARA QUEIMADURA.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879352
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'GR '
       ttParcela.pre-uni = 38.54
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 38.54
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879353
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-1105'
       ttOrdem.it-codigo = '25-255-1105'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO POMADA TROK-G. DIPROPIONATO DE BETAMETASONA + SULFATO DE GENTAMICINA). INDICADO PARA O'
                              + 'ALIVIO DE INFLAMACAO ASSOCIADA A DOENCAS DE PELE SENSIVEIS AOS CORTICOIDES COMPLICADAS POR INFECCAO'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO POMADA TROK-G. DIPROPIONATO DE BETAMETASONA + SULFATO DE GENTAMICINA). INDICADO PARA O'
                               + 'ALIVIO DE INFLAMACAO ASSOCIADA A DOENCAS DE PELE SENSIVEIS AOS CORTICOIDES COMPLICADAS POR INFECCAO'
                               + 'CAUSADA POR BACTERIAS SENSIVEIS A GENTAMICINA. FORNECIDO EM EMBALAGENS COM 30 GR.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879353
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 2
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 16
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 32
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879354
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0307'
       ttOrdem.it-codigo = '25-255-0307'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'CEFACLOR 250MG, ANTIBIOTICO INDICADO PARA TRATAMENTO DE INFECCOES.'
                              + 'FORNECIDO EM FRASCO CONTENDO: 80ML.'
       ttOrdem.narrativa-ordem = 'CEFACLOR 250MG, ANTIBIOTICO INDICADO PARA TRATAMENTO DE INFECCOES.'
                               + 'FORNECIDO EM FRASCO CONTENDO: 80ML.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879354
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 2
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 40.56
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 81.12
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879355
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0684'
       ttOrdem.it-codigo = '25-255-0684'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO CEFTRIAXONA 1G INJETAVEL INTRA-MUSCULAR, UTILIZADO PARA TRATAR INFECCOES.'
                              + 'FORNECIDO EM AMPOLA DE 3,5ML.'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO CEFTRIAXONA 1G INJETAVEL INTRA-MUSCULAR, UTILIZADO PARA TRATAR INFECCOES.'
                               + 'FORNECIDO EM AMPOLA DE 3,5ML.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879355
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 3
       ttParcela.unid-medida = 'PC '
       ttParcela.pre-uni = 18.99
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 56.97
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879356
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-1028'
       ttOrdem.it-codigo = '25-255-1028'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO FIBRINASE POMADA10G, ANTINFLAMATORIA E DERMATOLOGICA PARA QUEIMADURA, PRINCIPIO ATIVO:'
                              + 'DESOXIRRIBONUCLESE 666 U/G + FIBRINOLISINA 1U/G + CLORAFENICOL 0,01 G/G.'
                              + 'FORNECIDO EM BISNAGA COM 10GR.'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO FIBRINASE POMADA10G, ANTINFLAMATORIA E DERMATOLOGICA PARA QUEIMADURA, PRINCIPIO ATIVO:'
                               + 'DESOXIRRIBONUCLESE 666 U/G + FIBRINOLISINA 1U/G + CLORAFENICOL 0,01 G/G.'
                               + 'FORNECIDO EM BISNAGA COM 10GR.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879356
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 29.18
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 29.18
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879357
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-1127'
       ttOrdem.it-codigo = '25-255-1127'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO PREDNISOLONA 20MG, ANTI-INFLAMATORIO ESTEROIDE, INDICADO PARA O TRATAMENTO DE'
                              + 'REUMATISMO, ALTERACOES HORMONAIS, COLAGENOSES, ALERGIAS.'
                              + 'FORNECIDO EM CAIXAS CONTENDO 10 COMPRIMIDOS.'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO PREDNISOLONA 20MG, ANTI-INFLAMATORIO ESTEROIDE, INDICADO PARA O TRATAMENTO DE'
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879358
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0634'
       ttOrdem.it-codigo = '25-255-0634'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'NIMESULIDA, 100 MG, EMBALAGEM COM 12 CAPSULAS'
       ttOrdem.narrativa-ordem = 'NIMESULIDA, 100 MG, EMBALAGEM COM 12 CAPSULAS'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879358
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 13.81
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 13.81
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879359
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0492'
       ttOrdem.it-codigo = '25-255-0492'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'DICLOFENACO DE SODIO 100 MG, CAIXA COM 10 COMPRIMIDOS'
       ttOrdem.narrativa-ordem = 'DICLOFENACO DE SODIO 100 MG, CAIXA COM 10 COMPRIMIDOS'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879359
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 2
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 10
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 20
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879360
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0489'
       ttOrdem.it-codigo = '25-255-0489'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO ANTITERMICO E ANTIPIRETICO, DIPIRONA SODICA 500MG FORNECIDO EM CAIXAS COM 20'
                              + 'COMPRIMIDOS, REFERENCIA: NOVALGINA'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO ANTITERMICO E ANTIPIRETICO, DIPIRONA SODICA 500MG FORNECIDO EM CAIXAS COM 20'
                               + 'COMPRIMIDOS, REFERENCIA: NOVALGINA'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879360
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 9
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 5
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 45
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 879361
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0477'
       ttOrdem.it-codigo = '25-255-0477'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO TYLEX 30MG, ANTIINFLAMATORIO, FORNECIDO EM EMBALAGENS DE 12 COMPRIMIDOS.'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO TYLEX 30MG, ANTIINFLAMATORIO, FORNECIDO EM EMBALAGENS DE 12 COMPRIMIDOS.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 879361
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 64.87
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 64.87
       ttParcela.dt-entrega = 2/20/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880167
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-1129'
       ttOrdem.it-codigo = '25-255-1129'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO CELESTRAT 2 + 0,25 MG, ANTIALERGICO.'
                              + 'FORNECIDO EM CAIXA COM 15 COMPRIMIDOS.'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO CELESTRAT 2 + 0,25 MG, ANTIALERGICO.'
                               + 'FORNECIDO EM CAIXA COM 15 COMPRIMIDOS.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880167
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 15
       ttParcela.unid-medida = 'CO '
       ttParcela.pre-uni = 14.53
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 217.95
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880168
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-1130'
       ttOrdem.it-codigo = '25-255-1130'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO CLOMIPRAMIDA 10MG, ANTIDEPRESSIVO.'
                              + 'FORNECIDO EM CAIXAS COM 20 COMPRIMIDOS'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO CLOMIPRAMIDA 10MG, ANTIDEPRESSIVO.'
                               + 'FORNECIDO EM CAIXAS COM 20 COMPRIMIDOS'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880168
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 60
       ttParcela.unid-medida = 'CO '
       ttParcela.pre-uni = .647
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 38.82
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880169
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0942'
       ttOrdem.it-codigo = '25-255-0942'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO RISPERIDAN 1MG, ANTIDEPRESSIVO.'
                              + 'FORNECIDO EM CAIXAS COM 30 COMPRIMIDOS'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO RISPERIDAN 1MG, ANTIDEPRESSIVO.'
                               + 'FORNECIDO EM CAIXAS COM 30 COMPRIMIDOS'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880169
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 2
       ttParcela.unid-medida = 'CX'
       ttParcela.pre-uni = 41.17
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 82.34
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880171
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0040'
       ttOrdem.it-codigo = '25-255-0040'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO, PRINCIPIO ATIVO DIPIRONA SODICA 250MG E BROMETO DE N-BUTILESCOPALAMINA 10MG,'
                              + 'REFERENCIA: BUSCOPAN COMPOSTO COMPRIMIDO. OBS. FORNECIDO EM CAIXAS COM 20 UNIDADES.'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO, PRINCIPIO ATIVO DIPIRONA SODICA 250MG E BROMETO DE N-BUTILESCOPALAMINA 10MG,'
                               + 'REFERENCIA: BUSCOPAN COMPOSTO COMPRIMIDO. OBS. FORNECIDO EM CAIXAS COM 20 UNIDADES.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880171
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 5
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 14
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 70
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880172
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0040'
       ttOrdem.it-codigo = '25-255-0040'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO, PRINCIPIO ATIVO DIPIRONA SODICA 250MG E BROMETO DE N-BUTILESCOPALAMINA 10MG,'
                              + 'REFERENCIA: BUSCOPAN COMPOSTO COMPRIMIDO. OBS. FORNECIDO EM CAIXAS COM 20 UNIDADES.'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO, PRINCIPIO ATIVO DIPIRONA SODICA 250MG E BROMETO DE N-BUTILESCOPALAMINA 10MG,'
                               + 'REFERENCIA: BUSCOPAN COMPOSTO COMPRIMIDO. OBS. FORNECIDO EM CAIXAS COM 20 UNIDADES.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880172
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 2
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 14.98
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 29.96
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880173
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0040'
       ttOrdem.it-codigo = '25-255-0040'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO, PRINCIPIO ATIVO DIPIRONA SODICA 250MG E BROMETO DE N-BUTILESCOPALAMINA 10MG,'
                              + 'REFERENCIA: BUSCOPAN COMPOSTO COMPRIMIDO. OBS. FORNECIDO EM CAIXAS COM 20 UNIDADES.'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO, PRINCIPIO ATIVO DIPIRONA SODICA 250MG E BROMETO DE N-BUTILESCOPALAMINA 10MG,'
                               + 'REFERENCIA: BUSCOPAN COMPOSTO COMPRIMIDO. OBS. FORNECIDO EM CAIXAS COM 20 UNIDADES.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880173
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 2
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 14.9
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 29.8
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880174
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0020'
       ttOrdem.it-codigo = '25-255-0020'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO ANTI ENJOO A BASE DE POLIDRATO DE METROCLOPRAMIDA ANIDRO.10 MG'
                              + 'CX: 20 COMP REFERENCIA; PLASIL'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO ANTI ENJOO A BASE DE POLIDRATO DE METROCLOPRAMIDA ANIDRO.10 MG'
                               + 'CX: 20 COMP REFERENCIA; PLASIL'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880174
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 3
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 9.89
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 29.67
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880175
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0020'
       ttOrdem.it-codigo = '25-255-0020'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO ANTI ENJOO A BASE DE POLIDRATO DE METROCLOPRAMIDA ANIDRO.10 MG'
                              + 'CX: 20 COMP REFERENCIA; PLASIL'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO ANTI ENJOO A BASE DE POLIDRATO DE METROCLOPRAMIDA ANIDRO.10 MG'
                               + 'CX: 20 COMP REFERENCIA; PLASIL'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880175
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 2
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 12.74
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 25.48
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880176
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0489'
       ttOrdem.it-codigo = '25-255-0489'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO ANTITERMICO E ANTIPIRETICO, DIPIRONA SODICA 500MG FORNECIDO EM CAIXAS COM 20'
                              + 'COMPRIMIDOS, REFERENCIA: NOVALGINA'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO ANTITERMICO E ANTIPIRETICO, DIPIRONA SODICA 500MG FORNECIDO EM CAIXAS COM 20'
                               + 'COMPRIMIDOS, REFERENCIA: NOVALGINA'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880176
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 240
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = .5
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 120
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880177
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0541'
       ttOrdem.it-codigo = '25-255-0541'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO ANTI-INFLAMATORIO OMEPRAZOL 20MG FRASCO COM 14 UNIDADES .'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO ANTI-INFLAMATORIO OMEPRAZOL 20MG FRASCO COM 14 UNIDADES .'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880177
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 84
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 11.99
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 1007.16
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880178
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0400'
       ttOrdem.it-codigo = '25-255-0400'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'MEDICAMENTO PARACETAMOL 750MG - DOR, FEBRE, SINTOMAS DE DENGUE COMPOSIÇÃO: CADA COMPRIMIDO CONTÉM:'
       ttOrdem.narrativa-ordem = 'MEDICAMENTO PARACETAMOL 750MG - DOR, FEBRE, SINTOMAS DE DENGUE COMPOSIÇÃO: CADA COMPRIMIDO CONTÉM:'
                               + 'PARACETAMOL 750MG, EXCIPIENTES: ÁCIDO ESTEÁRICO, AMIDO PRÉ-GELATINIZADO, HIPROMELOSE, MACROGOL  E'
                               + 'POVIDONA., REFERÊNCIA: TYLENOL CAIXA COM 20 COMPRIMIDOS REVESTIDOS.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880178
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 50
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = .5
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 25
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880179
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0035'
       ttOrdem.it-codigo = '25-255-0035'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'COLIRIO DE ACAO ANTIBIOTICA, PRINCPIO ATIVO:  FOSFATO DE SODIO, DEXAMETAZONA E SULFATO DE NEOMICINA'
                              + '1,0MG/ML E 3,5MG/ML,FORNECIDO EM EMBALAGENS COM 5ML CADA. REFERENCIA: DECADRON'
       ttOrdem.narrativa-ordem = 'COLIRIO DE ACAO ANTIBIOTICA, PRINCPIO ATIVO:  FOSFATO DE SODIO, DEXAMETAZONA E SULFATO DE NEOMICINA'
                               + '1,0MG/ML E 3,5MG/ML,FORNECIDO EM EMBALAGENS COM 5ML CADA. REFERENCIA: DECADRON'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880179
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'FR '
       ttParcela.pre-uni = 12.77
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 12.77
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880180
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-258-0050'
       ttOrdem.it-codigo = '25-258-0050'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'ALGODAO HIDROFILO. OBS. FORNECIDO EM PACOTES DE 500 GR.'
       ttOrdem.narrativa-ordem = 'ALGODAO HIDROFILO. OBS. FORNECIDO EM PACOTES DE 500 GR.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880180
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'PT '
       ttParcela.pre-uni = 6.81
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 6.81
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880181
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-258-0050'
       ttOrdem.it-codigo = '25-258-0050'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'ALGODAO HIDROFILO. OBS. FORNECIDO EM PACOTES DE 500 GR.'
       ttOrdem.narrativa-ordem = 'ALGODAO HIDROFILO. OBS. FORNECIDO EM PACOTES DE 500 GR.'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880181
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 1
       ttParcela.unid-medida = 'PT '
       ttParcela.pre-uni = 6.81
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 6.81
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880182
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-258-0074'
       ttOrdem.it-codigo = '25-258-0074'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'GAZE HIDROFILA, DIMENSAO: 75 X 75 MM (FORNECIDA EM PACOTE CONTENDO 10 UNIDADES CADA).'
       ttOrdem.narrativa-ordem = 'GAZE HIDROFILA, DIMENSAO: 75 X 75 MM (FORNECIDA EM PACOTE CONTENDO 10 UNIDADES CADA).'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880182
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 60
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 1
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 60
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .

CREATE ttOrdem.
ASSIGN ttOrdem.nr-ordem-compra = 880183
       ttOrdem.destino = 'Consumo'
       ttOrdem.it-fornec = '25-255-0975'
       ttOrdem.it-codigo = '25-255-0975'
       ttOrdem.perc-ipi = 0
       ttOrdem.vl-ipi = 0
       ttOrdem.narrativa-item = 'ESPARADRAPO MICROPORE, LARGURA: 10 CM, COMPRIMENTO: 4,5 M.'
                              + 'REFERENCIA: 3M / CREMER'
       ttOrdem.narrativa-ordem = 'ESPARADRAPO MICROPORE, LARGURA: 10 CM, COMPRIMENTO: 4,5 M.'
                               + 'REFERENCIA: 3M / CREMER'
       .

CREATE ttParcela.
ASSIGN ttParcela.nr-ordem-compra = 880183
       ttParcela.nr-parcela = 1
       ttParcela.quantidade = 2
       ttParcela.unid-medida = 'UN '
       ttParcela.pre-uni = 9.33
       ttParcela.val-desconto = 0
       ttParcela.val-enc-fin = 0
       ttParcela.pre-total = 18.66
       ttParcela.dt-entrega = 2/26/2020
       ttParcela.ref-item = ''
       .
