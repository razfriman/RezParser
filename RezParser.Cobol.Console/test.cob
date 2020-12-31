000100 IDENTIFICATION DIVISION.                                         EXEC84.2
000200                                                                  EXEC84.2
000400 PROGRAM-ID.                                                      EXEC84.2
000500     EXEC85.                                                      EXEC84.2
000600 INSTALLATION.                                                    EXEC84.2
000700     "ON-SITE VALIDATION, NATIONAL INSTITUTE OF STD & TECH.     ".EXEC84.2
000800     "COBOL 85 VERSION 4.2, Apr  1993 SSVG                      ".EXEC84.2
000900 ENVIRONMENT DIVISION.                                            EXEC84.2
001000                                                                  EXEC84.2
001100****************************************************************  EXEC84.2
001200*                                                              *  EXEC84.2
001300*    VALIDATION FOR:-                                          *  EXEC84.2
001400*                                                              *  EXEC84.2
001500*    "ON-SITE VALIDATION, NATIONAL INSTITUTE OF STD & TECH.     ".EXEC84.2
001600*                                                              *  EXEC84.2
001700*    "COBOL 85 VERSION 4.2, Apr  1993 SSVG                      ".EXEC84.2
001800*                                                              *  EXEC84.2
001900****************************************************************  EXEC84.2
002000 CONFIGURATION SECTION.                                           EXEC84.2
002100                                                                  EXEC84.2
002200 SPECIAL-NAMES.                                                   EXEC84.2
002300 INPUT-OUTPUT SECTION.                                            EXEC84.2
002400 FILE-CONTROL.                                                    EXEC84.2
002500     SELECT  OPTIONAL POPULATION-FILE                             EXEC84.2
002600     ASSIGN TO                                                    EXEC84.2
002700     XXXXX001.                                                    EXEC84.2
002800     SELECT  SOURCE-COBOL-PROGRAMS                                EXEC84.2
002900     ASSIGN TO                                                    EXEC84.2
003000     XXXXX002                                                     EXEC84.2
003100     ORGANIZATION SEQUENTIAL.                                     EXEC84.2
003200     SELECT  UPDATED-POPULATION-FILE                              EXEC84.2
003300     ASSIGN TO                                                    EXEC84.2
003400     XXXXX003.                                                    EXEC84.2
003500     SELECT  PRINT-FILE                                           EXEC84.2
003600     ASSIGN TO                                                    EXEC84.2
003700     XXXXX055.                                                    EXEC84.2
003800     SELECT  CONTROL-CARD-FILE                                    EXEC84.2
003900     ASSIGN TO                                                    EXEC84.2
004000     XXXXX058.                                                    EXEC84.2
004100 DATA DIVISION.                                                   EXEC84.2
004200 FILE SECTION.                                                    EXEC84.2
004300 FD  POPULATION-FILE.                                             EXEC84.2
004400*    RECORD CONTAINS 2400 CHARACTERS.                             EXEC84.2
004500 01  SOURCE-IN-2400.                                              EXEC84.2
004600     02 SOURCE-IN                    PIC X(80).                   EXEC84.2
004700*                                              OCCURS 30.         EXEC84.2
004800 FD  CONTROL-CARD-FILE.                                           EXEC84.2
004900 01  CONTROL-RECORD                  PIC X(80).                   EXEC84.2
005000 FD  PRINT-FILE.                                                  EXEC84.2
005100 01  PRINT-REC.                                                   EXEC84.2
005200   05        FILLER                  PIC X.                       EXEC84.2
005300   05        PRINT-DATA              PIC X(131).                  EXEC84.2
005400 FD  SOURCE-COBOL-PROGRAMS                                        EXEC84.2
005500     BLOCK CONTAINS 1 RECORDS.                                    EXEC84.2
005600 01  CT-OUT.                                                      EXEC84.2
005700     02 FILLER PIC X(72).                                         EXEC84.2
005800     02 FILLER PIC X(8).                                          EXEC84.2
005900 FD  UPDATED-POPULATION-FILE                                      EXEC84.2
006000     RECORD CONTAINS 2400 CHARACTERS.                             EXEC84.2
006100 01  UPDATED-SOURCE-OUT-2400.                                     EXEC84.2
006200     02 UD-SOURCE-OUT                PIC X(80)  OCCURS 30.        EXEC84.2
006300                                                                  EXEC84.2
006400 WORKING-STORAGE SECTION.                                         EXEC84.2
006500                                                                  EXEC84.2
006600 01  FILLER                          PIC X(40)  VALUE             EXEC84.2
006700            "NEWEXEC WORKING-STORAGE STARTS HERE ==->".           EXEC84.2
006800 01  BLOCK-TYPE                      PIC X(5).                    EXEC84.2
006900 01  SUB1                            PIC S9(3)  COMP.             EXEC84.2
007000 01  SUB2                            PIC S9(3)  COMP.             EXEC84.2
007100 01  SUB3                            PIC S9(3)  COMP.             EXEC84.2
007200 01  SUB4                            PIC S9(3)  COMP.             EXEC84.2
007300 01  SUB5                            PIC S9(3)  COMP.             EXEC84.2
007400 01  SUB6                            PIC S9(3)  COMP.             EXEC84.2
007500 01  SUB7                            PIC S9(3)  COMP.             EXEC84.2
007600 01  WA-ERR-IND                      PIC 9 VALUE ZEROES.          EXEC84.2
007700 01  WA-FIRST-IND                    PIC 9 VALUE ZEROES.          EXEC84.2
007800 01  WA-ZCARD-TABLE.                                              EXEC84.2
007900   05        WA-ZCARD                OCCURS 10                    EXEC84.2
008000                                     PIC X(60).                   EXEC84.2
008100 01  WA-TOP-OF-PAGE-LINE.                                         EXEC84.2
008200   05        FILLER                  PIC X(4)   VALUE SPACES.     EXEC84.2
008300   05        WA-VERSION.                                          EXEC84.2
008400     07      WA-VERSION-TEXT         PIC X(22)  VALUE             EXEC84.2
008500            "CCVS85 VERSION NUMBER ".                             EXEC84.2
008600     07      WA-VERSION-NUM          PIC X(3) VALUE SPACES.       EXEC84.2
008700   05        WA-RELEASE.                                          EXEC84.2
008800     07      WA-RELEASE-TEXT         PIC X(14)  VALUE             EXEC84.2
008900            ", RELEASED ON ".                                     EXEC84.2
009000     07      WA-VERSION-DATE         PIC X(11) VALUE SPACES.      EXEC84.2
009100   05        FILLER                  PIC X(4)   VALUE SPACES.     EXEC84.2
009200   05        WA-COMPANY-AND-COMPILER PIC X(30) VALUE SPACES.      EXEC84.2
009300   05        FILLER                  PIC X(5)   VALUE SPACES.     EXEC84.2
009400   05        WA-DATE                 PIC XXBXXBXX.                EXEC84.2
009500   05        FILLER                  PIC X(4)   VALUE SPACES.     EXEC84.2
009600   05        FILLER                  PIC X(5)   VALUE "PAGE ".    EXEC84.2
009700   05        WA-PAGE-CT              PIC Z(5)9.                   EXEC84.2
009800                                                                  EXEC84.2
009900 01  WA-ACCT-LINE-1.                                              EXEC84.2
010000   05        FILLER                  PIC X(19)  VALUE             EXEC84.2
010100            " ** END OF PROGRAM ".                                EXEC84.2
010200   05        WA-CURRENT-PROG         PIC X(6).                    EXEC84.2
010300   05        FILLER                  PIC X(32)  VALUE             EXEC84.2
010400            " FOUND,  COBOL LINES PROCESSED: ".                   EXEC84.2
010500   05        WA-LINES-COBOL          PIC Z(5)9.                   EXEC84.2
010600 01  WA-ACCT-LINE-2.                                              EXEC84.2
010700   05        FILLER                  PIC X(19)  VALUE             EXEC84.2
010800            " ** LINES INSERTED ".                                EXEC84.2
010900   05        WA-LINES-INSERTED       PIC Z(5)9.                   EXEC84.2
011000   05        FILLER                  PIC X(19)  VALUE             EXEC84.2
011100            " ** LINES REPLACED ".                                EXEC84.2
011200   05        WA-LINES-REPLACED       PIC Z(5)9.                   EXEC84.2
011300   05        FILLER                  PIC X(19)  VALUE             EXEC84.2
011400            " ** LINES DELETED  ".                                EXEC84.2
011500   05        WA-LINES-DELETED        PIC Z(5)9.                   EXEC84.2
011600 01  WA-ACCT-LINE-3.                                              EXEC84.2
011700   05        FILLER                  PIC X(18)  VALUE             EXEC84.2
011800            " ** OPTIONAL CODE ".                                 EXEC84.2
011900   05        WA-OPTIONAL-CODE        PIC X(8).                    EXEC84.2
012000   05        WA-CODE-REMOVED         PIC Z(5)9.                   EXEC84.2
012100   05        WA-CODE-KILLED          PIC X(21)  VALUE             EXEC84.2
012200            " ** COMMENTS DELETED ".                              EXEC84.2
012300   05        WA-COMMENTS-DEL         PIC Z(5)9.                   EXEC84.2
012400 01  WA-FINAL-LINE-1.                                             EXEC84.2
012500   05        FILLER                  PIC X(34)  VALUE             EXEC84.2
012600            " ** END OF POPULATION FILE REACHED".                 EXEC84.2
012700   05        FILLER                  PIC X(27)  VALUE             EXEC84.2
012800            " NUMBER OF PROGRAMS FOUND: ".                        EXEC84.2
012900   05        WA-PROGS-FOUND          PIC Z(5)9.                   EXEC84.2
013000 01  WA-FINAL-LINE-2.                                             EXEC84.2
013100   05        FILLER                  PIC X(47)  VALUE             EXEC84.2
013200            " ** NUMBER OF PROGRAMS WRITTEN TO SOURCE FILE: ".    EXEC84.2
013300   05        WA-SOURCE-PROGS         PIC Z(5)9.                   EXEC84.2
013400 01  WA-FINAL-LINE-3.                                             EXEC84.2
013500   05        FILLER                  PIC X(48)  VALUE             EXEC84.2
013600            " ** NUMBER OF PROGRAMS WRITTEN TO NEW POPULATION".   EXEC84.2
013700   05        FILLER                  PIC X(7)   VALUE " FILE: ".  EXEC84.2
013800   05        WA-NEWPOP-PROGS         PIC Z(5)9.                   EXEC84.2
013900 01  WB-CONTROL-DATA.                                             EXEC84.2
014000   05        WB-FILL                 PIC X(80).                   EXEC84.2
014100   05        FILLER                  REDEFINES  WB-FILL.          EXEC84.2
014200     10      WB-3                    PIC X(3).                    EXEC84.2
014300     10      FILLER                  PIC X(77).                   EXEC84.2
014400   05        FILLER                  REDEFINES  WB-FILL.          EXEC84.2
014500     10      WB-4                    PIC X(4).                    EXEC84.2
014600     10      WB-NN                   PIC 99.                      EXEC84.2
014700     10      FILLER                  PIC X.                       EXEC84.2
014800     10      WB-X                    PIC X.                       EXEC84.2
014900     10      FILLER                  PIC X(72).                   EXEC84.2
015000   05        FILLER                  REDEFINES  WB-FILL.          EXEC84.2
015100     10      WB-6                    PIC X(6).                    EXEC84.2
015200     10      FILLER                  PIC X(74).                   EXEC84.2
015300   05        FILLER                  REDEFINES  WB-FILL.          EXEC84.2
015400     10      WB-7                    PIC X(7).                    EXEC84.2
015500     10      FILLER                  PIC X(73).                   EXEC84.2
015600   05        FILLER                  REDEFINES  WB-FILL.          EXEC84.2
015700     10      WB-8                    PIC X(8).                    EXEC84.2
015800     10      FILLER                  PIC X(72).                   EXEC84.2
015900   05        FILLER                  REDEFINES  WB-FILL.          EXEC84.2
016000     10      WB-9                    PIC X(9).                    EXEC84.2
016100     10      FILLER                  PIC X(71).                   EXEC84.2
016200   05        FILLER                  REDEFINES  WB-FILL.          EXEC84.2
016300     10      WB-10                   PIC X(10).                   EXEC84.2
016400     10      FILLER                  PIC X(70).                   EXEC84.2
016500   05        FILLER                  REDEFINES  WB-FILL.          EXEC84.2
016600     10      WB-11                   PIC X(11).                   EXEC84.2
016700     10      FILLER                  PIC X(69).                   EXEC84.2
016800   05        FILLER                  REDEFINES  WB-FILL.          EXEC84.2
016900     10      WB-12                   PIC X(12).                   EXEC84.2
017000     10      FILLER                  PIC X.                       EXEC84.2
017100     10      WB-PROG                 PIC X(5).                    EXEC84.2
017200     10      FILLER                  PIC X(62).                   EXEC84.2
017300   05        FILLER                  REDEFINES  WB-FILL.          EXEC84.2
017400     10      WB-13                   PIC X(13).                   EXEC84.2
017500     10      FILLER                  PIC X(67).                   EXEC84.2
017600   05        FILLER                  REDEFINES  WB-FILL.          EXEC84.2
017700     10      WB-14                   PIC X(14).                   EXEC84.2
017800     10      FILLER                  PIC X.                       EXEC84.2
017900     10      WB-MODULE               PIC XX.                      EXEC84.2
018000     10      FILLER                  PIC X.                       EXEC84.2
018100     10      WB-LEVEL                PIC X.                       EXEC84.2
018200     10      FILLER                  PIC X(61).                   EXEC84.2
018300   05        FILLER                  REDEFINES  WB-FILL.          EXEC84.2
018400     10      WB-15                   PIC X(15).                   EXEC84.2
018500     10      FILLER                  PIC X(65).                   EXEC84.2
018600   05        FILLER                  REDEFINES  WB-FILL.          EXEC84.2
018700     10      WB-16                   PIC X(16).                   EXEC84.2
018800     10      FILLER                  PIC X(64).                   EXEC84.2
018900   05        WB-X-CARD               REDEFINES  WB-FILL.          EXEC84.2
019000     10      WB-X-HYPHEN             PIC XX.                      EXEC84.2
019100     10      WB-X-CARD-NUM           PIC 9(3).                    EXEC84.2
019200     10      WB-PROG-POS.                                         EXEC84.2
019300       15    WB-PROG-POS-NUM         PIC 99.                      EXEC84.2
019400     10      FILLER                  PIC X.                       EXEC84.2
019500     10      WB-SUBS-TEXT            PIC X(60).                   EXEC84.2
019600     10      FILLER                  PIC X(12).                   EXEC84.2
019700   05        WB-START-CARD           REDEFINES  WB-FILL.          EXEC84.2
019800     10      WB-STAR-START           PIC X(6).                    EXEC84.2
019900     10      FILLER                  PIC X.                       EXEC84.2
020000     10      WB-UPDATE-PROG          PIC X(6).                    EXEC84.2
020100     10      FILLER                  PIC X.                       EXEC84.2
020200     10      WB-RENUMBER             PIC X.                       EXEC84.2
020300     10      FILLER                  PIC X(65).                   EXEC84.2
020400   05        WB-LINE-UPDATE          REDEFINES  WB-FILL.          EXEC84.2
020500     10      WB-SEQ-1                PIC X(6).                    EXEC84.2
020600     10      WB-COBOL-LINE           PIC X(74).                   EXEC84.2
020700     10      FILLER                  REDEFINES  WB-COBOL-LINE.    EXEC84.2
020800       15    WB-COL-7                PIC X.                       EXEC84.2
020900       15    FILLER                  PIC X(73).                   EXEC84.2
021000     10      FILLER                  REDEFINES  WB-COBOL-LINE.    EXEC84.2
021100       15    WB-CHAR                 PIC X.                       EXEC84.2
021200       15    WB-SEQ-2                PIC X(6).                    EXEC84.2
021300/                                                                 EXEC84.2
021400 01  WC-CURRENT-POP-RECORD.                                       EXEC84.2
021500   05        WC-1.                                                EXEC84.2
021600     10      WC-END-OF-POPFILE       PIC X(16).                   EXEC84.2
021700     10      FILLER                  PIC X(64).                   EXEC84.2
021800   05        WC-HEADER               REDEFINES WC-1.              EXEC84.2
021900     10      WC-STAR-HEADER          PIC X(7).                    EXEC84.2
022000     10      FILLER                  PIC X.                       EXEC84.2
022100     10      WC-COBOL                PIC X(5).                    EXEC84.2
022200     10      FILLER                  PIC X.                       EXEC84.2
022300     10      WC-PROG-ID.                                          EXEC84.2
022400      12     WC-PROG-ID-1-5.                                      EXEC84.2
022500       15    WC-PROG-ID-1-4.                                      EXEC84.2
022600        18   WC-MODULE               PIC XX.                      EXEC84.2
022700        18   WC-LEVEL                PIC X.                       EXEC84.2
022800        18   FILLER                  PIC X.                       EXEC84.2
022900       15    FILLER                  PIC X.                       EXEC84.2
023000      12     WC-PROG-ID-6            PIC X.                       EXEC84.2
023100     10      FILLER                  PIC X.                       EXEC84.2
023200     10      WC-SUBPRG               PIC X(6).                    EXEC84.2
023300     10      FILLER                  PIC X.                       EXEC84.2
023400     10      WC-PROG2ID.                                          EXEC84.2
023500      12     WC-PROG2ID-1-5          PIC X(5).                    EXEC84.2
023600      12     FILLER                  PIC X.                       EXEC84.2
023700     10      FILLER                  PIC X(46).                   EXEC84.2
023800   05        FILLER                  REDEFINES WC-1.              EXEC84.2
023900     10      WC-1-72.                                             EXEC84.2
024000       15    WC-6.                                                EXEC84.2
024100         20  WC-STAR                 PIC X.                       EXEC84.2
024200         20  FILLER                  PIC X(5).                    EXEC84.2
024300       15    FILLER                  REDEFINES  WC-6.             EXEC84.2
024400         20  WC-1-5                  PIC X(5).                    EXEC84.2
024500         20  FILLER                  PIC X.                       EXEC84.2
024600       15    WC-COL-7                PIC X.                       EXEC84.2
024700       15    WC-COL-8                PIC X.                       EXEC84.2
024800       15    FILLER                  PIC X(3).                    EXEC84.2
024900       15    WC-SUB-DATA.                                         EXEC84.2
025000         20  WC-12-15                PIC X(4).                    EXEC84.2
025100         20  FILLER                  PIC X.                       EXEC84.2
025200         20  WC-17-19                PIC 9(3).                    EXEC84.2
025300         20  WC-20                   PIC X.                       EXEC84.2
025400         20  FILLER                  PIC X(52).                   EXEC84.2
025500     10      WC-73-80                PIC X(8).                    EXEC84.2
025600                                                                  EXEC84.2
025700 01  WD-SOURCE-REC.                                               EXEC84.2
025800   05        WD-1.                                                EXEC84.2
025900     10      FILLER                  PIC X(6).                    EXEC84.2
026000     10      WD-HEADER               PIC X(74).                   EXEC84.2
026100                                                                  EXEC84.2
026200 01  WE-PRINT-DATA.                                               EXEC84.2
026300   05        WE-COBOL-LINE           PIC X(80).                   EXEC84.2
026400   05        FILLER                  PIC X      VALUE SPACE.      EXEC84.2
026500   05        WE-X-CARD               PIC X(9).                    EXEC84.2
026600   05        FILLER                  PIC XX     VALUE SPACES.     EXEC84.2
026700   05        WE-CHANGE-TYPE          PIC X(12).                   EXEC84.2
026800                                                                  EXEC84.2
026900 01  WF-PROGRAM-SELECTED-TABLE.                                   EXEC84.2
027000   05        WF-PROGRAM-SELECTED     PIC X(5)   OCCURS 50.        EXEC84.2
027100                                                                  EXEC84.2
027200 01  WG-MODULE-SELECTED-TABLE.                                    EXEC84.2
027300   05        FILLER                             OCCURS 10.        EXEC84.2
027400     10      WG-MODULE-SELECTED      PIC XX.                      EXEC84.2
027500     10      WG-MODULE-LEVEL         PIC X.                       EXEC84.2
027600                                                                  EXEC84.2
027700 01  WV-PRINT-MISCELLANEOUS.                                      EXEC84.2
027800   05        WV-OPTION-HEADING       PIC X(25)  VALUE             EXEC84.2
027900            " OPTION SWITCH SETTINGS -".                          EXEC84.2
028000   05        WV-OPT-1                PIC X(40)  VALUE             EXEC84.2
028100         " 0                 1                   2".              EXEC84.2
028200   05        WV-OPT-2                PIC X(52)  VALUE             EXEC84.2
028300         " 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6".  EXEC84.2
028400   05        WV-OPT-SWITCHES.                                     EXEC84.2
028500     10      FILLER                  PIC X      VALUE SPACE.      EXEC84.2
028600     10      FILLER                  OCCURS 26.                   EXEC84.2
028700       15    WV-OPT                  PIC X.                       EXEC84.2
028800       15    FILLER                  PIC X.                       EXEC84.2
028900 01  WX-X-CARD-TABLE.                                             EXEC84.2
029000   05        WX-X-CARD               OCCURS 200.                  EXEC84.2
029100     10      WX-X-CHAR               PIC X                        EXEC84.2
029200                                     OCCURS 60.                   EXEC84.2
029300 01  WX-PROG-POS-TABLE.                                           EXEC84.2
029400   05        WX-PROG-POS             OCCURS 200                   EXEC84.2
029500                                     PIC 99.                      EXEC84.2
029600 01  WY-SWITCHES.                                                 EXEC84.2
029700   05        WY-OPTION-SWITCHES.                                  EXEC84.2
029800     10      WY-OPT-SW-1             PIC X.                       EXEC84.2
029900     10      WY-OPT-SW-2             PIC X.                       EXEC84.2
030000     10      WY-OPT-SW-3             PIC X.                       EXEC84.2
030100     10      WY-OPT-SW-4             PIC X.                       EXEC84.2
030200     10      WY-OPT-SW-5             PIC X.                       EXEC84.2
030300     10      WY-OPT-SW-6             PIC X.                       EXEC84.2
030400     10      WY-OPT-SW-7             PIC X.                       EXEC84.2
030500     10      WY-OPT-SW-8             PIC X.                       EXEC84.2
030600     10      WY-OPT-SW-9             PIC X.                       EXEC84.2
030700     10      WY-OPT-SW-10            PIC X.                       EXEC84.2
030800     10      WY-OPT-SW-11            PIC X.                       EXEC84.2
030900     10      WY-OPT-SW-12            PIC X.                       EXEC84.2
031000     10      WY-OPT-SW-13            PIC X.                       EXEC84.2
031100     10      WY-OPT-SW-14            PIC X.                       EXEC84.2
031200     10      WY-OPT-SW-15            PIC X.                       EXEC84.2
031300     10      WY-OPT-SW-16            PIC X.                       EXEC84.2
031400     10      WY-OPT-SW-17            PIC X.                       EXEC84.2
031500     10      WY-OPT-SW-18            PIC X.                       EXEC84.2
031600     10      WY-OPT-SW-19            PIC X.                       EXEC84.2
031700     10      WY-OPT-SW-20            PIC X.                       EXEC84.2
031800     10      WY-OPT-SW-21            PIC X.                       EXEC84.2
031900     10      WY-OPT-SW-22            PIC X.                       EXEC84.2
032000     10      WY-OPT-SW-23            PIC X.                       EXEC84.2
032100     10      WY-OPT-SW-24            PIC X.                       EXEC84.2
032200     10      WY-OPT-SW-25            PIC X.                       EXEC84.2
032300     10      WY-OPT-SW-26            PIC X.                       EXEC84.2
032400   05        FILLER                  REDEFINES WY-OPTION-SWITCHES.EXEC84.2
032500     10      WY-OPT-SW               PIC X                        EXEC84.2
032600                                     OCCURS 26.                   EXEC84.2
032700   05        WY-PRINT-SWITCHES.                                   EXEC84.2
032800     10      WY-EXTRACT-ALL          PIC X.                       EXEC84.2
032900     10      WY-EXTRACT-AUTO         PIC X.                       EXEC84.2
033000     10      WY-EXTRACT-MAN          PIC X.                       EXEC84.2
033100     10      WY-KILL-DELETIONS       PIC X.                       EXEC84.2
033200     10      WY-LIST-NO-UPDATES      PIC X.                       EXEC84.2
033300     10      WY-LIST-X-CARDS         PIC X.                       EXEC84.2
033400     10      WY-LIST-PROGRAMS        PIC X.                       EXEC84.2
033500     10      WY-LIST-COMPACT         PIC X.                       EXEC84.2
033600     10      WY-NO-DATA              PIC X.                       EXEC84.2
033700     10      WY-NO-LIBRARY           PIC X.                       EXEC84.2
033800     10      WY-NO-SOURCE            PIC X.                       EXEC84.2
033900     10      WY-REMOVE-COMMENTS      PIC X.                       EXEC84.2
034000     10      WY-NEW-POP              PIC X.                       EXEC84.2
034100     10      WY-SELECT-PROG          PIC X.                       EXEC84.2
034200     10      WY-SELECT-MODULE        PIC X.                       EXEC84.2
034300     10      WY-SELECT-LEVEL         PIC X.                       EXEC84.2
034400                                                                  EXEC84.2
034500 01  WZ-MISCELLANEOUS.                                            EXEC84.2
034600   05        WZ-PROGRAM-SELECTED     PIC X.                       EXEC84.2
034700   05        WZ-END-OF-POPFILE       PIC X.                       EXEC84.2
034800   05        WZ-FULL-STOP            PIC X.                       EXEC84.2
034900   05        WZ-DONT-READ-POPFILE    PIC X.                       EXEC84.2
035000   05        WZ-UPDATE-THIS-PROG     PIC X.                       EXEC84.2
035100   05        WZ-REPLACE-FLAG         PIC X.                       EXEC84.2
035200   05        WZ-LINE-UPDATE          PIC X.                       EXEC84.2
035300   05        WZ-RESEQUENCE-THIS      PIC X.                       EXEC84.2
035400   05        WZ-RESEQUENCE-NEXT      PIC X.                       EXEC84.2
035500   05        WZ-END-OF-UPDATES       PIC X.                       EXEC84.2
035600   05        WZ-OPTIONAL-SELECTED    PIC X.                       EXEC84.2
035700   05        WZ-DELETE-FLAG          PIC X.                       EXEC84.2
035800   05        WZ-NOT-THIS-COMMENT     PIC X.                       EXEC84.2
035900   05        WZ-CURRENT-HEADER       PIC X(5).                    EXEC84.2
036000   05        WZ-INVALID-DATA.                                     EXEC84.2
036100     10      FILLER                  PIC X(20).                   EXEC84.2
036200     10      WZ-ERROR-MESSAGE        PIC X(60).                   EXEC84.2
036300   05        WZ-CURRENT-UPD-PROG.                                 EXEC84.2
036400     10      WZ-UPD-PROG-CHAR        PIC X.                       EXEC84.2
036500     10      FILLER                  PIC X(5).                    EXEC84.2
036600   05        WZ-CURRENT-MAIN-PROG.                                EXEC84.2
036700     10      WZ-MAIN-PROG-CHAR       PIC X      OCCURS 6.         EXEC84.2
036800   05        WZ-PROG-BREAK.                                       EXEC84.2
036900     10      WZ-1CHAR                PIC X      OCCURS 6.         EXEC84.2
037000   05        WZ-CURRENT-POP-PROG.                                 EXEC84.2
037100     10      FILLER                  PIC X(5).                    EXEC84.2
037200     10      WZ-PROG-ID-6            PIC X.                       EXEC84.2
037300   05        WZ-MAIN-PROG-FLAG       PIC X.                       EXEC84.2
037400   05        WZ-LINES-COBOL          PIC 9(6).                    EXEC84.2
037500   05        WZ-LINES-INSERTED       PIC 9(6).                    EXEC84.2
037600   05        WZ-LINES-REPLACED       PIC 9(6).                    EXEC84.2
037700   05        WZ-LINES-DELETED        PIC 9(6).                    EXEC84.2
037800   05        WZ-COMMENTS-DELETED     PIC 9(6).                    EXEC84.2
037900   05        WZ-CODE-REMOVED         PIC 9(6).                    EXEC84.2
038000   05        WZ-SOURCE-PROGS         PIC 9(6).                    EXEC84.2
038100   05        WZ-NEWPOP-PROGS         PIC 9(6).                    EXEC84.2
038200   05        WZ-PROGS-FOUND          PIC 9(6).                    EXEC84.2
038300   05        WZ-COMMENTS-DEL         PIC 9(6).                    EXEC84.2
038400   05        WZ-SEQ-NO               PIC 9(6).                    EXEC84.2
038500   05        WZ-SAVE-POP-RECORD.                                  EXEC84.2
038600     10      WZ-SAVE-SEQ             PIC X(6).                    EXEC84.2
038700     10      FILLER                  PIC X(5).                    EXEC84.2
038800     10      WZ-SAVE-12-20.                                       EXEC84.2
038900       15    WZ-SAVE-12-15           PIC X(4).                    EXEC84.2
039000       15    FILLER                  PIC X(5).                    EXEC84.2
039100     10      FILLER                  PIC X(60).                   EXEC84.2
039200   05        WZ-PAGE-CT              PIC 9(6).                    EXEC84.2
039300   05        WZ-LINE-CT              PIC 9(6).                    EXEC84.2
039400   05        WZ-MODULE               PIC XX.                      EXEC84.2
039500   05        WZ-LEVEL                PIC X.                       EXEC84.2
039600   05        WZ-PRINT-HOLD           PIC X(132).                  EXEC84.2
039700   05        WZ-X-CARD.                                           EXEC84.2
039800     10      WZ-X-CHAR               PIC X                        EXEC84.2
039900                                     OCCURS 60.                   EXEC84.2
040000   05        WZ-WITHIN-DELETE-SERIES-FLAG  PIC X.                 EXEC84.2
040100 01  WZ-VERSION-CARD.                                             EXEC84.2
040200     10  FILLER                      PIC X(55) VALUE              EXEC84.2
040300     "CCVS85  VERSION 4.2   01 OCT 1992 0032                 ".   EXEC84.2
040400 01  WZ-VERSION-CONTROL REDEFINES WZ-VERSION-CARD.                EXEC84.2
040500     10      FILLER                  PIC X(16).                   EXEC84.2
040600     10      WZ-VERSION-NUM          PIC X(3).                    EXEC84.2
040700     10      FILLER                  PIC X(3).                    EXEC84.2
040800     10      WZ-VERSION-DATE         PIC X(11).                   EXEC84.2
040900                                                                  EXEC84.2
041000/                                                                 EXEC84.2
041100 PROCEDURE DIVISION.                                              EXEC84.2
041200*==================                                               EXEC84.2
041300*                                                                 EXEC84.2
041400 A10-MAIN SECTION.                                                EXEC84.2
041500*================                                                 EXEC84.2
041600*                                                                 EXEC84.2
041700****************************************************************  EXEC84.2
041800*    THIS IS THE HIGHEST LEVEL CONTROL MODULE                  *  EXEC84.2
041900*                                                              *  EXEC84.2
042000****************************************************************  EXEC84.2
042100 A10-1-MAIN.                                                      EXEC84.2
042200     PERFORM B10-INITIALISE.                                      EXEC84.2
042300                                                                  EXEC84.2
042400     PERFORM C10-PROCESS-MONITOR.                                 EXEC84.2
042500                                                                  EXEC84.2
042600     PERFORM D10-MERGE-UPDATE-CARDS.                              EXEC84.2
042700                                                                  EXEC84.2
042800     PERFORM E10-TERMINATE.                                       EXEC84.2
042900                                                                  EXEC84.2
043000 A10-EXIT.                                                        EXEC84.2
043100     EXIT.                                                        EXEC84.2
043200                                                                  EXEC84.2
043300/                                                                 EXEC84.2
043400 B10-INITIALISE SECTION.                                          EXEC84.2
043500*======================                                           EXEC84.2
043600*                                                                 EXEC84.2
043700****************************************************************  EXEC84.2
043800* THIS SECTION INITIALIZES THE OPTION SWITCH AND X-CARD FIELDS *  EXEC84.2
043900* PRIOR TO READING IN CONTROL CARD FILE.                       *  EXEC84.2
044000*                                                              *  EXEC84.2
044100*                                                              *  EXEC84.2
044200*                                                              *  EXEC84.2
044300*                                                              *  EXEC84.2
044400****************************************************************  EXEC84.2
044500 B10-1-INIT-OPTION-SWITCHES.                                      EXEC84.2
044600     MOVE    SPACES  TO WZ-MISCELLANEOUS.                         EXEC84.2
044700     MOVE    SPACES  TO WF-PROGRAM-SELECTED-TABLE.                EXEC84.2
044800     MOVE    SPACES  TO WG-MODULE-SELECTED-TABLE.                 EXEC84.2
044900     MOVE    SPACES  TO WY-SWITCHES.                              EXEC84.2
045000     MOVE    "A"     TO WY-OPT-SW-1.                              EXEC84.2
045100     MOVE    "E"     TO WY-OPT-SW-2.                              EXEC84.2
045200     MOVE    "H"     TO WY-OPT-SW-3.                              EXEC84.2
045300     MOVE    "L"     TO WY-OPT-SW-4.                              EXEC84.2
045400     MOVE    "Y"     TO WY-OPT-SW-7.                              EXEC84.2
045500     MOVE    "T"     TO WY-OPT-SW-11.                             EXEC84.2
045600                                                                  EXEC84.2
045700 B10-2-INIT-X-CARDS.                                              EXEC84.2
045800     MOVE    ZERO TO SUB1.                                        EXEC84.2
045900     MOVE    ZERO TO SUB6.                                        EXEC84.2
046000     MOVE    ZERO TO SUB7.                                        EXEC84.2
046100     MOVE    1    TO SUB5.                                        EXEC84.2
046200     PERFORM B20-INIT-X-CARDS 200 TIMES.                          EXEC84.2
046300     MOVE   "    OMITTED" TO WX-X-CARD (84).                      EXEC84.2
046400     MOVE    ZERO TO WZ-LINES-COBOL.                              EXEC84.2
046500     MOVE    ZERO TO WZ-LINES-INSERTED.                           EXEC84.2
046600     MOVE    ZERO TO WZ-LINES-REPLACED.                           EXEC84.2
046700     MOVE    ZERO TO WZ-LINES-DELETED.                            EXEC84.2
046800     MOVE    ZERO TO WZ-COMMENTS-DELETED.                         EXEC84.2
046900     MOVE    ZERO TO WZ-CODE-REMOVED.                             EXEC84.2
047000     MOVE    ZERO TO WZ-SOURCE-PROGS.                             EXEC84.2
047100     MOVE    ZERO TO WZ-NEWPOP-PROGS.                             EXEC84.2
047200     MOVE    ZERO TO WZ-PROGS-FOUND.                              EXEC84.2
047300     MOVE    ZERO TO WZ-COMMENTS-DEL.                             EXEC84.2
047400     MOVE    ZERO TO WZ-SEQ-NO.                                   EXEC84.2
047500     MOVE    ZERO TO WZ-PAGE-CT.                                  EXEC84.2
047600     MOVE    ZERO TO WZ-LINE-CT.                                  EXEC84.2
047700     ACCEPT WA-DATE FROM DATE.                                    EXEC84.2
047800 B10-EXIT.                                                        EXEC84.2
047900     EXIT.                                                        EXEC84.2
048000                                                                  EXEC84.2
048100                                                                  EXEC84.2
048200                                                                  EXEC84.2
048300                                                                  EXEC84.2
048400 B20-INIT-X-CARDS SECTION.                                        EXEC84.2
048500*========================                                         EXEC84.2
048600 B20-1-INIT.                                                      EXEC84.2
048700     ADD     1 TO SUB1.                                           EXEC84.2
048800     MOVE   "**** X-CARD UNDEFINED ****" TO WX-X-CARD (SUB1).     EXEC84.2
048900     MOVE    ZERO TO WX-PROG-POS (SUB1).                          EXEC84.2
049000                                                                  EXEC84.2
049100 B20-EXIT.                                                        EXEC84.2
049200     EXIT.                                                        EXEC84.2
049300/                                                                 EXEC84.2
049400 C10-PROCESS-MONITOR SECTION.                                     EXEC84.2
049500*===========================                                      EXEC84.2
049600                                                                  EXEC84.2
049700****************************************************************  EXEC84.2
049800*    THIS SECTION PROCESSES THE RECORDS COMMENCING WITH "*"    *  EXEC84.2
049900*    AND "X-" (THE MONITOR PART OF THE INPUT FILE ) AND READS  *  EXEC84.2
050000*    THE FIRST "*START" UPDATE RECORD.                         *  EXEC84.2
050100*                                                              *  EXEC84.2
050200*    PERFORMED BY    A10-MAIN                                  *  EXEC84.2
050300*    PERFORMS        C20-PROCESS-STAR-CARDS                    *  EXEC84.2
050400*                    C30-CHECK-COMBINATIONS                    *  EXEC84.2
050500*                    C40-PROCESS-X-CARDS                       *  EXEC84.2
050600****************************************************************  EXEC84.2
050700 C10-1-OPEN-FILES.                                                EXEC84.2
050800     OPEN    OUTPUT  PRINT-FILE.                                  EXEC84.2
050900     MOVE    SPACES TO PRINT-REC.                                 EXEC84.2
051000     OPEN    INPUT   CONTROL-CARD-FILE.                           EXEC84.2
051100     READ    CONTROL-CARD-FILE INTO  WB-CONTROL-DATA              EXEC84.2
051200             AT END  MOVE "CONTROL-CARD-FILE IS EMPTY"            EXEC84.2
051300                  TO PRINT-DATA                                   EXEC84.2
051400             PERFORM  X20-PRINT-DETAIL                            EXEC84.2
051500             STOP RUN.                                            EXEC84.2
051600     PERFORM C20-PROCESS-STAR-CARDS                               EXEC84.2
051700             UNTIL   WB-X-HYPHEN = "X-".                          EXEC84.2
051800     PERFORM C30-CHECK-COMBINATIONS.                              EXEC84.2
051900     PERFORM C40-PROCESS-X-CARDS                                  EXEC84.2
052000             UNTIL   WB-12 = "*END-MONITOR".                      EXEC84.2
052100                                                                  EXEC84.2
052200     PERFORM C50-PRINT-OPTIONS.                                   EXEC84.2