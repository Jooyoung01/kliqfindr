C        READ(16,24546,END=55155) KNUMSIM,OMAXG,NUMGROU2,OKPGROUP,
C     C  KPGROU2,
C     C  ONUMTEAC,NUMPEOP2,OMAXCHOI,MAXCHOI2,OMAXFREQ,MAXFRE2,SSEED,
C     C USEMARG,OMAXPIW,MAXPIW,OMAXPIB,MAXPIB,REGSIM,BYDENSE,SIMRAND,
C     C OBASEP,BASEP2,ORANGEP,RANGEP2,COMPSIM,
C     C OMAXPWW,MAXPWW,OMAXPWB,MAXPWB,OBASEWP,BASEWP2,OWRANGEP,
C     C WRANGEP2,XOBASEP,XBASEP2,XORANGEP,XRANGEP2,
C     C OPREPWI,PREPWI2,OPREQWI,PREQWI2, 
C     C OPREPBT,PREPBT2,OPREQBT,PREQBT2,PKPG,QKPG,PSIZE,QSIZE

C     FILE CALLED KLIQFIND.F
      PROGRAM kliqmain
      INCLUDE 'PARAM.H'

C     (INFILE,,PRIORFIL)
       CHARACTER LABEL(MAXKLIQ)*9,TITLES(3)*20,APRINT(MAXGR)*200,
     C FANCY(20)*200,MATTYPE*1,TITFILE*16,LABFILE*16,
     C HITFILE*16,LISTFILE*16,PARTITLE(MAXGR)*200,PARFORM(MAXGR)*80,
     C LISTVAR(MAXGR)*100,TCHAR(MAXGR)*80,KMATTYPE*1,TESTCHAR*20,
     C ONECHAR*1,DISTFILE*12,LINKFILE*16,P2FILE*16,QQFILE*16
C       PARAMETER (PAR1=11)
C       PARAMETER (CPAR1=2**PAR1)
       CHARACTER*12 PLACEFILE
       REAL IMAXVAL,FITI(MAXKLIQ),ISTRESS(MAXKLIQ),ISTRESS2(MAXKLIQ),
     C MSTRESS3(MAXKLIQ),MSTRESS2(MAXKLIQ),
     C ISTRESS3(MAXKLIQ),OC1,OUTCOME(MAXKLIQ),OUTMUL(5,MAXKLIQ),
     C ODDSDB1,ODDSDB2,ODDSDA,
     C TNUM,TMAX,PL,XINDEPT

       DOUBLE PRECISION STRESSB,STRESS2B,STRESS3B 

       INTEGER CENTER,DANCHOR2,MOVE2,DANCHOR,ZSYMMAT,MAXINC,
     C BYINC,NUMDIM,RINCREM,MEASURE,EXTREME,STARTINC,HYPERG,
     C NORMAL,NORMALI,CENTERI,DANCHORI,DANCH2I,MOVE2I,ZSYMMATI,
     C STARTINI,BYINCI,MAXINCI,DONEONE,ONE,TWO,THINKING,DOMULT,
     C OTCOUNT(5,MAXKLIQ),OUTLOOP,BYLAMN,FOUNDPER,NOTFOUND,THIWT,
     C SIXTEEN, STATUS,SYMLNK,GROUP,ZG,LAST,HAVEAPR,WANTPOUT,
     C GRGR,ADDONI,ADDONO,ADDONIJ,ADDONJI,HAVEAPR2,XINLIST,
     C XR1,XR2,XR3,XR4,XR5,SECSOL



       REAL
     C OPREPWI,PREPWI2,OPREQWI,PREQWI2, 
     C OPREPBT,PREPBT2,OPREQBT,PREQBT2,
     C PREPWI,PREQWI,PREPBT,PREQBT,PPWIINC,PQWIINC,
     C PPBTINC,PQBTINC,BMISS,EMISS,RMISS,
     C XOBASEP,XOBASEP2,XORANGEP,XORANGEP2,
     C PKPG,QKPG,PSIZE,QSIZE


       REAL IGRATIO,DRADIUSG,DRADIUSI,KEXP,MINVALI,MINVALG,KEXPI,
     C PCTCENG1,PCTCENG2,PCTCENI1,PCTCENI2,
     C NOWMISS
C Following added by RTC
       INTEGER T,T1,T2,TNT,U,GR,A,ZG1,ZG2,PERS
  
       INTEGER NUMDYAD,PERSON1(MAXKLIQ),FLAGI1,MBI,NUMOBS,ONUMDYAD,
     C PERSON2(MAXKLIQ),SIZE,PERSON3(MAXKLIQ),STRUCTEQ,
     C ADDI,ADDJ,ADDK,BOTHP,SYMMAT,NLIST(MAXKLIQ),NUMNLIST,
     C USETRIAD,HAVEDEPT(MAXKLIQ),NUMHAVE,LB,LOOKT,OD,STARTTRY,PID,
     C DYDTRIAD,NEVAL,PO,PORD(MAXKLIQ),NPORD(MAXKLIQ),PORDG(MAXKLIQ),
     C MBJ,NUMRES,TRYDEPT(MAXKLIQ),J,UNO,DUE,RESULTM(MAXKLIQ,MAXKLIQ),
     C PERGROUP,KNEVAL,TRANSPOS,NEWGRPS,FLAGR,PMADE,TAGALONG,
     C INVERT,HOWWIDE,RECTMAT,QMAXG,QKPGROUP,QNUMTEAC,QMAXCHOI,
     C QMAXFREQ,QNHLIST,QHLIST(MAXKLIQ),QR,MUTDYAD,NONEG,MAXSEED,
     C HALFDYAD,DISSOLVE,PAIRUP(MAXKLIQ,2),PAIRS,PID2,REGSIM,BYDENSE,
     C O2MAXG,INPLACE,I,HAVEI,HAVEJ,SNONEG,SPCTILE,SNEARVAL,DI
C     C NRESULTM(MAXKLIQ,MAXKLIQ)

C     ,TRIDLIST(125000,3),DYDTRIAD
       REAL CLOSPAIR(MAXKLIQ),CLOSEGRP(MAXKLIQ),RMAXDEPT,HIWTEVAL,
     C IEXPECT(MAXKLIQ),ISTD(MAXKLIQ),ICON(MAXKLIQ),HUBSIM,STDHS,ALLCON,
     C HUBM1,HUBSTD1,FIXR,HIWT,NFIXR,INDEPT(MAXKLIQ),OUTDEPT(MAXKLIQ),
     C PIW,PIB,GINDEPT,GBDEPT,MINPICT,TD3

       REAL*4 PAGB(MAXKLIQ,MAXKLIQ),OMAXPIW,MAXPIW,OMAXPIB,MAXPIB
      REAL THISTOT,ISOTOT,NEARVAL,STOPVAL,CHANGEC(MAXKLIQ),
     C     NOWCLOSE(MAXKLIQ),CDEPT,LOWCOMP,LOWVAL,MINVAL,
     C     KSIGN,ZABS,QVAL,LASTCHNG,PROBGRP(MAXKLIQ),
     C   THRESHT,DIRECT,BASEVAL,
     C   ACTTIE,VTIE,ETIE,TOPVAL
C          KNEWMAT(MAXKLIQ,MAXKLIQ),
       REAL DEVIATE(MAXKLIQ),INDIVAR(MAXKLIQ),
     C THISDEV,PREVE,PREC,COVAR,HGVAR(MAXKLIQ),
     C MEANWT(MAXKLIQ),VARWT(MAXKLIQ),
     C ZSCORE,PVALUE,TOTHGM,TOTHGV,TOTHGV2,
     C TZSCORE,TPVALUE,HGSTD,TOTHGSTD,TOTHGV3,TOTHGV4,
     C ACONN,AVAR,AMEAN,CHNGESIM,AVAR2,
     C  TACONN,CHOSEVR(MAXKLIQ),
     C  TOTE, TOTV,OUTOF,WPIK,
     C  NOB,STOTCON,
     C  FCOMPACT,CDIAG,VDIAG,MDIAG,MCON,TWEIGHT,
     C  COMPVAL,ZCOMPMAT(MAXKLIQ,MAXKLIQ),EXTRES,EXTOP1,EXTOP2
C        REAL XPRIME(MAXKLIQ,MAXKLIQ),XPRIMEX(MAXKLIQ,MAXKLIQ)
C          ON EXTERNAL ERROR CALL EXTERR (EXTPAR,EXTRES,EXTOP1,EXTOP2)
      INTEGER INMAT(MAXKLIQ,MAXKLIQ),NEWMAT(MAXKLIQ,MAXKLIQ),
     C HITLIST(MAXKLIQ),NUMHLIST,
     C PI,PJ,PK,MAXLAB,MAXCH,NETWORK,QUICKEND,QUANTYPE,SQUAREIT,
     C ATTACHI,SIMRAND
      INTEGER NUMTEACH,TGROUP(MAXKLIQ),TDEPART,G,IG,G3,EASY,G2,
     C EXTPAR,INTPAR
      INTEGER DEPART(MAXKLIQ),NEWDEPT(MAXKLIQ),NEWDIM,
     C SOLUT,NETLEV,GCONTIN,CONVID(MAXKLIQ)
      INTEGER ZEROVAL,K,D,MAXDEPT,DEPARTN(MAXKLIQ)
      REAL KNUMSIM,OMAXG,NUMGROU2,OKPGROUP,KPGROU2,
     C  ONUMTEAC,NUMPEOP2,OMAXCHOI,MAXCHOI2,OMAXFREQ,MAXFRE2
      INTEGER NSIM,USEMARG,MAXCHOIC,MAXFREQ,HIMARG,RECODE(MAXKLIQ),
     C IHIVAL
      REAL GRINC,PGINC,NPINC,MCINC,MFINC,RPINC

      INTEGER ALLGROUP(MAXKLIQ,MAXKLIQ),NUMIT,R,MAXPOS,MAXVAL,MAXG,
     C  KTEMPS,SUMN,R2,R3,S,RCHOICE(MAXKLIQ),Q,TPLACE,HIQ,QI,KQMAX,
     C        MAXPICK,ROW,H,COL,HUBERT(MAXKLIQ,MAXKLIQ),
     C        HUB1,HUB2,Z,M,MADECHNG,MRCHOICE(MAXKLIQ),TDEPARTN,SIMO,
     C   LOWMEM,FOUNDONE,NEWMEMS(MAXKLIQ),NGROUP,THED(MAXKLIQ),
     C   KLIST(MAXKLIQ),
     C   DMEMBERS(MAXKLIQ),ISOLIST(MAXKLIQ),ISO,SKIPIT,OLDLOWM,
     C   TEMPS,THISMEM,NEWORDER(MAXKLIQ),NO,NO2,LENGTH,
     C   GROUP1,GROUP2,EACHPER,THISPER,OLDEPTS(MAXKLIQ),QUITIT,
     C   ANUMIT,NLOCMAX,IER,IK,JK,SUBID(MAXKLIQ),NSUBID(MAXKLIQ),ONLYF,
     C   DB,NDB,B(MAXKLIQ),NKK,NKJ,NKI,NKL,KCOUNT2,ONUMRES,
     C   ONLIST(MAXKLIQ),NPO,PRINTO(100),
     C NBESTDEP(MAXKLIQ),GOTEM(MAXKLIQ),EX,EX2,TNDEPT,NMAXDEPT,EXPERM,
     C HOLDDEPT,PROBGR,PROBI,PROBJ,TNUMSUB,ACTRSQR,REWEIGHT,
     C GUSEMARG,GRPMARG(MAXKLIQ),ACTCHAR1,ACTCHAR2,BLANK1,TEMPNUM,
     C BYANGLE,BYSCALE,BYANGLEI,BYSCALEI,OUSETRID,COMPSIM,SDEPT(MAXKLIQ)

      DOUBLE PRECISION QSEED,RASEED,SSEED,MSEED

      REAL PCONNECT,PROBPER(MAXKLIQ,MAXKLIQ),
     C                 SUMWI,SUMPOS,SUMPROP,SUMBET,
     C                 CONNECTI,SUMPOSI,SUMPROPI,MAXPOSI,
     C                 HMEAN,CONVVAL,BOUNDVAL,BLABOUND,
     C                 DSYMMAT,TWXPX,BETWMULT,
     C                 PCTILE,ROWWT,COLWT,RDEPTN(MAXKLIQ),TNUMT
       DOUBLE PRECISION
     C MISSPROB,TMISSDA,PFITDA(MAXKLIQ),TMISSDB,PFITDB(MAXKLIQ)

      INTEGER RANGEC,MINCHOIC,RANGEG,BASEG,ORANGEP,RANGEP2,
     C RANGEP,WRANGEP,OWRANGEP,WRANGEP2,FINAL,MAKEMISS,
     C MDEPT(MAXKLIQ),TAKEOUT(MAXKLIQ)

      REAL BASEP,OBASEP,BASEP2,BASEPINC,
     C OMAXPWW,MAXPWW,OMAXPWB,MAXPWB,OBASEWP,BASEWP2,FIT(MAXKLIQ),
     C ABICOORD(MAXKLIQ,2),BBICOORD(MAXKLIQ,2),CBICOORD(MAXKLIQ,2),
     C DBICOORD(MAXKLIQ,2),ADSTRESS(MAXKLIQ),TAD,CDSTRESS(MAXKLIQ),TBD


C       CALL PISIM2(NUMTEACH,RANGEC,MINCHOIC,RANGEG,BASEG,
C     C BASEP,BETARAT,BETARAT2,INMAT,SSEED,DEPART

      CHARACTER*16 HEADING,HOWSTART,INFILE,PRIORFIL,OUTFILE,
     C BFILE,BFILE2,BFILEB,BFILE2B,TBFILEB,UPFILE,
     C TPFILE
      CHARACTER*24 IDATE
      CHARACTER*12 PFILE

       REAL BLAUC(MAXKLIQ,MAXKLIQ),DIFF(MAXKLIQ,MAXKLIQ)
       COMMON ZCOMPMAT,ALLGROUP,HUBERT,RESULTM,NEWMAT,
     C BLAUC,DIFF

C       COMMON ZCOMPMAT,ALLGROUP,HUBERT,RESULTM,NEWMAT
C You can comment the next two out for older compilers
C      INTEGER, PARAMETER :: MAXKLIQSQ=MAXKLIQ*MAXKLIQ
C      DATA INMAT /MAXKLIQSQ*0/,ISOLIST/MAXKLIQ*0/,COMPSIM /0/
      DATA SUBID /MAXKLIQ*0/
C NEXT 3 LINES BECAUSE OF NO INITIALIZATIONS AROUND LINE 1731
      DATA SSEED /416151632.0/,KPGROUP/0/,MAXFREQ/0/,PIW/0/,PIB/0/
      DATA BASEG/0/,BASEP/0/,RANGEP/0/,BASEWP/0/,WPIW/0/,WPIB/0/
      DATA WRANGEP/0/,NOWMISS/0/,RMISS/0/,EMISS/0/,BMISS/0/

      MATTYPE='l'
      CALL GETARG(1,INFILE)
      CALL GETARG(2,MATTYPE)
      IF (MATTYPE .EQ. ' ') THEN
      MATTYPE='l'
      END IF
      CALL GETARG(3,PRIORFIL)
      ONE=1
      NSIM=1
      ZEROVAL=0
      RASEED=4161.D0
      QSEED=5163.D0

C      OPEN(8,file='param.clus')





C      OPEN(38,file='refine.dat')


C      OPEN(42,file='hubert.mat')
C      OPEN(43,file='remove.mat')

C      OPEN(507,file='oneconn.lst')



C      OPEN(539,file='group.bcorr')
C      OPEN(521,file='group.ccorr')








      OPEN(60,file='kliqfind.par')
      OPEN(16,file='simulate.par')

C      OPEN(595,file='MDSREAD.CMD')
C      OPEN(556,file='MDSBREAD.CMD')

      OPEN(15,file='recode.dat')
       Q=1
C      IHIVAL=0
       RECODEN=0
       MAKEMISS=0 
       DOMULT=0
          IF (MATTYPE .EQ. 'x') THEN
          DOMULT=1
          END IF 

          SIMO=0
          IF (MATTYPE .EQ. 'w') THEN
          PRIORFIL=INFILE(1:6) // '.tplac'
          SIMO=1
          MATTYPE='b'
          END IF
          
          IF (MATTYPE .EQ. 'z' ) THEN
            MATTYPE='s'
            MAKEMISS=1
           OPEN(95,file='missing.par')
           READ(95,24845,END=4141) BMISS,EMISS,RMISS
04141      CLOSE(95)
           BMISS=BMISS/100
           EMISS=EMISS/100
           RMISS=RMISS/100
          END IF
        DO 24245 I=1,MAXKLIQ
        RECODE(I)=I
24245    CONTINUE
       DO 12829 I=1,74000
C       RDONEIT(I)=0
       READ(15,24545,END=12827) DB,PO
       IF (DB .GT. 0) THEN
       RECODEN=RECODEN+Q
       RECODE(DB)=PO
C       RDONEIT(DB)=Q
       END IF
12829  CONTINUE
12827  CLOSE(15)
C      DO 5439 I=1,IHIVAL
C      IF (RDONEIT(I) .EQ. 0) THEN
C      RECODE(I)=I
C      END IF
C05439  CONTINUE


 
C      READ(556,101) NDB , (DEBUG(DB) , DB = 1,NDB)
      OPEN(99,file='printo')
      READ(99,101,END=83831) NPO , (PRINTO(PO) , PO = 1,NPO)
83831 READ(99,3331,END=83832) (APRINT(PO) , PO=1,NPO) 
83832 CLOSE(99)
C      READ (5,2109) INFILE

C      OPEN(9,file='matrix.cvar')

      WRITE(33,4301) 
      WRITE(33,3114)
      FANCY(1)= 'Welcome to KliqueFinder'
      FANCY(2)= 'developed by Ken Frank'
      FANCY(3)='with help and guidance from'
      FANCY(4)='Anthony Bryk and Charles Bidwell.'
      FANCY(5) ='Data were read from the following files:'
      FANCY(6) = 'kliqfind.par printo hitlist '
      FANCY(7)= ' titles labels'
      FANCY(8)= 'Your optional output will consist of:'
      FANCY(9)='(All output in clusters unless otherwise specified)'
        IF ((SIMO .EQ. 1) .OR.(MATTYPE .EQ. 's')) THEN
         PRINTO(27)=1
        END IF


      NPARGRP=12
      READ(60,34348)
      DO 6445 I=1,NPARGRP
      READ(60,3335) PARTITLE(I),PARFORM(I)
      IF (I .EQ. 1) THEN
      READ(60,PARFORM(I)) NUMDYAD,DYDTRIAD,USETRIAD,EXPERM,RASEED
      END IF
      IF (I .EQ. 2) THEN
      READ(60,PARFORM(I)) DIRECT,THRESHT,LOOKT,MAXSEED
      END IF
      IF (I .EQ. 3) THEN
      READ(60,PARFORM(I)) BOUNDVAL,FIXR,BLABOUND,BETWMULT
      END IF
      IF (I .EQ. 4) THEN
      READ(60,PARFORM(I)) NEARVAL,PCTILE,MUTDYAD,NONEG,HALFDYAD,
     C DISSOLVE
      END IF

      IF (I .EQ. 5) THEN
      READ(60,PARFORM(I)) STOPVAL,KCOUNT2,QUICKEND,ATTACHI
      END IF

      IF (I .EQ. 6) THEN
      READ(60,PARFORM(I)) STRUCTEQ,NETWORK,ACTRSQR
      END IF

      IF (I .EQ. 7) THEN
      READ(60,PARFORM(I)) QUANTYPE,SQUAREIT,NETLEV,PERGROUP,COLWT,
     C ROWWT,HYPERG
      END IF

      IF (I .EQ. 8) THEN
      READ(60,PARFORM(I)) TRANSPOS,REWEIGHT,SYMMAT,INVERT,RECTMAT,
     C GUSEMARG,TAGALONG
      END IF

      IF (I .EQ. 9) THEN
      READ(60,PARFORM(I)) NEVAL,BASEVAL,TOPVAL,NUMRES,NEWGRPS,
     C HIWTEVAL
      END IF
      IF (I .EQ. 10) THEN
       READ(60,PARFORM(I)) IGRATIO,NUMDIM,MINPICT,
     C CENTER,DANCHOR,DANCHOR2,MOVE2,ZSYMMAT,
     C STARTINC,BYINC,MAXINC,KEXP,NORMAL,MINVALG,BYANGLE,BYSCALE,
     C PCTCENG1,PCTCENG2,DRADIUSG
      END IF

      IF (I .EQ. 11) THEN
       READ(60,PARFORM(I)) CENTERI,DANCHORI,DANCH2I,MOVE2I,ZSYMMATI,
     C STARTINI,BYINCI,MAXINCI,KEXPI,NORMALI,MINVALI,BYANGLEI,
     C BYSCALEI,PCTCENI1,PCTCENI2,DRADIUSI
      END IF
      IF (I .EQ. 12) THEN
       READ(60,PARFORM(I)) RINCREM,MEASURE,EXTREME
      END IF


C NUMDIM,RINCREM,MEASURE,EXTREME,IGRATIO,
C    C DRADIUS,KEXP,NORMAL,NORMALI,MINVALG,MINVALI
C       NUMDIM=2
C       END IF

      READ(60,3337) TCHAR(I),LISTVAR(I)
06445  CONTINUE
        CLOSE(60)


C     EXPERM,NEVAL,DYDTRIAD,USETRIAD,NUMDYAD,
C     C NEARVAL,STOPVAL,
C     C SYMMAT,THRESHT,LOOKT,DIRECT,KCOUNT2,BASEVAL,BOUNDVAL,
C     C PCTILE,STRUCTEQ,NETWORK,ACTRSQR,QUICKEND,ROWWT,COLWT,
C     C QUANTYPE,SQUAREIT,UNWEIGHT,NUMRES,RASEED,NETLEV,PERGROUP,
C     C TOPVAL,TRANSPOS
      
       HITFILE='hitlist'
       LABFILE='labels'
       TITFILE='titles'

08877 IF (INFILE(1:1) .NE. '\0') THEN
       OPEN(9,file=INFILE)
      ELSE
      OPEN(9,file='kfake9file')
      END IF
      REWIND(9)

C     
C     READ IN AND ECHO DATA
C

      NUMOBS=0
      MAXG=1
      NUMTEACH=0 
C     SET KMATTYPE='l' then swithc to m if necessary if mattype="" then mattype='l'

      KMATTYPE='l'

        SIMO=0
        IF (MATTYPE .EQ. 's') THEN 
        SIMO=1
        MATTYPE='l'
         END IF
        INLIST=0
        IF ((MATTYPE .EQ. 'l') .OR. (MATTYPE  .EQ. 'b')) THEN
        INLIST=1
        END IF
C      QQQ ASSIGN MATTYPE HERE        
      XINLIST=0
      READ(9,4301,END=33342) TESTCHAR
      DO 40442 PI=1,20
      IF (TESTCHAR(PI:PI) .EQ. ' ') THEN
      XINLIST=XINLIST+1
      END IF
40442 CONTINUE

       IF (XINLIST .EQ. 0) THEN
C  QQQ
       MATTYPE ='m'
       WRITE(6,4301) 'KliqueFinder has detected that' 
       WRITE(6,4301) 'your data are in matrix format.'
       WRITE(6,4301) 'If this is not the case rerun and' 
       WRITE(6,4301) 'indicate the data are' 
       WRITE(6,4301) 'in list format by checking "list" in the' 
       WRITE(6,4301) 'upper right of the graphical interface.'
       END IF
 
33342  REWIND(9)


      DO 4454 PI=1,MAXKLIQ
      NSUBID(PI)=PI
      DEPART(PI)=PI
04454  CONTINUE

      IF ((MATTYPE(1:1) .EQ. 'l')  .OR. (MATTYPE .EQ. 'b')) THEN
      INPLACE=0
      DO 2824 I=1,200000
C      CHANGED FORMATTING HERE      
C      READ(9,5101,END=2827) PI,PJ,PK
      READ(9,*,END=2827) PI,PJ,PK
      IF ((PI .GT. NUMTEACH) .AND. (PRINTO(40) .EQ. 0)) THEN
      NUMTEACH=PI
      END IF
      IF ((PJ .EQ. 99999) .AND. (PRINTO(40) .EQ. 0)) THEN

      IF (PK .GT. MAXGR) THEN
      WRITE(6,4301) ' You have indicated an a priori subgroup'
      WRITE(6,4303) MAXGR
      WRITE(6,4301) ' the number of a priori subgroups to this number.'
      WRITE(6,4301) ' The actor and subgroup which '
      WRITE(6,4301) ' triggered this are:'
      WRITE(6,1251) PI,PK
      CALL MYSTOP
      END IF

      IF (PK .GT. 0) THEN
        DEPART(PI)=PK
        IF (PK .GT. MAXG) THEN
        MAXG=PK
        END IF
      END IF
      ELSE

      IF ((PI .GT. 0) .AND. (PJ .GT. 0) .AND. (PK .NE. 0)) THEN
      IF (PRINTO(40) .EQ. 0) THEN
      IF (PJ .GT. NUMTEACH) THEN
      NUMTEACH=PJ
      END IF
      HAVEI=PI
      HAVEJ=PJ
      ELSE

      HAVEI=0
      HAVEJ=0
      IF ((PRINTO(40) .EQ. 1) .AND. (PJ .EQ. 99999)) THEN
      HAVEJ=99999
      END IF

      J=0
      DO WHILE (((HAVEI .EQ. 0) .OR. (HAVEJ .EQ. 0)) .AND.
     C (J .LT. INPLACE))
      J=J+1
      IF (NSUBID(J) .EQ. PI) THEN
      HAVEI=J
      END IF
      IF (NSUBID(J) .EQ. PJ) THEN
      HAVEJ=J
      END IF
       END DO
      IF (HAVEI .EQ. 0) THEN
      INPLACE=INPLACE+1
      NSUBID(INPLACE)=PI
       SUBID(INPLACE)=PI
      HAVEI=INPLACE
      END IF
      IF ((PI .NE. PJ) .AND.(HAVEJ .EQ. 0)) THEN
      INPLACE=INPLACE+1
      NSUBID(INPLACE)=PJ
       SUBID(INPLACE)=PJ
      HAVEJ=INPLACE
      END IF
       NUMTEACH=INPLACE
      END IF
      NUMOBS=NUMOBS+1
      IF (((HAVEI .GT. MAXKLIQ) .OR. (HAVEJ .GT. MAXKLIQ)) .AND. 
     C (HAVEJ .NE. 99999)) THEN
      WRITE(6,4301)
      WRITE(6,4301) ' Either a row or column element is '
      WRITE(6,4302) ' greater than ',MAXKLIQ
      IF (PRINTO(40) .EQ. 0) THEN
      WRITE(6,4301) ' Either reduce the number'
      WRITE(6,4301) ' of elements in your data or use PRINTO(40) '
      WRITE(6,4302) ' to rank your ID''s to values below ',MAXKLIQ
      ELSE
      WRITE(6,4301) ' You must reduce the number of unique ID''s'
      WRITE(6,4301) ' in your data  file.'          
      WRITE(6,4301)
      WRITE(6,4301) ' A listing of the unique ID''s is in'
      WRITE(6,4301) ' keeplist.dat'
      WRITE(6,4301)

C      OPEN(37,file='keeplist.dat')
C      TOPNUM=HAVEI
C     IF (HAVEJ .GT. HAVEI) THEN 
C      TOPNUM=HAVEJ
C      END IF
C      DO 9091 DI=1,TOPNUM
C      WRITE(37,1251) NSUBID(DI),DI
C09091  CONTINUE
C      CLOSE(37)


      END IF
      WRITE(6,4301) ' The row and column elements which '
      WRITE(6,4301) ' triggered this are:'
      WRITE(6,1251) PI,PJ
      CALL MYSTOP
      END IF
      IF ((HAVEJ .EQ. 99999) .AND. (PRINTO(40) .EQ. 1)) THEN
      IF (PK .GT. MAXGR) THEN
      WRITE(6,4301) ' You have indicated an a priori subgroup'
      WRITE(6,4303) MAXGR
      WRITE(6,4301) ' the number of a priori subgroups to this number.'
      WRITE(6,4301) ' The actor and subgroup which '
      WRITE(6,4301) ' triggered this are:'
      WRITE(6,1251) PI,PK
      CALL MYSTOP
      END IF
      IF (PK .GT. 0) THEN
        DEPART(HAVEI)=PK
        IF (PK .GT. MAXG) THEN
        MAXG=PK
        END IF
      END IF
      END IF
      IF ((HAVEJ .NE. 99999) .AND. 
     C (HAVEI .GT. 0) .AND. (HAVEJ .GT. 0)) THEN 
      INMAT(HAVEI,HAVEJ)=PK
      END IF

      END IF

C      IF (PJ .GT. NUMTEACH) THEN
C      NUMTEACH=PJ
C      END IF

      END IF
02824  CONTINUE
02827  CLOSE(9)

c      IF (PRINTO(10) .EQ. 1) THEN
c      OPEN(30,file='clus.outmat')
c      DO 22837 I=1,NUMTEACH
c      WRITE(30,101) NEWDEPT(I) , (NEWMAT(I,K) , K=1,NUMTEACH)
c22837 CONTINUE
c      CLOSE(30)
c      END IF


       WRITE(33,1078) 'NUMOBS',NUMOBS

02819  WRITE(33,1078) 'NUMTEACH',NUMTEACH


       DO 2820 PI=1,NUMTEACH
        IF (PRINTO(40) .EQ. 0) THEN
        NSUBID(PI)=PI
        SUBID(PI)=PI
        END IF

        DO 2821 PJ=1,NUMTEACH
        IF (INMAT(PI,PJ) .LT. 1) THEN
         INMAT(PI,PJ)=0
        END IF
02821    CONTINUE
02820     CONTINUE
      

      END IF
      MAXG=1
      INLIST=0
      IF ((MATTYPE .EQ. 'b') .OR. (MATTYPE .EQ. 'l')) THEN
      INLIST=1
       END IF
      IF (INLIST .EQ. 0) THEN
      NUMTEACH=1
      DO 820 I=1,MAXKLIQ
      READ(9,4101,END=819) DEPART(I)
      NUMTEACH=NUMTEACH+1
00820  CONTINUE
00819   REWIND(9)
       NUMTEACH=NUMTEACH-1
      IF (NUMTEACH .GT. MAXKLIQ) THEN
      WRITE(6,4301) ' You have more than the max observations.'
      WRITE(6,4301) ' This is greater than the maximum which'
      WRITE(6,4301) ' this ol'' version of KliqueFinder can'
      WRITE(6,4302) ' handle.  Please reduce to less than ',MAXKLIQ
      CALL MYSTOP
      END IF
      DO 20 I=1,NUMTEACH
      READ(9,101,END=20) DEPART(I), (INMAT(I,J) , J=1,NUMTEACH)
      IF (DEPART(I) .GT. MAXGR) THEN
      WRITE(6,4301) ' You have indicated an a priori subgroup'
      WRITE(6,4303) MAXGR
      WRITE(6,4301) ' the number of a priori subgroups to this number.'
      WRITE(6,4301) ' The actor and subgroup which '
      WRITE(6,4301) ' triggered this are:'
      WRITE(6,1251) I,DEPART(I)
      CALL MYSTOP
      END IF
      DO 5116 J=1,NUMTEACH
      IF (INMAT(I,J) .NE. 0) THEN
      NUMOBS=NUMOBS+1
      END IF
05116  CONTINUE
      NSUBID(I)=I
      SUBID(I)=I
      IF (DEPART(I) .GT. MAXG) THEN
       MAXG=DEPART(I)
      END IF
      IF ((MATTYPE .EQ. 'g')  .OR. (MATTYPE .EQ. 'b')) THEN
      DEPART(I)=0
       END IF
   20 CONTINUE
       END IF

      IF ((MATTYPE .EQ. 'g')  .OR. (MATTYPE .EQ. 'b') ) THEN
      O2MAXG=0
      IF ((PRIORFIL(1:1) .EQ. '\0') .AND. (PRINTO(24) .EQ. 1)) THEN
      WRITE(6,4301) ' You have indicated that groups should be taken'
      WRITE(6,4301) ' from a second file but have not given the name'
      WRITE(6,4301) ' of the file.  Please indicate the name of the'
      WRITE(6,4301) ' of the second file, or hit return to use groups'
      WRITE(6,4301) ' from the original data file:'
        READ(5,*) PRIORFIL
      END IF
      OUTLOOP=0
      DO WHILE ((PRIORFIL(1:1) .NE. '\0') .AND. (O2MAXG .EQ. 0)
     C .AND. (OUTLOOP .EQ. 0)) 
      OPEN(24,file=PRIORFIL)
      REWIND(24)
      DO 166 PID=1,NUMTEACH
       READ(24,251,END=2166) T1,T2,TD3
      IF ((T2 .LT. 99999) .AND. (TD3 .GT. O2MAXG)) THEN
       O2MAXG=TD3
      END IF
  166   CONTINUE
02166   REWIND(24)
        IF (PRIORFIL(1:8) .EQ. 'nogroups') THEN
         O2MAXG=NUMTEACH
         QUICKEND=1
        END IF
        IF ((O2MAXG .EQ. 0) .AND. (PRINTO(24) .EQ. 1)) THEN
        CLOSE(24)
        WRITE(6,4301) PRIORFIL, ' contains no groups greater than '
         UPFILE=PRIORFIL
        PRIORFIL(1:1)='\0'
        WRITE(6,4301) ' zero.  Enter a new file with subgroup'
        WRITE(6,4301) ' placements or type ''none'' to use placements'
        WRITE(6,4301) ' from original data file:'
        READ(5,*) PRIORFIL
         IF (PRIORFIL(1:4) .EQ. 'none') THEN
         OUTLOOP=1
         PRIORFIL=INFILE
         END IF
C        ELSE

C        PRIORFIL=''
        END IF
        END DO
        IF (O2MAXG .GT. 0) THEN
      MAXG=0
      OPEN(24,file=PRIORFIL)
      REWIND(24)
       TNT=NUMTEACH
      DO 1686 PID=1,NUMTEACH
       READ(24,251,END=2167) T1,T2,TD3
       IF (PRINTO(40) .EQ. 1) THEN
        NOTFOUND=0
        FOUNDPER=1
        DO WHILE ((NOTFOUND .EQ. 0) .AND. (FOUNDPER .LE. NUMTEACH))
        IF (NSUBID(FOUNDPER) .EQ. T2) THEN 
        NOTFOUND=1
        ELSE
        FOUNDPER=FOUNDPER+1
        END IF
        END DO
        IF (NOTFOUND .EQ. 0) THEN
        TNT=TNT+1
        NSUBID(TNT)=T2
        END IF
       
C       DEPART(FOUNDPER)=INT(TD3)

       ELSE
       FOUNDPER=INT(T2)
C        DEPART(T2)=INT(TD3)
       END IF
       DEPART(FOUNDPER)=INT(TD3)
       IF (PRIORFIL(1:8) .EQ. 'nogroups') THEN
        MAXG=MAXG+1
        DEPART(FOUNDPER)=MAXG
        QUICKEND=1
       END IF
      IF ((FOUNDPER .LE. NUMTEACH) .AND.
     C  (DEPART(FOUNDPER) .GT. MAXG)) THEN
       MAXG=DEPART(FOUNDPER)
      END IF
01686  CONTINUE
       NUMTEACH=TNT
       ELSE
       WRITE(33,4301) UPFILE, ' not used because it did not contain'
       WRITE(33,4301) 'valid data.'
       WRITE(6,4301) UPFILE, ' not used because it did not contain'
       WRITE(6,4301) ' valid data.'
      END IF
02167        CLOSE(24)
        IF (PRIORFIL(1:8) .EQ. 'nogroups') THEN
        QUICKEND=1
        DO 5772 MAXG=1,NUMTEACH
        DEPART(MAXG)=MAXG
05772    CONTINUE
        MAXDEPT=NUMTEACH
        END IF
        WRITE(33,1078) 'MAXG',MAXG

       END IF

C      WRITE(33,1078) 'TNUMSUB',TNUMSUB
       MAXLAB=52
       IF (MAXG .GT. MAXLAB) THEN
       MAXLAB=MAXG
       END IF

       IF ((NUMOBS .LT. 2) .OR.
     C (NUMTEACH .LE. 1) .OR. (MATTYPE .EQ.'p')) THEN
       IF ((INFILE(1:1) .NE. '\0') .AND. (MATTYPE .NE. 'p')) THEN
       WRITE(6,4301) ' There is no readable data in your list file'
       WRITE(6,4301) ' either input the name of a new data file'
       WRITE(6,4301)
     C   ' or type ''none'' to enter parameters interactively'
       READ(5,*) INFILE
       END IF

       IF ((INFILE .EQ. 'none') .OR. (INFILE(1:1) .EQ. '\0') .OR. 
     C (MATTYPE .EQ. 'p')) THEN
       CALL GETPARS(EXPERM,NEVAL,DYDTRIAD,USETRIAD,NUMDYAD,NUMTEACH,
     C NEARVAL,STOPVAL,WPIK,
     C SYMMAT,THRESHT,LOOKT,DIRECT,KCOUNT2,BASEVAL,BOUNDVAL,
     C PCTILE,STRUCTEQ,NETWORK,ACTRSQR,QUICKEND,ROWWT,COLWT,
     C QUANTYPE,SQUAREIT,REWEIGHT,PRINTO,APRINT,NPO,INFILE,
     C MATTYPE,PRIORFIL,HITFILE,LABFILE,TITFILE,NUMHLIST,TITLES,
     C FANCY,NUMRES,RASEED,NETLEV,PERGROUP,TOPVAL,TRANSPOS,
     C MAXG,GCONTIN,NPARGRP,PARTITLE,PARFORM,LISTVAR,TCHAR,NEWGRPS,
     C FIXR,BLABOUND,INVERT,RECTMAT,BETWMULT,HIWTEVAL,MUTDYAD,
     C NONEG,MAXSEED,ATTACHI,HALFDYAD,DISSOLVE,GUSEMARG,TAGALONG,
     C NUMOBS,
     C  IGRATIO,NUMDIM,
     C CENTER,DANCHOR,DANCHOR2,MOVE2,ZSYMMAT,
     C STARTINC,BYINC,MAXINC,KEXP,NORMAL,MINVALG,
     C CENTERI,DANCHORI,DANCH2I,MOVE2I,ZSYMMATI,
     C STARTINI,BYINCI,MAXINCI,KEXPI,NORMALI,MINVALI,
     C RINCREM,MEASURE,EXTREME,DRADIUSG,DRADIUSI,
     C BYANGLE,BYSCALE,BYANGLEI,BYSCALEI,MINPICT,HYPERG,
     C PCTCENIG,PCTCENG2,PCTCENI1,PCTCENI2)

C     C CENTER,DANCHOR2,MOVE2,DANCHOR,ZSYMMAT,MAXINC,
C     C BYINC,STARTINC,NUMDIM,RINCREM,MEASURE,EXTREME,IGRATIO,HYPERG,
C     C DRADIUS,KEXP,NORMAL,NORMALI,MINVALG,MINVALI)
        ELSE
        GCONTIN=0
       END IF

       IF (GCONTIN .EQ. 0) THEN
       GOTO 8877
       END IF

       END IF 
          
C       BOTHP=2
       ONUMDYAD=NUMDYAD
       DONEONE=0
       CLOSE(9)
       CLOSE(214)
C       IF (DRADIUS .LE. 0) THEN 
C       DRADIUS=1
C       END IF
        OUSETRID=USETRIAD
       IF (HYPERG .LT. 0) THEN 
       HYPERG=0
       END IF
       IF (HYPERG .GT. 1) THEN
       HYPERG=1
       END IF

       IF (RECODEN .GT. 0) THEN 
       DO 21224 I=1,NUMTEACH
       DO 21225 J=1,NUMTEACH
       IF (RECODE(INMAT(I,J)) .NE. INMAT(I,J)) THEN
       INMAT(I,J)=RECODE(INMAT(I,J))
       END IF
21225   CONTINUE
21224    CONTINUE
       END IF
       IF (SYMMAT .GT. 0) THEN 
       ROWWT=1
       COLWT=1
C       BOTHP=1
        DO 45432 I=2,NUMTEACH
         DO 45431 J=1,(I-1)
          INMAT(I,J)=INMAT(I,J)+INMAT(J,I)
          INMAT(J,I)=INMAT(I,J)
45431     CONTINUE
45432     CONTINUE
        END IF

C      IF (NETLEV .EQ. 1) THEN
C       WRITE(33,4301)
C       write(3,4301) 'Assigning nearval=0.000 and pctile=2.00 because'
C       WRITE(33,4301) 'You assigned netlev =1'
C       WRITE(33,4301)
C       NEARVAL=0.0000
C       PCTILE=2.0
C      END IF
      IF (QUICKEND .EQ. 1) THEN
       WRITE(33,4301)
       WRITE(33,4301) 'Assigning startgrp=3 because you assigned'
       WRITE(33,4301) 'quickend =1 .'
       WRITE(33,4301)
      USETRIAD=3
      END IF
      
      OPEN(40,file=HITFILE)
      OPEN(51,file=LABFILE)
      OPEN(52,file=TITFILE)
C        READ(16,24546,END=55155) KNUMSIM,OMAXG,NUMGROU2,OKPGROUP,
       NUMHLIST=0
       READ(40,203,END=22203) NUMHLIST , (HITLIST(H) , H=1,NUMHLIST)
22203  READ(51,511,END=22204) (LABEL(LB) , LB=1,MAXLAB)
22204  READ(52,77,END=44333) (TITLES(T) , T=1,3)
       DO 44332 QR=1,NUMHLIST
        QHLIST(QR)=HITLIST(QR)
44332   CONTINUE
44333   QNHLIST=NUMHLIST
        CLOSE(51)
        CLOSE(52)
      OUTFILE=INFILE(1:6) // '.clusters'
      OPEN(33,file=OUTFILE)

      BFILE=INFILE(1:6) // '.boundary'
C      OPEN(555,file=BFILE)
      BFILE2=INFILE(1:6) // '.bound2'
C      OPEN(575,file=BFILE2)
C      TBFILEB=INFILE(1:6) // '.bddat'
C      OPEN(217,file=TBFILEB)

      IF (PRINTO(26) .EQ. 1) THEN
      BFILEB=INFILE(1:6) // '.boundB'
C      OPEN(210,file=BFILEB)
      BFILE2B=INFILE(1:6) // '.bound2B'
C      OPEN(211,file=BFILE2B)
      TBFILEB=INFILE(1:6) // '.Bbddat'
C      OPEN(26,file=TBFILEB)
      END IF

      IF (PRINTO(29) .EQ. 1) THEN
      TBFILEB=INFILE(1:6) // '.BTWdat'
C      OPEN(221,file=TBFILEB)
      END IF

      IF (PRINTO(14) .GT. 0) THEN
      PFILE=INFILE(1:6) // '.place'
       END IF

       
        WRITE(33,4301)
      CALL FDATE(idate) 
 
      WRITE(33,4301) 'Welcome to KliqueFinder, software for identifying'
      WRITE(33,4301) 'cohesive subgroups and mapping relations within '
      WRITE(33,4301) 'and between cohesive subgroups.  For references'
      WRITE(33,4301) 'see:'
      WRITE(33,4301) 'Frank, K.A. (1996). Mapping interactions within' 
      WRITE(33,4301) 'and between cohesive subgroups. Social Networks.'
       WRITE(33,4301) 'Volume 18, pages 93-119.'
      WRITE(33,4301)
      WRITE(33,4301) 'and'
      WRITE(33,4301)
      WRITE(33,4301) 'Frank. K.A. (1995). Identifying Cohesive '
      WRITE(33,4301) 'Subgroups. Social Networks, 17, 27-56.'
      WRITE(33,4301)

      WRITE(33,1077) 'DATE'
      WRITE(33,1077) IDATE
      WRITE(33,1077) 'INPUT FILE: '
      WRITE(33,1077) INFILE 
      WRITE(33,1077) 'DATA TYPE'
      WRITE(33,1077) MATTYPE
      IF ((MATTYPE .EQ. 'l') .OR. (MATTYPE .EQ. 'b')) THEN
      WRITE(33,1077) 'DATA IN LIST FORM'
      ELSE
      WRITE(33,1077) 'DATA IN MATRIX FORM'
      END IF
      WRITE(33,1077) 'USING PRIOR GROUPS:'
      IF ((MATTYPE .EQ. 'g') .OR. (MATTYPE .EQ. 'b')) THEN
      WRITE(33,1077) PRIORFIL
      ELSE 
      WRITE(33,1077) INFILE
      END IF
C      IF (STRUCTEQ .EQ. 1) THEN
C      DIRECT=0
C      END IF

      WPIK=1.0000
      IF (PRINTO(1) .EQ. 1) THEN
      WRITE(33,1077)
      WRITE(33,1077) 'PARAMETERS'
      DO 6446 I=1,NPARGRP
      WRITE(33,3337) PARTITLE(I)
      IF (I .EQ. 1) THEN
      WRITE(33,PARFORM(I)) NUMDYAD,DYDTRIAD,USETRIAD,EXPERM,RASEED
      END IF
      IF (I .EQ. 2) THEN
      WRITE(33,PARFORM(I)) DIRECT,THRESHT,LOOKT,MAXSEED
      END IF
      IF (I .EQ. 3) THEN
      WRITE(33,PARFORM(I)) BOUNDVAL,FIXR,BLABOUND,BETWMULT
      END IF
      IF (I .EQ. 4) THEN
      WRITE(33,PARFORM(I)) NEARVAL,PCTILE,MUTDYAD,NONEG,HALFDYAD,
     C DISSOLVE
      END IF

      IF (I .EQ. 5) THEN
      WRITE(33,PARFORM(I)) STOPVAL,KCOUNT2,QUICKEND,ATTACHI
      END IF

      IF (I .EQ. 6) THEN
      WRITE(33,PARFORM(I)) STRUCTEQ,NETWORK,ACTRSQR
      END IF

      IF (I .EQ. 7) THEN
      WRITE(33,PARFORM(I)) QUANTYPE,SQUAREIT,NETLEV,PERGROUP,COLWT,
     C ROWWT,HYPERG
      END IF

      IF (I .EQ. 8) THEN
      WRITE(33,PARFORM(I)) TRANSPOS,REWEIGHT,SYMMAT,INVERT,RECTMAT,
     C GUSEMARG,TAGALONG
      END IF

      IF (I .EQ. 9) THEN
      WRITE(33,PARFORM(I)) NEVAL,BASEVAL,TOPVAL,NUMRES,NEWGRPS,HIWTEVAL
      END IF
      IF (I .EQ. 10) THEN
      WRITE(33,PARFORM(I)) IGRATIO,NUMDIM,MINPICT,
     C CENTER,DANCHOR,DANCHOR2,MOVE2,ZSYMMAT,
     C STARTINC,BYINC,MAXINC,KEXP,NORMAL,MINVALG,BYANGLE,BYSCALE,
     C PCTCENG1,PCTCENG2,DRADIUSG
      END IF

      IF (I .EQ. 11) THEN
      WRITE(33,PARFORM(I)) CENTERI,DANCHORI,DANCH2I,MOVE2I,ZSYMMATI,
     C STARTINI,BYINCI,MAXINCI,KEXPI,NORMALI,MINVALI,BYANGLEI,
     C BYSCALEI,
     C PCTCENI1,PCTCENI2,DRADIUSI
      END IF
      IF (I .EQ. 12) THEN
      WRITE(33,PARFORM(I)) RINCREM,MEASURE,EXTREME
      END IF

      WRITE(33,3337) ' ',LISTVAR(I)
06446  CONTINUE
       END IF

       IF (PRINTO(27) .EQ. 1) THEN
       WRITE(33,4301) 'Writing to End of Files'
       WRITE(33,4301)
       OPEN(19,file='compmeas.dat')
       CALL MOVEEND(19)
       OPEN(25,file='compmeas.sas')
        WRITE(25,4301) 'options linesize=80;'
        WRITE(25,4301) 'options pagesize=59;'
      WRITE(25,4301) 
     C'TITLE1 ''Analysis of Compactness Measures from simulated data'';'
      WRITE(25,4301) 'Title2 ''',TITLES(1),TITLES(2),TITLES(3),''';'

       WRITE(25,4301) 'data one; infile ''compmeas.dat'';'
       WRITE(25,4301) 'ATTRIB FILENAME LENGTH=$16; input'
       WRITE(25,4301) 'filename 1-16 SSEED 17-36'
       WRITE(25,4301) ' (SIMNUM MAXG KPGROUP NUMACT '
       WRITE(25,4301) ' MAXCONN MAXWT) (10.5) /'
       WRITE(25,4301) '(KCOMPACT FCOMPACT TZI TZING TGRCOMP '
        WRITE(25,4301) 'ACTG XTGRCOMP TMGRCOMP ACTG2'
       WRITE(25,4301) 'XTMGRCMP IGRCOMP XIGRCOMP '
       WRITE(25,4301) 'IMGRCOMP XIMGRCMP INUM'
       WRITE(25,4301) 'FCOMPAC8 ONDIAG3 XONDIAG3'
       WRITE(25,4301) 'FCOMPAC9 XONDIAG4 MEDSIZE TOTCENT TOTDENS '
       WRITE(25,4301) 'INITCONN CHNGSIM CHNGPOSS CHNGSTD '
       WRITE(25,4301) 'PEARSON LRATIO )'
       WRITE(25,4301) ' (10.5);'

      WRITE(25,4301)
     C'label '
      WRITE(25,4301)
     C'CHNGSIM=''COMMON ASSIGNMENTS -- PRIOR TO EMERGENT'''
      WRITE(25,4301)
     C'CHNGPOSS=''POSS COMMON ASSIGNMENTS -- PRIOR TO EMERGENT'''
      WRITE(25,4301)
     C'CHNGSTD=''STDIZED COMMON ASSIGNMENTS -- PRIOR TO EMERGENT'''
      WRITE(25,4301)
     C'PEARSON=''PEARSONS MEASURE OF FIT'''
      WRITE(25,4301)
     C'LRATIO=''LIKELIHOOD RATIO MEASURE OF FIT'''
      WRITE(25,4301)
     C'SIMNUM=''SIMULATION NUMBER'''
        WRITE(25,4301)
     C'MAXG=''NUMBER OF GROUPS (A PRIORI)'''
        WRITE(25,4301)
     C'KPGROUP=''ACTORS PER GROUP (A PRIORI)'''
        WRITE(25,4301)
     C'NUMACT=''NUMBER OF ACTORS'''
        WRITE(25,4301)
     C'MAXCONN=''MAX CONNECTIONS FROM AN ACTOR'''
        WRITE(25,4301)
     C'MAXWT=''MAX WEIGHT ASSIGNED TO A CONN'''
        WRITE(25,4301) 
     C'SSEED=''seed value for this simulation'''
      WRITE(25,4301)
     C'KCOMPACT=''KLIQFINDS COMPACTNESS -- LIKE HUBERT'''
      WRITE(25,4301)
     C'FCOMPACT=''HUBERTS COMPACTNESS'''
      WRITE(25,4301)
     C'TZI=''SUM OF THE ZI AT INDIVIDUAL LEVEL'''
      WRITE(25,4301)
     C'TZING=''SUM OF ZI (OVER Ng) AT INDIVIDUAL LEVEL'''
      WRITE(25,4301)
     C'IGRCOMP=''SUM OF GROUP COMPACTNESS -- I'''
      WRITE(25,4301)
     C'TGRCOMP=''SUM OF GROUP COMPACTNESS -- G'''
      WRITE(25,4301)
     C'ACTG=''ACTUAL NUMBER OF NONZERO GROUPS'''
      WRITE(25,4301)
     C'XTGRCOMP=''Mean GROUP COMPACTNESS -- G'''
      WRITE(25,4301)
     C'XIGRCOMP=''Mean GROUP COMPACTNESS -- I'''
      WRITE(25,4301)
     C'IMGRCOMP=''SUM OF GROUP  COMPACTNESS (OVER Ng) -- I'''
      WRITE(25,4301)
     C'TMGRCOMP=''SUM OF GROUP  COMPACTNESS (OVER Ng) -- G'''
      WRITE(25,4301)
     C'ACTG2=''ACTUAL NUMBER OF NON-ZERO GROUPS'''
      WRITE(25,4301)
     C'XTMGRCMP=''Mean GROUP COMPACTNESS (OVER Ng) -- G'''
      WRITE(25,4301)
     C'XIMGRCMP=''Mean GROUP COMPACTNESS (OVER Ng) -- I'''
       WRITE(25,4301)
     C 'FCOMPAC8 =''Blau: Net-wide proportin conn in groups'''
       WRITE(25,4301)
     C 'ONDIAG3 =''Blau: Sum Diag, Mean Wthin Grp Conn'''
       WRITE(25,4301)
     C 'XONDIAG3 =''Blau: Mean Diag, Mean Wthin Grp Conn'''
       WRITE(25,4301)
     C 'FCOMPAC9 =''Blau: Net-Wide mean within group conn'''
       WRITE(25,4301)
     C 'XONDIAG4 =''Blau: Mean Diag, Prop conn in groups'''
      WRITE(25,4301)
     C'INUM=''NUMBER OF NON-ISOLATES'''
        WRITE(25,4301) 
     C'MEDSIZE=''MEDIAN SUBGROUP SIZE'''
        WRITE(25,4301) 
     C'TOTCENT=''AVERAGE SUBGROUP CENTRALITY -- DENSITY'''
        WRITE(25,4301)
     C'INITCONN=''# ACTORS WHO INITIATED CONNECTIONS'''
        WRITE(25,4301)
     C'TOTDENS=''TOTAL DENSITY -- NO SUBGROUPS'';'
      WRITE(25,4301)
      WRITE(25,4301)
     C ' array cmeas {24} '
      WRITE(25,4301)
     C 'kcompact fcompact tzi tzing tgrcomp '
      WRITE(25,4301)
     C 'xtgrcomp tmgrcomp xtmgrcmp igrcomp xigrcomp FCOMPAC9 XONDIAG4'
      WRITE(25,4301)
     C'imgrcomp ximgrcmp FCOMPAC8 ONDIAG3 XONDIAG3 TOTCENT TOTDENS'
      WRITE(25,4301)
     C 'CHNGSIM CHNGPOSS CHNGSTD PEARSON LRATIO;'
      WRITE(25,4301)
      WRITE(25,4301)
     C '*do i =1 to 24 ;'
      WRITE(25,4301)
     C '*cmeas{i}=cmeas{i}/inum ;'
      WRITE(25,4301)
     C '*end ;'
      WRITE(25,4301) 'Proc sort;'
      WRITE(25,4301) 'by filename;'
     

      WRITE(25,4301)
     C 'data two;'
      WRITE(25,4301) 'source=''compact   '';'
      WRITE(25,4301) 
     C 'infile ''central.dat'' missover;'
      WRITE(25,4301) 
     C 'input filename $ 1-16 type $ diag $ actg amean avar askew;'
      WRITE(25,4301) 'Proc sort;'
      WRITE(25,4301) 'by filename;'

      WRITE(25,4301) 
     C 'data three;'
      WRITE(25,4301) 'source=''density'';'
      WRITE(25,4301) 
     C 'infile ''central.bdat'' missover;'
      WRITE(25,4301) 
     C 'input filename $ 1-16 type $ diag $ actg bmean bvar bskew;'
      WRITE(25,4301) 'Proc sort;'
      WRITE(25,4301) 'by filename;'

      WRITE(25,4301) 
     C 'data four;'
      WRITE(25,4301) 'source=''Zi'';'
      WRITE(25,4301) 
     C 'infile ''central.cdat'' missover;'
      WRITE(25,4301) 
     C 'input filename $ 1-16 type $ diag $ actg cmean cvar cskew;'
      WRITE(25,4301) 'Proc sort;'
      WRITE(25,4301) 'by filename;'

      WRITE(25,4301) 
     C 'data five;'
      WRITE(25,4301) 'source=''PctWithin'';'
      WRITE(25,4301) 
     C 'infile ''central.ddat'' missover;'
      WRITE(25,4301) 
     C 'input filename $ 1-16 type $ diag $ actg dmean dvar dskew;'
      WRITE(25,4301) 'Proc sort;'
      WRITE(25,4301) 'by filename;'

      WRITE(25,4301) 
     C 'data six;'
      WRITE(25,4301) 
     C 'merge one two three four five;'
      WRITE(25,4301) 
     C 'by filename;'
      WRITE(25,4301) 'Proc print;'
      WRITE(25,4301)
      WRITE(25,4301)
      WRITE(25,4301) 

     C 'proc corr;'
      WRITE(25,4301)
     C 'var maxg kpgroup numact maxconn maxwt actg MEDSIZE initconn;'
      WRITE(25,4301)
     C 'with kcompact fcompact tzi tzing tgrcomp '
      WRITE(25,4301)
     C 'xtgrcomp tmgrcomp xtmgrcmp igrcomp xigrcomp FCOMPAC9 XONDIAG4'
      WRITE(25,4301)
     C'imgrcomp ximgrcmp FCOMPAC8 ONDIAG3 XONDIAG3 TOTCENT TOTDENS'
      WRITE(25,4301)
     C 'CHNGSIM CHNGPOSS CHNGSTD PEARSON LRATIO;'
      WRITE(25,4301)
      WRITE(25,4301)
     C 'proc plot; plot'
      WRITE(25,4301)
     C '(kcompact fcompact tzi tzing tgrcomp '
      WRITE(25,4301)
     C ' xtgrcomp tmgrcomp xtmgrcmp igrcomp xigrcomp '
      WRITE(25,4301)
     C'imgrcomp ximgrcmp FCOMPAC8 ONDIAG3 XONDIAG3'
      WRITE(25,4301) 'FCOMPAC9 XONDIAG4 TOTCENT TOTDENS'
      WRITE(25,4301) ' PEARSON LRATIO)'
      WRITE(25,4301)
     C '*(maxg kpgroup numact maxconn maxwt actg MEDSIZE initconn);'
       CLOSE(25)
      END IF
      WRITE(33,1077)

      WRITE(33,2109)
      WRITE(33,2109) 'The objective function to be maximized is:'
      IF (QUANTYPE .EQ. 0) THEN
      QUANTYPE=1
      END IF

      IF (QUANTYPE .EQ. 1) THEN
      WRITE(33,2109) 'Hubert''s Compactness'
      END IF
 
      IF (QUANTYPE .EQ. 2) THEN
      WRITE(33,2109) 'Pearson''s Chi-Square from Logit (If squared)'
      END IF

      IF (QUANTYPE .EQ. 3) THEN
      WRITE(33,2109) 'Likelihood Ratio Statistic from Logit'
      END IF

      IF (QUANTYPE .EQ. 4) THEN
      WRITE(33,2109) 'Density (FACTIONS)'
      END IF

      IF (QUANTYPE .EQ. 5) THEN
      WRITE(33,2109) 'Theta1 (see Frank, 1995,1996)'
      END IF

  

      IF (QUANTYPE .EQ. -3) THEN
      WRITE(33,2109) 'Likelihood Ratio Statistic from Logit'
      WRITE(33,2109) 'Using penalty associated'
      WRITE(33,2109) 'with Bayesian Loss Function'
      WRITE(33,2109) 'See Raftery, (1986)'
      END IF

      WRITE(33,2109)
      IF (SQUAREIT .EQ. 1) THEN
      WRITE(33,2109) 'The distances will be squared'
      END IF

      WRITE(33,2109)
      IF (PERGROUP .EQ. 1) THEN
      WRITE(33,2109) 'The distances will be divided by group size'
      END IF
      WRITE(33,2109)
      IF (NETLEV .EQ. 1) THEN
      WRITE(33,2109) 'The distances will be taken at'
      WRITE(33,2109) 'the network level.'
      END IF
      WRITE(33,2109)
       FINAL=1
       IF (RECTMAT .EQ. 1) THEN
       TRANSPOS=1
       END IF

       DO 04333 MBI=1,NUMTEACH

       IF ((INMAT(MBI,MBI) .GT. 0) .AND. (STRUCTEQ .NE. 1)) THEN
        WRITE(33,04334) NSUBID(MBI),INMAT(MBI,MBI)
        INMAT(MBI,MBI) = 0
       END IF

       IF (TRANSPOS .EQ. 1) THEN
       DO 2233 MBJ=1,MBI
       TPLACE=INMAT(MBI,MBJ)
       INMAT(MBI,MBJ)=INMAT(MBJ,MBI)
       INMAT(MBJ,MBI)=TPLACE
02233   CONTINUE
       END IF
04333   CONTINUE

       IF (RECTMAT .GT. 0) THEN
       IF ((STRUCTEQ .EQ. 1) .AND. (NETWORK .EQ. 1)) THEN
        THIWT=0
        DO 93942 I=1,NUMTEACH
        DO 93944 J=1,NUMTEACH
       IF (INMAT(I,J) .GT. THIWT) THEN
        THIWT=INMAT(I,J)
       END IF
93944   CONTINUE
93942   CONTINUE

        DO 93941 I=1,NUMTEACH
        INMAT(I,I)=THIWT
93941    CONTINUE
       END IF

       IF (GUSEMARG .EQ. 1) THEN
       HIMARG=0
       DO 87873 I=1,NUMTEACH
       GRPMARG(I)=0
87873   CONTINUE
       DO 87871 J=1,NUMTEACH
       DO 87872 I=1,NUMTEACH
       IF (INMAT(I,J) .GT. 0) THEN
       GRPMARG(J)=GRPMARG(J)+INMAT(I,J)
       END IF
87872   CONTINUE
        IF (GRPMARG(J) .GT. HIMARG) THEN
        HIMARG=GRPMARG(J)
         END IF
87871    CONTINUE

       END IF
C  XXXXX
       DO 9856 MBI=1,NUMTEACH
       OPEN(39,FILE='DYADMUL')
       DO 5545 I=1,NUMTEACH
       ADDONI=0
       ADDONO=0
       ADDONIJ=0
       ADDONJI=0
       DO 5546 J=1,NUMTEACH
       ADDON=INMAT(I,J)*INMAT(MBI,J)
       IF ((I .NE. J) .AND. (I .NE. MBI) 
     C    .AND. (MBI .NE. J)) THEN
       ADDONO=ADDONO+ADDON
       ADDONI=ADDONI+INMAT(J,I)*INMAT(J,MBI)
       ADDONIJ=ADDONIJ+INMAT(I,J)*INMAT(J,MBI)
       ADDONJI=ADDONJI+INMAT(MBI,J)*INMAT(J,I)
       END IF
       IF ((GUSEMARG .EQ. 1) .AND. (GRPMARG(J) .GT. 0)) THEN
        ADDON=INT(HIMARG*ADDON/GRPMARG(J))
       END IF
       NEWMAT(I,MBI)=NEWMAT(I,MBI)+ADDON
05546  CONTINUE
        WRITE(39,1251) NSUBID(MBI),NSUBID(I),ADDONO,
     C   ADDONI,ADDONIJ,ADDONJI
05545   CONTINUE

09856    CONTINUE
        DO 9866 I=2,NUMTEACH
        DO 9836 J=1,(I-1.)
        INMAT(I,J)=NEWMAT(J,I)
        INMAT(J,I)=NEWMAT(J,I)
09836    CONTINUE
        INMAT(I,I)=0
09866     CONTINUE
        INMAT(1,1)=0
        END IF



C        INVERTING
        HIWT=0
        MAXCHOIC=0
        DO 8996 I=1,NUMTEACH
        THISMAX=0
        DO 8997 J=1,NUMTEACH
        IF (INMAT(I,J) .NE. 0) THEN
        THISMAX=THISMAX+1
        IF (INMAT(I,J)  .GT. HIWT) THEN
        HIWT=INMAT(I,J)
        END IF
        END IF
08997    CONTINUE
        IF (THISMAX .GT. MAXCHOIC) THEN
        MAXCHOIC=THISMAX
         END IF
08996     CONTINUE
         HOWWIDE=1
         IF (HIWT .GT. 9) THEN
         HOWWIDE=INT(LOG10(HIWT))+2.0
         END IF

       IF (INVERT .EQ. 1) THEN
       DO 28996 I=2,NUMTEACH
       DO 28997 J=1,(I-1.)
       INMAT(I,J)=HIWT-INMAT(I,J)
       INMAT(J,I)=HIWT-INMAT(J,I)
28997   CONTINUE
28996   CONTINUE
        END IF

C      WRITE(60,187) 'PREREMOVE', NUMTEACH

      IF (REWEIGHT .NE. 0) THEN
      IF (HIWT .GT. REWEIGHT) THEN
       HIWT=REWEIGHT
      END IF
       DO 9876 I=1,NUMTEACH
       DO 98765 J=1,NUMTEACH
        IF (INMAT(I,J) .GT. REWEIGHT) THEN
         INMAT(I,J)=REWEIGHT
         END IF
98765     CONTINUE
09876      CONTINUE
       END IF
           
        KNUMSIM=1
       QMAXG=MAXG
       IF (MAXG .NE. 0) THEN
       QKPGROUP=INT(NUMTEACH/MAXG)
       END IF
       QNUMTEAC=NUMTEACH
       QMAXCHOI=MAXCHOIC
       QMAXFREQ=HIWT
        IF (SIMO .EQ. 1) THEN
        LISTFILE=INFILE (1:6) // '.tplac'

        PRINTO(27)=1
C       GENERATE SIMULATED DATA
     
C       READ PARAMETERS FOR SIMULATE
        READ(16,24546,END=55155) KNUMSIM,OMAXG,NUMGROU2,OKPGROUP,
     C  KPGROU2,
     C  ONUMTEAC,NUMPEOP2,OMAXCHOI,MAXCHOI2,OMAXFREQ,MAXFRE2,SSEED,
     C USEMARG,OMAXPIW,MAXPIW,OMAXPIB,MAXPIB,REGSIM,BYDENSE,SIMRAND,
     C OBASEP,BASEP2,ORANGEP,RANGEP2,COMPSIM,
     C OMAXPWW,MAXPWW,OMAXPWB,MAXPWB,OBASEWP,BASEWP2,OWRANGEP,
     C WRANGEP2,XOBASEP,XBASEP2,XORANGEP,XRANGEP2,
     C OPREPWI,PREPWI2,OPREQWI,PREQWI2, 
     C OPREPBT,PREPBT2,OPREQBT,PREQBT2,PKPG,QKPG,PSIZE,QSIZE
        CLOSE(16)
55155   IF ((OPREPWI .LE. 0) .OR. (OPREPWI .GT. 999)) THEN
        PSIZE=10
        QSIZE=10
        QKPG=10
        PKPG=10
        PREQBT2=200
        OPREQBT=200
        PREPBT2=200
        OPREPBT=200
        PREQWI2=200
        OPREQWI=200
        PREPWI2=200
        OPREPWI=200
        END IF

        SSEED=416151632
        MSEED=416151633
        PKPG=PKPG/10
        QKPG=QKPG/10
        PSIZE=PSIZE/10.0
        QSIZE=QSIZE/10.0
        OBASEWP=OBASEWP/10.00
        BASEWP2=BASEWP2/10.00
        WRANGEP2=WRANGEP2/10.00
        OWRANGEP=OWRANGEP/10.00
        ORANGEP=ORANGEP/10.00
        RANGEP2=RANGEP2/10.00

        XORANGEP=XORANGEP/10.00
        XRANGEP2=XRANGEP2/10.00

        OBASEP=OBASEP/10.00
        BASEP2=BASEP2/10.00

        XOBASEP=XOBASEP/10.00
        XBASEP2=XBASEP2/10.00

        OPREPWI=OPREPWI/100.00
        OPREQWI=OPREQWI/100.00
        PREPWI2=PREPWI2/100.00
        PREQWI2=PREQWI2/100.00
        OPREPBT=OPREPBT/100.00
        OPREQBT=OPREQBT/100.00
        PREPBT2=PREPBT2/100.00
        PREQBT2=PREQBT2/100.00

        OMAXPWW=OMAXPWW/100.00
        MAXPWW=MAXPWW/100.00
        OMAXPWB=OMAXPWB/100.00
        MAXPWB=MAXPWB/100.00
        MAXPIW=MAXPIW/100.00
        OMAXPIW=OMAXPIW/100.00
        MAXPIB=MAXPIB/100.00
        OMAXPIB=OMAXPIB/100.00
         IF (KNUMSIM .GT. 1) THEN
C     C OMAXPWW,MAXPWW,OMAXPWB,MAXPWB,OBASEWP,BASEWP2)
        IF (RMISS .LT. .00001) THEN
        RMISS=(EMISS-BMISS)/(KNUMSIM-1.)
        END IF
        PPWIINC=(PREPWI2-OPREPWI)/(KNUMSIM-1.) 
        PQWIINC=(PREQWI2-OPREQWI)/(KNUMSIM-1.) 

        PPBTINC=(PREPBT2-OPREPBT)/(KNUMSIM-1.) 
        PQBTINC=(PREQBT2-OPREQBT)/(KNUMSIM-1.) 

        BASEWPIN=(BASEWP2-OBASEWP)/(KNUMSIM-1.)
        BASEPINC=(BASEP2-OBASEP)/(KNUMSIM-1.)
        XBPINC=(XBASEP2-XOBASEP)/(KNUMSIM-1.)
        GRINC=(NUMGROU2-OMAXG)/(KNUMSIM-1.)
        PGINC=(KPGROU2-OKPGROUP)/(KNUMSIM-1.)
        RPINC=(RANGEP2-ORANGEP)/(KNUMSIM-1.)
        XRPINC=(XRANGEP2-XORANGEP)/(KNUMSIM-1.)
        WRPINC=(WRANGEP2-OWRANGEP)/(KNUMSIM-1.)
        NPINC=(NUMPEOP2-ONUMTEAC)/(KNUMSIM-1.)
        MCINC=(MAXCHOI2-OMAXCHOI)/(KNUMSIM-1.)
        MFINC=(MAXFRE2-OMAXFREQ)/(KNUMSIM-1.)
        GINDEPT=(MAXPIW-OMAXPIW)/(KNUMSIM-1.)
        GBDEPT=(MAXPIB-OMAXPIB)/(KNUMSIM-1.)

        GWINDEPT=(MAXPWW-OMAXPWW)/(KNUMSIM-1.)
        GWBDEPT=(MAXPWB-OMAXPWB)/(KNUMSIM-1.)
        
         ELSE
         BASEPINC=0
         BASEWPIN=0

        GRINC=0
        PGINC=0
        XBPINC=0
        XRPINC=0
        RPINC=0
        WRPINC=0
        NPINC=0
        MCINC=0
        MFINC=0
        GINDEPT=0
        GBDEPT=0

        GWINDEPT=0
        GWBDEPT=0
         END IF        

        ONUMRES=NUMRES


       END IF
C       HAVE SIMULATED DATA

       DO 4545 NSIM=1,KNUMSIM 
        IF (SIMO .EQ. 1) THEN
       IF (USEMARG .EQ. 1) THEN
      NUMHLIST=QNHLIST
      DO 4433 QR=1,NUMHLIST
      HITLIST(QR)=QHLIST(QR)
04433  CONTINUE
       ELSE
       NUMHLIST=0
       END IF


C      CALL REMOVEO(INMAT,NUMTEACH,HITLIST,NUMHLIST,DEPART,NEWMAT,
C     C               NEWDEPT,USETRIAD,SUBID,NSUBID,KLIST)

       IF (USEMARG .EQ. 0) THEN     
       IF (MAKEMISS .EQ. 1) THEN   
       NOWMISS=BMISS+RMISS*(NSIM-1.)
       END IF 
C   PREPWI,PREQWI,PREPBT,PREQBT)
       PREPWI=(OPREPWI+PPWIINC*(NSIM-1.))
       PREQWI=(OPREQWI+PQWIINC*(NSIM-1.))
       PREPBT=(OPREPBT+PPBTINC*(NSIM-1.))
       PREQBT=(OPREQBT+PQBTINC*(NSIM-1.))
       MAXG=INT(OMAXG+GRINC*(NSIM-1.))
       RANGEP=(ORANGEP+RPINC*(NSIM-1.))
       XRANGEP=(XORANGEP+XRPINC*(NSIM-1.))
       KPGROUP=INT(OKPGROUP+PGINC*(NSIM-1.))
       NUMTEACH=INT(ONUMTEAC+NPINC*(NSIM-1.))
       MAXCHOIC=INT(OMAXCHOI+MCINC*(NSIM-1.))
       MAXFREQ=INT(OMAXFREQ+MFINC*(NSIM-1.))
       PIW=OMAXPIW+GINDEPT*(NSIM-1.)
       PIB=OMAXPIB+GBDEPT*(NSIM-1.)
       BASEP=OBASEP+BASEPINC*(NSIM-1.)
       XBASEP=XOBASEP+XBPINC*(NSIM-1.)
       BASEWP=OBASEWP+BASEWPIN*(NSIM-1.)
       WPIW=OMAXPWW+GWINDEPT*(NSIM-1.)
       WPIB=OMAXPWB+GWBDEPT*(NSIM-1.) 
       WRANGEP=(OWRANGEP+WRPINC*(NSIM-1.))
C     C OMAXPWW,MAXPWW,OMAXPWB,MAXPWB,OBASEWP,BASEWP2)
       DO 48343 I=1,MAXGR
       INDEPT(I)=PIW
        IF (REGSIM .EQ. 4) THEN
       TNUM=NUMTEACH-MAXGR
       TMAX=KPGROUP+MAXCHOIC-12+1
       PL=.790360+(.0051540)*TNUM+(-.016847)*TMAX+
     C (-.000027)*TNUM**2+(.002689)*TMAX**2+(-.000424)*TNUM*TMAX
       INDEPT(I)=PIW+PL-2*.0161
       END IF
        IF ((REGSIM .EQ. 0) .AND. (BYDENSE .EQ. 1)) THEN
       TNUM=NUMTEACH-MAXGR
       TMAX=KPGROUP+MAXCHOIC-12
       PL=.3170-(.004674)*TNUM+(-.0187395)*TMAX+
     C (.0000715)*TNUM**2-(.0005217)*TMAX**2+(-.000185)*TNUM*TMAX
       INDEPT(I)=PIW+PL-2*.01179
       END IF

       OUTDEPT(I)=PIB
48343   CONTINUE
              
       ELSE
       MAXG=QMAXG
       KPGROUP=QKPGROUP
       NUMTEACH=QNUMTEAC
       MAXCHOIC=QMAXCHOI
       MAXFREQ=QMAXFREQ
       MAXFREQ=INT(HIWT)
       RANGEP=ORANGEP
       END IF
C       IF (USEMARG .EQ. 0) THEN       
       NUMRES=ONUMRES
       FIXR=MAXCHOIC

       
        DO 4457 PID=1,NUMTEACH
        NSUBID(PID)=PID
        SUBID(PID)=PID
04457    CONTINUE
      IF (USETRIAD .EQ. 4) THEN
      OPEN(39,file='holdname2')
      REWIND(39)
      WRITE(39,7760) 'sim',NSIM,'.slist'
      CLOSE(39)
      OPEN(39,file='holdname2')
      READ(39,7761) LISTFILE
      CLOSE(39)
      OPEN(21,FILE=LISTFILE)

      NUMOBS=1
      MAXG=0
      NUMTEACH=0 
      DO 2822 I=1,74000
      READ(21,5101,END=2227) PI
      NUMOBS=NUMOBS+1
02822  CONTINUE
02227  REWIND(21)
       NUMOBS=NUMOBS-1
       WRITE(33,1077) 'NUMOBS',NUMOBS
      DO 28243 I=1,NUMOBS
      READ(21,5101) PI,PJ,PK
      IF (PI .GT. NUMTEACH) THEN
      NUMTEACH=PI
      END IF
      IF (PJ .EQ. 99999) THEN
        DEPART(PI)=PK
        IF (PK .GT. MAXG) THEN
        MAXG=PK
        END IF

      ELSE
      IF ((PI .GT. 0) .AND. (PJ .GT. 0)) THEN
        INMAT(PI,PJ)=PK
      END IF
      IF (PJ .GT. NUMTEACH) THEN
      NUMTEACH=PJ
      END IF

      END IF
28243 CONTINUE
       CLOSE(21)

       WRITE(33,1077) 'NUMTEACH',NUMTEACH
       DO 6820 PI=1,NUMTEACH
       NSUBID(PI)=PI
        DO 6821 PJ=1,NUMTEACH
        IF (INMAT(PI,PJ) .LT. 1) THEN
         INMAT(PI,PJ)=0
        END IF
06821    CONTINUE
06820     CONTINUE


      
       ELSE
C       USETRIAD .EQ. 4
C        SSEED=1443728851
C        REGSIM=0
        BYLAMN=0

        IF (REGSIM .EQ. 4) THEN
        BYLAMN=1
        END IF

        IF (REGSIM .EQ. 1) THEN
        CALL SIMULATE(MAXG,KPGROUP,NUMTEACH,MAXCHOIC,MAXFREQ,
     C INMAT,DEPART,SSEED,USEMARG)
        END IF
        IF ((REGSIM .EQ. 2) .OR. (BYLAMN .EQ. 1)) THEN
       BASEG=3
       FINAL=2
        CALL PISIM(MAXG,KPGROUP,NUMTEACH,MAXCHOIC,MAXFREQ,
     C INMAT,DEPART,SSEED,USEMARG,INDEPT,OUTDEPT,BYDENSE,SIMRAND,
     C PSIZE,QSIZE,BASEG,PKPG,QKPG,BYLAMN)

        END IF
        IF (REGSIM .EQ. 3) THEN 
       FINAL=2
       BASEG=3
       CALL PISIM2(NUMTEACH,KPGROUP,MAXCHOIC,MAXG,BASEG,
     C BASEP,PIW,PIB,INMAT,SSEED,DEPART,MAXFREQ,RANGEP,
     C BASEWP,WPIW,WPIB,WRANGEP,NSIM,XBASEP,XRANGEP,
     C PREPWI,PREQWI,PREPBT,PREQBT,PKPG,QKPG,PSIZE,QSIZE)
         END IF

        IF (COMPSIM .GT. 0) THEN
        SPCTILE=PCTILE
        SNEARVAL=NEARVAL
        USETRIAD =3
        END IF

        DONEONE=0
       IF (PRINTO(24) .EQ. 1) THEN
       WRITE(6,4301)
       WRITE(6,4304) ' Simulated Data Set #',NSIM
C      WRITE(6,5101) NSIM
       WRITE(6,4301)
       WRITE(6,4301) ' SSEED,NSIM,'
       WRITE(6,4301)' MAXG,KPGROUP,NUMTEACH,MAXCHOIC,MAXFREQ,'
       WRITE(6,4301) ' PIWITHIN,PIBETWEEN'
       WRITE(6,76543) SSEED
       WRITE(6,251) (1.0*NSIM),
     C MAXG,KPGROUP,NUMTEACH,MAXCHOIC,MAXFREQ,
     C PIW,PIB,BASEG,BASEP,RANGEP,BASEWP,WPIW,WPIB,WRANGEP

       WRITE(6,4301)
       END IF
       WRITE(33,4301)
       WRITE(33,4304) ' Simulated Data Set #',NSIM
C      WRITE(33,5101) NSIM
       WRITE(33,4301)
       WRITE(33,4301) ' SSEED,MAXG,KPGROUP,NUMTEACH,MAXCHOIC,MAXFREQ'
       WRITE(33,4301) ' PIWITHIN,PIBETWEEN'
       WRITE(33,4301) ' BASEG,BASEP,RANGEP,BASEWP,WPIW,WPIB,WRANGEP'
       WRITE(33,76543) SSEED
       WRITE(33,251) NSIM,MAXG,KPGROUP,NUMTEACH,MAXCHOIC,MAXFREQ,
     C PIW,PIB,BASEG,BASEP,RANGEP,BASEWP,WPIW,WPIB,WRANGEP


       WRITE(33,4301)

       END IF
       IF (PRINTO(14) .GT. 0) THEN
        OPEN(56,file=LISTFILE)
      DO 8166 PID=1,NUMTEACH
       WRITE(56,88251) PID,NSUBID(PID),NEWDEPT(PID),NSIM,1
 8166   CONTINUE
         CLOSE(56)
        END IF

       END IF        
       IF (PRINTO(27) .EQ. 1) THEN
       WRITE(19,7654) INFILE,SSEED
       WRITE(19,1251) NSIM,MAXG,KPGROUP,NUMTEACH,MAXCHOIC,MAXFREQ,
     C PIW,PIB,BASEG,BASEP,RANGEP,BASEWP,WPIW,WPIB,WRANGEP,NOWMISS
       END IF
C      IF (MAKEMISS .EQ. 1) THEN
C       CALL KMISS(NOWMISS,NUMTEACH,SSEED,HITLIST,NUMHLIST)
C      END IF
      IF (REWEIGHT .NE. 0) THEN
       DO 9176 I=1,NUMTEACH
       DO 91765 J=1,NUMTEACH
        IF (INMAT(I,J) .GT. REWEIGHT) THEN
         INMAT(I,J)=REWEIGHT
         END IF
91765     CONTINUE
09176      CONTINUE
       END IF
C       IF (TAGALONG .GT. 0) THEN
      DO 61623 PI=(NUMTEACH+1),MAXKLIQ
      DEPART(PI)=0
61623 CONTINUE

      CALL REMOVEO(INMAT,NUMTEACH,HITLIST,NUMHLIST,DEPART,
     C               NEWDEPT,USETRIAD,SUBID,NSUBID,KLIST,PAIRS,PAIRUP,
     C   CONVID,TAGALONG,STRUCTEQ)
C       END IF
      DO 26 OD=1,NUMTEACH
       IF (NEWDEPT(OD) .EQ. 0) THEN
       NEWDEPT(OD)=MAXG+1
       MAXG=MAXG+1
       END IF

       SDEPT(OD)=NEWDEPT(OD)
       B(OD)=MOD(OD,10)
   26 CONTINUE
        IF (DOMULT .EQ. 1) THEN 
         DO 54044 I=1,NUMTEACH
         OUTCOME(I)=-9999
54044     CONTINUE
        PFILE=INFILE(1:6) // '.oc'
        OPEN(57,file=PFILE)
        DO 33202 I=1,251
        READ(57,251,END=52166) T2,OC1
        T1=CONVID(T2)
        IF ((T1 .GT. 0) .AND. (T1 .LT. MAXKLIQ) ) THEN
        OUTCOME(T1)=OC1
        END IF
33202    CONTINUE
        
52166    CLOSE(57)


         CALL ZMK(NUMTEACH,NEWMAT,NEWDEPT,OUTCOME,OUTMUL,
     C   OTCOUNT)
        PFILE=INFILE(1:6) // '.ml'
        OPEN(57,file=PFILE)
        DO 98981 I=1,NUMTEACH
        WRITE(57,8251) NSUBID(I), (OUTMUL(U,I) , U=1,5) ,
     C  (OTCOUNT(U,I) , U=1,5)
C       READ(57,101) NPO , (PRINTO(PO) , PO = 1,NPO)
98981    CONTINUE
        CLOSE(57)
         CALL MYSTOP
         END IF

      CALL HUBIZE(NEWDEPT,NUMTEACH,HUBERT,STRUCTEQ)

C     INITIALIZE SUMS, MAX DEPT, DEPARTMENT SIZE COUNTER
      MAXDEPT=0

      H=0
      NFIXR = FIXR !RTC
      CALL ARCHOICE(NUMTEACH,NEWMAT,RCHOICE,MAXCH,NFIXR,
     C FLAGR,MEANWT,VARWT)
C      CALL MEANVAR(NUMTEACH,PWEIGHTS,RCHOICE,MEANWT,VARWT)
C
C     ASSIGN PEOPLE TO GROUPS ACCORDING TO RAW DATA

      DO 71623 PI=(NUMTEACH+1),MAXKLIQ
      DEPART(PI)=0
      DEPARTN(PI)=0
71623 CONTINUE

      CALL ASSIGN(NUMTEACH,NEWDEPT,MAXDEPT,
     C DEPARTN,RCHOICE,MEANWT,VARWT,
     C 1,2)


C    FIGURE OUT THE CONNECTION BETWEEN EACH PERSON ACCORDING TO COMPACTNESS
      KTEMPS=2
      DO 64 MBI=2,NUMTEACH
       DO 66 MBJ=1,(MBI-1)
         ETIE=0
         VTIE=0
         ACTTIE=0
         ZCOMPMAT(MBI,MBJ)=0
         IF ((RCHOICE(MBI) .GT. 0) .AND. (ROWWT .GT. 0)) THEN
         CALL DISTRIB (RCHOICE(MBI),MEANWT(MBI),
     C    VARWT(MBI),AMEAN,AVAR,KTEMPS,NUMTEACH,MBI,AVAR2,HYPERG)
         ETIE=AMEAN*ROWWT
         VTIE=AVAR*ROWWT**2
         ACTTIE=NEWMAT(MBI,MBJ)
          END IF
         IF ((RCHOICE(MBJ) .GT. 0) .AND. (COLWT .GT. 0)) THEN
         CALL DISTRIB (RCHOICE(MBJ),MEANWT(MBJ),
     C    VARWT(MBJ),AMEAN,AVAR,KTEMPS,NUMTEACH,MBI,AVAR2,HYPERG)
         ETIE=ETIE+AMEAN*COLWT
         VTIE=VTIE+AVAR*COLWT**2
         ACTTIE=ACTTIE+NEWMAT(MBJ,MBI)
          END IF
         IF (VTIE .GT. 0) THEN
        ZCOMPMAT(MBI,MBJ)=(ACTTIE-ETIE)/SQRT(VTIE)
         END IF
        ZCOMPMAT(MBJ,MBI)=ZCOMPMAT(MBI,MBJ)
   66  CONTINUE
         ZCOMPMAT(MBI,MBI)=1.00
   64 CONTINUE
        ZCOMPMAT(1,1)=1.000

      CALL FISHERZ (ZCOMPMAT,NUMTEACH)


      IF (PRINTO(21) .LT. 2) THEN
      HAVEAPR=0
      DO 6541 I=1,MAXDEPT
      IF (DEPARTN(I) .GT. 1) THEN
      HAVEAPR=1
      END IF
06541 CONTINUE
      
      IF (HAVEAPR .LT. 1) THEN
      PRINTO(21)=0
      MAXDEPT=NUMTEACH
      WRITE(33,4301)
      WRITE(33,4301) 'Each actor is affiliated with a '
      WRITE(33,4301) 'a unique a priori group.  That is,'
      WRITE(33,4301) 'each a priori group contains only'
      WRITE(33,4301) 'one actor.  Therefore no output for'
      WRITE(33,4301) 'a priori groups.  To override, set'
      WRITE(33,4301) 'printo(21) equal to 2.'
      WRITE(33,4301)


      END IF 
      END IF

      IF (PRINTO(21) .LT. 2) THEN
      HAVEAPR2=0
      IF (MAXDEPT .GT. 1) THEN 
      HAVEAPR2=1
      END IF
      IF (HAVEAPR2 .LT. 1) THEN
      PRINTO(21)=0
      MAXDEPT=NUMTEACH
      WRITE(33,4301)
      WRITE(33,4301) 'Each actor is affiliated with a '
      WRITE(33,4301) 'only one a priori group. '
      WRITE(33,4301) 'Therefore no output for apiori groups.'
      WRITE(33,4301)
      END IF 
      END IF

      IF ((NUMTEACH .GT. 2) .AND. (PRINTO(21) .GT. 0)) THEN
      STARTTRY=3
      CALL SASCENT (CHANGEC,STOPVAL,LOWMEM,NUMTEACH,
     C MADECHNG,ISO,ISOLIST,NEWDEPT,MEANWT,VARWT,WPIK,
     C NEARVAL,DEPARTN,MAXDEPT,
     C RCHOICE,DMEMBERS,QUITIT,LASTCHNG,NSUBID,
     C TITLES,KCOUNT2,PRINTO,BOUNDVAL,PCTILE,
     C DIRECT,TWXPX,SYMMAT,STARTTRY,IEXPECT,ISTD,ICON,
     C ACTRSQR,NOWCLOSE,STRUCTEQ,1,ROWWT,COLWT,QUANTYPE,
     C SQUAREIT,SOLUT,NETLEV,PERGROUP,INFILE,BLABOUND,MAXCH,MUTDYAD,
     C NONEG,MAXSEED,ATTACHI,HALFDYAD,DISSOLVE,HYPERG)
       LAST=0

      CALL PRINTG(MAXDEPT,DEPARTN,NUMTEACH,
     C RCHOICE,NEWDEPT,MEANWT,VARWT,LABEL,TITLES,1,KLIST,
     C FINAL,SYMMAT,PRINTO,NSUBID,'A PRIORI GROUPS       ',IEXPECT,ISTD,
     C ICON,STRUCTEQ,NOWCLOSE,PERGROUP,QUANTYPE,SQUAREIT,
     C FIXR,INFILE,HOWWIDE,BETWMULT,QUICKEND,NSIM,BOUNDVAL,BLABOUND,
     C HIWT,
     C  IGRATIO,NUMDIM,
     C CENTER,DANCHOR,DANCHOR2,MOVE2,ZSYMMAT,
     C STARTINC,BYINC,MAXINC,KEXP,NORMAL,MINVALG,
     C CENTERI,DANCHORI,DANCH2I,MOVE2I,ZSYMMATI,
     C STARTINI,BYINCI,MAXINCI,KEXPI,NORMALI,MINVALI,
     C RINCREM,MEASURE,EXTREME,DRADIUSG,DRADIUSI,
     C BYANGLE,BYSCALE,BYANGLEI,BYSCALEI,MINPICT,
     C PCTCENG1,PCTCENG2,PCTCENI1,PCTCENI2,ROWWT,COLWT,SIMO,1,
     C ABICOORD,HYPERG,LAST)

      END IF

       IF (USETRIAD .EQ. 3) THEN 
       HOWSTART=' A PRIORI GROUPS'
       NUMDYAD=MAXDEPT
C      IF (MATTYPE .EQ. 's') THEN
C      OPEN(39,file='holdname2')
C      REWIND(39)
C      WRITE(339,7760) 'sim',NSIM,'.splace'
C      CLOSE(39)
C      OPEN(39,file='holdname2')
C      READ(39,7761) PLACEFILE
C      OPEN(210,FILE=PLACEFILE)
C      MAXG=0
C      DO 8111 PID=1,NUMTEACH
C       READ(210,251) KPID,NSUBID(PID),NEWDEPT(PID)
C      IF (NEWDEPT(PID) .GT. MAXG) THEN
C       MAXG=NEWDEPT(PID)
C      END IF
C 8111   CONTINUE
C      END IF

       END IF


       IF ((COMPSIM .EQ. 1) .OR. (USETRIAD .EQ. 1)) THEN
         IF (COMPSIM .EQ. 1) THEN
         NUMDYAD=ONUMDYAD
         END IF
 

        IF (DYDTRIAD .EQ. 1) THEN
         HOWSTART='BEST TRIADS'
       CALL KMULTMA2(NUMTEACH,RCHOICE,DIRECT,COLWT,ROWWT,
     C ONLIST,NUMDYAD,PERSON1,PERSON2,PERSON3)

C      I NOW HAVE NUMDYAD BEST MUTUALLY EXCLUSIVE TRIADS
C       IN TRIAD(90,3)

C     PERSON1, PERSON2, AND PERSON3 ARE ARRAYS OF THE PEOPLE
C      IN THE TRYADS (EXCLUSIVE) INTEGER (85)
C
C      CLOSEPAIR IS AN ARRAY OF THE CLOSENESS OF THE EXCLUSIVE TRIADS
C       REAL (251)
C
C      TRIDLIST IS A FOUR DIMENSIONAL ARRAY OF THE WHOLE TRIAD LIST
C       INTEGER 8000,3
C       CLOSEGRP IS A REAL ONE DIMENSIONAL (27000) ARRAY OF THE CLOSENESS
C          OF EACH GROUP


C       SUBROUTINE INITGRP(NUMDYAD,PERSON1,PERSON2,PERSON3,
C     C NEWDEPT,NUMTEACH,LIST,L)

      CALL INITGRP(NUMDYAD,PERSON1,PERSON2,PERSON3,NEWDEPT,
     C NUMTEACH,NLIST,NUMNLIST,NSUBID)       

       END IF
C        DYDTRIAD = 1

       IF (DYDTRIAD .EQ. 2) THEN
         HOWSTART='BEST DYADS'
       CALL KMULTMAD(ZCOMPMAT,NUMTEACH,RCHOICE,DIRECT,COLWT,ROWWT,
     C ONLIST,NUMDYAD,PERSON1,PERSON2)

C      I NOW HAVE NUMDYAD BEST MUTUALLY EXCLUSIVE TRIADS

      CALL INITGRPD(NUMDYAD,PERSON1,PERSON2,NEWDEPT,
     C NUMTEACH,NLIST,NUMNLIST,NSUBID)       

       END IF
C       DYDTRIAD = 2    

C      EXPERM=1
      STARTG=3
      MAXDEPT=NUMTEACH-2
      IF (EXPERM .EQ. 1) THEN
      DO 00141 EX=1,NUMTEACH
      GOTEM(EX) = 0
00141  CONTINUE
      GOTEM(PERSON1(1))=1
      GOTEM(PERSON2(1))=1
      IF (DYDTRIAD .EQ. 1) THEN
      GOTEM(PERSON3(1))=1
      MAXDEPT=MAXDEPT-1
      END IF
      TNDEPT=2
      DO 00747 EX2=1,NUMTEACH
        IF (GOTEM(EX2) .NE. 1) THEN
          NEWDEPT(EX2)=TNDEPT
          TNDEPT=TNDEPT+1
        END IF
00747    CONTINUE
       END IF

       END IF
C       USETRIAD=1



       IF ((COMPSIM .EQ. 2) .OR. (USETRIAD .EQ. 2)) THEN
       HOWSTART='RANDOM ASSIGN'
C      SUBROUTINE RANDASSG (ELEMENTS,NUMELEM,INSEED,NUMGROUP)
        CALL RANDASSG(NEWDEPT,NUMTEACH,RASEED,NUMDYAD)
       END IF
      WRITE(33,79) HOWSTART,NUMDYAD
      IF (EXPERM .NE. 1) THEN
      MAXDEPT=NUMDYAD
       END IF
C      WRITE(33,251) NEWMAT

      IF ((USETRIAD .NE. 3) .OR. (DONEONE .EQ. 1)) THEN
C      ONE=1
C      TWO=2
C      SUBROUTINE ASSIGN2(SUBJECTS,KAFFIL,MAXGROUP,
C     C COUNTGR)

      CALL ASSIGN2(NUMTEACH,NEWDEPT,MAXDEPT,
     C DEPARTN)
       END IF
       IF (NUMDYAD .LT. (NUMTEACH/3)) THEN
 
      IF (EXPERM .NE. 1) THEN
      CALL ATTACHO2 (CHANGEC,STOPVAL,LOWMEM,NUMTEACH,
     C MADECHNG,ISO,ISOLIST,NEWDEPT,MEANWT,VARWT,COLWT,
     C NEARVAL,DEPARTN,MAXDEPT,
     C RCHOICE,DMEMBERS,QUITIT,LASTCHNG,NSUBID,
     C TITLES,HYPERG)
       END IF

       END IF
C       NUMDYAD LT 
       IF (COMPSIM .GT. 0) THEN
       DO 2441 OD=1,NUMTEACH
       OLDEPTS(OD)=NEWDEPT(OD)
       NEWDEPT(OD)=SDEPT(OD)
02441   CONTINUE
         END IF

C       END IF
C       NUMDYAD LT 


      IF ((NUMTEACH .GT. 2) .AND. (PRINTO(5) .EQ. 1)) THEN
      STARTTRY=3
      CALL SASCENT (CHANGEC,STOPVAL,LOWMEM,NUMTEACH,
     C MADECHNG,ISO,ISOLIST,NEWDEPT,MEANWT,VARWT,WPIK,
     C NEARVAL,DEPARTN,MAXDEPT,
     C RCHOICE,DMEMBERS,QUITIT,LASTCHNG,NSUBID,
     C TITLES,KCOUNT2,PRINTO,BOUNDVAL,PCTILE,
     C DIRECT,TWXPX,SYMMAT,STARTTRY,IEXPECT,ISTD,ICON,
     C ACTRSQR,NOWCLOSE,STRUCTEQ,1,ROWWT,COLWT,QUANTYPE,
     C SQUAREIT,SOLUT,NETLEV,PERGROUP,INFILE,BLABOUND,MAXCH,MUTDYAD,
     C NONEG,MAXSEED,ATTACHI,HALFDYAD,DISSOLVE,HYPERG)

       LAST=0
      CALL PRINTG(MAXDEPT,DEPARTN,NUMTEACH,
     C RCHOICE,NEWDEPT,MEANWT,VARWT,LABEL,TITLES,2,KLIST,
     C 1,SYMMAT,PRINTO,NSUBID,'AFTER INITIALIZATION',IEXPECT,ISTD,
     C ICON,STRUCTEQ,NOWCLOSE,PERGROUP,QUANTYPE,SQUAREIT,
     C FIXR,INFILE,HOWWIDE,BETWMULT,QUICKEND,NSIM,BOUNDVAL,BLABOUND,
     C HIWT,
     C  IGRATIO,NUMDIM,
     C CENTER,DANCHOR,DANCHOR2,MOVE2,ZSYMMAT,
     C STARTINC,BYINC,MAXINC,KEXP,NORMAL,MINVALG,
     C CENTERI,DANCHORI,DANCH2I,MOVE2I,ZSYMMATI,
     C STARTINI,BYINCI,MAXINCI,KEXPI,NORMALI,MINVALI,
     C RINCREM,MEASURE,EXTREME,DRADIUSG,DRADIUSI,
     C BYANGLE,BYSCALE,BYANGLEI,BYSCALEI,MINPICT,
     C PCTCENG1,PCTCENG2,PCTCENI1,PCTCENI2,ROWWT,COLWT,SIMO,2,
     C BBICOORD,HYPERG,LAST)

C     C CENTER,IGRATIO,DANCHOR2,MOVE2,DANCHOR,ZSYMMAT,MAXINC,
C     C BYINC,STARTINC,NUMDIM,RINCREM,MEASURE,EXTREME,HYPERG,DRADIUS,
C     C KEXP,NORMAL,NORMALI,MINVALI,MINVALG)

       END IF


C      DO WHILE (QUITIT .EQ. 0)

C      CALL DEBUGO(DEBUG(10))

      STARTTRY=3
       IF (STRUCTEQ .EQ. 1) THEN
      DO 6644 I=1,NUMTEACH
      IF ((NEWMAT(I,I) .EQ. 0) .AND. (NETWORK .EQ. 1)) THEN
      NEWMAT(I,I)= MAXCH
      END IF
06644  CONTINUE
      END IF

      SOLUT=1
C       KNEVAL=NEVAL

      DONEONE=0
      CALL SASCENT (CHANGEC,STOPVAL,LOWMEM,NUMTEACH,
     C MADECHNG,ISO,ISOLIST,NEWDEPT,MEANWT,VARWT,WPIK,
     C NEARVAL,DEPARTN,MAXDEPT,
     C RCHOICE,DMEMBERS,QUITIT,LASTCHNG,NSUBID,
     C TITLES,KCOUNT2,PRINTO,BOUNDVAL,PCTILE,
     C DIRECT,TWXPX,SYMMAT,STARTTRY,IEXPECT,ISTD,ICON,
     C ACTRSQR,NOWCLOSE,STRUCTEQ,QUICKEND,ROWWT,COLWT,QUANTYPE,
     C SQUAREIT,SOLUT,NETLEV,PERGROUP,INFILE,BLABOUND,MAXCH,MUTDYAD,
     C NONEG,MAXSEED,ATTACHI,HALFDYAD,DISSOLVE,HYPERG)
C       NEVAL=KNEVAL
       IF (COMPSIM .GT. 0) THEN
       DONEONE=1
       END IF
       IF (DEPARTN(MAXDEPT) .LT. 1) THEN
       MAXDEPT=MAXDEPT-1
       END IF
       IF (PRINTO(14) .EQ. 2) THEN
       GOTO 47477
       END IF
      IF (NUMTEACH .GT. 2) THEN
      LAST=1
      CALL PRINTG(MAXDEPT,DEPARTN,NUMTEACH,
     C RCHOICE,NEWDEPT,MEANWT,VARWT,LABEL,TITLES,2,KLIST,
     C 2,SYMMAT,PRINTO,NSUBID,'   AFTER ASCENT     ',IEXPECT,ISTD,
     C ICON,STRUCTEQ,NOWCLOSE,PERGROUP,QUANTYPE,SQUAREIT,
     C FIXR,INFILE,HOWWIDE,BETWMULT,QUICKEND,NSIM,BOUNDVAL,BLABOUND,
     C HIWT,
     C  IGRATIO,NUMDIM,
     C CENTER,DANCHOR,DANCHOR2,MOVE2,ZSYMMAT,
     C STARTINC,BYINC,MAXINC,KEXP,NORMAL,MINVALG,
     C CENTERI,DANCHORI,DANCH2I,MOVE2I,ZSYMMATI,
     C STARTINI,BYINCI,MAXINCI,KEXPI,NORMALI,MINVALI,
     C RINCREM,MEASURE,EXTREME,DRADIUSG,DRADIUSI,
     C BYANGLE,BYSCALE,BYANGLEI,BYSCALEI,MINPICT,
     C PCTCENG1,PCTCENG2,PCTCENI1,PCTCENI2,ROWWT,COLWT,SIMO,3,
     C CBICOORD,HYPERG,LAST)

C     C CENTER,IGRATIO,DANCHOR2,MOVE2,DANCHOR,ZSYMMAT,MAXINC,
C     C BYINC,STARTINC,NUMDIM,RINCREM,MEASURE,EXTREME,HYPERG,DRADIUS,
C     C KEXP,NORMAL,NORMALI,MINVALI,MINVALG)

       END IF

      IF ((NUMRES .GT. 1) .AND. (PRINTO(24) .EQ. 1)) THEN
      QI=0
      HIQ=0
      DO 6765 Q=1,MAXDEPT
      IF (DEPARTN(Q) .GT. 1) THEN
      QI=QI+1
      IF (DEPARTN(Q) .GT. HIQ) THEN
      HIQ=DEPARTN(Q)
      END IF
      END IF
06765  CONTINUE

      WRITE(6,4301) ' ***********************************************'
      WRITE(6,6764) QI,HIQ
      WRITE(6,4301) 'The sizes of the groups are:'
      WRITE(6,24545) (DEPARTN(J) , J=1,MAXDEPT)
      WRITE(6,4301) ' ***********************************************'
      END IF

      IF (PRINTO(10) .EQ. 1) THEN
      P2FILE=INFILE(1:6)  // '.dat' 
      OPEN(30,file=P2FILE)
      DO 2283 I=1,NUMTEACH
      WRITE(30,1717) (NEWMAT(I,J) , J=1,NUMTEACH)
C      WRITE(30,101) NEWDEPT(I) , (NEWMAT(I,J) , J=1,NUMTEACH)
02283 CONTINUE
      CLOSE(30)
      END IF


C      IF (PRINTO(10) .EQ. 1) THEN
C      OPEN(30,file='clus.outmat')
C      DO 22837 I=1,NUMTEACH
C      WRITE(30,101) NEWDEPT(I) , (NEWMAT(I,K) , K=1,NUMTEACH)
C22837 CONTINUE
C      CLOSE(30)
C      END IF

C      IF (PRINTO(10) .EQ. 1) THEN
C      OPEN(30,file=P2FILE)
C      DO 2293 I=1,NUMTEACH
C      DO 22931 J=1,NUMTEACH
C      WRITE(30,'(1X,I10)') NEWMAT(I,J)
C      WRITE(30,'(1X,I1)') NEWMAT(K,J)
C22931 CONTINUE
  
C02293 CONTINUE
C      CLOSE(30)
C      END IF

47477  IF (PRINTO(14) .GT. 0) THEN
C      DO 8161 PID=1,NUMTEACH
C       WRITE(210,251) PID,NSUBID(PID),NEWDEPT(PID)
C 8161   CONTINUE

      IF (SIMO .EQ. 0) THEN 
      OPEN(58,file=PFILE)

      DO 84166 PID=1,NUMTEACH
       XR1=PID
       XR2=NSUBID(PID)
       XR3=NEWDEPT(PID)
       XR4=NSIM
       XR5=3
       WRITE(58,19051) XR1,XR2,XR3,XR4,XR5
84166   CONTINUE
      PMADE=1
      DO WHILE (PMADE .EQ. 1)
      PMADE=0
      DO 91662 PID=1,PAIRS
      DO 91663 PID2=1,PAIRS
      IF (PAIRUP(PID,2) .EQ. PAIRUP(PID2,1)) THEN
      PAIRUP(PID,2)=PAIRUP(PID2,2)
      PMADE=1
      END IF
91663  CONTINUE
91662   CONTINUE
       END DO

      DO 81662 PID=1,PAIRS
       IF (CONVID(PAIRUP(PID,2)) .GT. 0) THEN
       IF (NEWDEPT(CONVID(PAIRUP(PID,2))) .GT. 0) THEN
       XR1=-NSUBID(PAIRUP(PID,2))
C       XR1=NSUBID(PAIRUP(PID,2))
C       XR2=NSUBID(PAIRUP(PID,1))
       XR2=SUBID(PAIRUP(PID,1))
       XR3=NEWDEPT(CONVID(PAIRUP(PID,2)))
       XR4=NSIM
       XR5=3
       WRITE(58,19051) XR1,XR2,XR3,XR4,XR5
C     -PAIRUP(PID,2),PAIRUP(PID,1),
C     C  NEWDEPT(CONVID(PAIRUP(PID,2))),NSIM,3
       END IF
        END IF
81662  CONTINUE
        CLOSE(58)
        END IF
        IF (PRINTO(14) .EQ. 2) THEN
         STOP
         END IF
         
         OPEN(27,file='place.sas')
        WRITE(27,4301) 'options linesize=80;'
        WRITE(27,4301) 'options pagesize=59;'

      WRITE(27,4301)
     C'TITLE1 ''Placement of actors in groups'';'
      WRITE(27,4301) 'Title2 '',TITLES(1),TITLES(2),TITLES(3),'';'
      WRITE(27,4301) 'data one;'
      WRITE(27,4301) 'infile '',PFILE,'' missover;'
      WRITE(27,4301) 
     C'input internid actid group;'
      WRITE(27,4301) 'proc freq;'
      WRITE(27,4301) 'tables group;'
      CLOSE(27)
      END IF
C      ADDING IN STOP HERE FOR BIG FILES
      IF (NUMTEACH .GT. 500) THEN 
      STOP
      END IF
            

      IF ( (KMATTYPE .EQ. 'm') .AND. ((PRINTO(38) .EQ. 1)
     C .OR. (PRINTO(39) .EQ. 1))) THEN
      PRINTO(25)=1
      END IF

      IF (PRINTO(25) .EQ. 1) THEN
      IF (SIMO .EQ. 1) THEN
      OPEN(39,file='holdname2')
      REWIND(39)
      WRITE(39,7760) 'sim',NSIM,'.slist'
      CLOSE(39)
      OPEN(39,file='holdname2')
      READ(39,7761) LISTFILE
      ELSE
      LISTFILE=INFILE(1:6) // '.olist'
      END IF


      OPEN(57,file=LISTFILE)
      DO 6789 PI=1,NUMTEACH
       IF (NEWDEPT(PI) .NE. 0) THEN
      WRITE(57,5101) NSUBID(PI) ,99999,NEWDEPT(PI)
       END IF
      DO 6790 PJ=1,NUMTEACH
      IF (NEWMAT(PI,PJ) .NE. 0) THEN
      WRITE(57,5101) NSUBID(PI),NSUBID(PJ),NEWMAT(PI,PJ)
      END IF
06790  CONTINUE
06789   CONTINUE
      CLOSE(57)
      IF ( (KMATTYPE .EQ. 'm') .AND. ((PRINTO(38) .EQ. 1)
     C .OR. (PRINTO(39) .EQ. 1))) THEN
      LINKFILE='inlist.list'
      SIXTEEN=16
      SIXTEEN=UNLINK(LINKFILE)
      STATUS=SYMLNK(LISTFILE,LINKFILE)
      END IF
      END IF

C       WRITE(219,7652) INFILE

      QVAL=-LASTCHNG

C      THIS IS THE BIG DO LOOP THAT ASKS IF WE SHOULD ACTUALL STOP
C
C           --------------------------------------------------
C

C      CALL HUBIZE(NEWDEPT,NUMTEACH,FINALM,STRUCTEQ)

      IF ((SIMO .EQ. 0) .AND. (PRINTO(6) .EQ. 1)) THEN 
        DO 8888 GR=1,MAXDEPT
         RDEPTN(GR)=DEPARTN(GR)
08888     CONTINUE
        TNUMT=NUMTEACH

       MBI=0
       FLAGI1=1
       CALL PROBS(MAXDEPT,NUMTEACH,DEPARTN,PAGB,
     C NEWDEPT,RCHOICE,FLAGI1,NUMTEACH,MAXDEPT,MBI)
       
      OPEN(98,file='grpprobs.dat')
      WANTPOUT=0
      IF (WANTPOUT .EQ. 1) THEN
      OPEN(99,file='grpprobs.out')
         WRITE(99,2102) (TITLES(A) , A=1,3)
         WRITE(99,2102) 'PROBABILITIES'

         RMAXDEPT=MAXDEPT

         WRITE(99,2107) 'GROUP', (ZG, ZG=1,MAXDEPT)
         WRITE(99,2107) 'GROUP SIZE', (DEPARTN(ZG2) , ZG2=1,MAXDEPT)
         WRITE(99,2104) 'PRIOR', (RDEPTN(ZG2)/TNUMT , 
     C   ZG2=1,MAXDEPT)
         WRITE(99,2101)
         WRITE(99,2104) 'CHANCE=' , 1/RMAXDEPT

         WRITE(99,2101)
         WRITE(99,2101) 'ACTOR' , 'GROUP', '  PROB'
         WRITE(99,4301) '----------------------------------------'
         WRITE(99,2101)
        END IF
        
         PO=0

        DO 848 GROUP=1,MAXDEPT
C         HDEPARTN(GROUP)=DEPARTN(GROUP)
         PROBGRP(GROUP)=1.000
         DO 858 PERS=1,DEPARTN(GROUP)
         PROBGRP(GROUP)=PROBGRP(GROUP)*
     C                  PAGB(ALLGROUP(GROUP,PERS),GROUP)
         PO=PO+1
         PORD(PO)= ALLGROUP(GROUP,PERS)
         IF (WANTPOUT .EQ. 1) THEN
         WRITE(99,2103) NSUBID(ALLGROUP(GROUP,PERS)), 
     C   GROUP ,
     C   (PAGB(ALLGROUP(GROUP,PERS),GR), 
     C   GR=1,MAXDEPT)
      
         END IF
c xxxx
          DO 05106 GRGR=1,MAXDEPT
          WRITE(98,21033) NSUBID(ALLGROUP(GROUP,PERS)), 
     C   GROUP , GRGR,
     C   (PAGB(ALLGROUP(GROUP,PERS),GRGR))
05106    CONTINUE
C
C         WRITE(98,5554) NSUBID(ALLGROUP(GROUP,PERS)), 
C     C   GROUP ,
C     C   (PAGB(ALLGROUP(GROUP,PERS),GR), 
C     C   GR=1,MAXDEPT)
  858  CONTINUE
  848  CONTINUE
         WRITE(99,2101)
         WRITE(99,4301) 'CUMULATIVE'
         WRITE(99,2103) 999999999,999999999,
     C   (PROBGRP(GR) , GR=1,MAXDEPT)
         WRITE(99,2101)
C       DO 1875 I=1,NUMTEACH
C        PNEWDEPT(I)=NEWDEPT(I)
C01875    CONTINUE

          CLOSE(98)
          CLOSE(99)
          END IF
C          PRINTO(6)
       
      IF ((PRINTO(6) .EQ. 1) .AND. (PRINTO(7) .EQ. 1) .AND. 
     C (SIMO .EQ. 0)) THEN 
      OPEN(99,file='actprobs.dat')
       DO 1876 PROBI=2,NUMTEACH
       DO 1877 PROBJ=1,(PROBI-1)
        PROBPER(PROBI,PROBJ)=0.000
        DO 1888 PROBGR=1,MAXDEPT
          PROBPER(PROBI,PROBJ)=PROBPER(PROBI,PROBJ)+PAGB(PROBJ,PROBGR)*
     C    PAGB(PROBI,PROBGR)
01888    CONTINUE
         PROBPER(PROBJ,PROBI)=PROBPER(PROBI,PROBJ)
         PROBPER(PROBJ,PROBJ)=1.0
         PROBPER(PROBI,PROBI)=1.0
         WRITE(99,951) NSUBID(PROBI),NEWDEPT(PROBI),
     C   NSUBID(PROBJ),NEWDEPT(PROBJ),PROBPER(PROBI,PROBJ)
C         WRITE(99,251) NSUBID(PROBI) 
01877    CONTINUE

01876    CONTINUE
         CLOSE(99)

         RMAXDEPT=MAXDEPT
       OPEN(99,file='actprobs.out')
         WRITE(99,2102) 
         WRITE(99,2102) 
         WRITE(99,2102) (TITLES(A) , A=1,3)
         WRITE(99,2102) 'PERSON PROBS'
         WRITE(99,2104) 'CHANCE=' , 1/RMAXDEPT
         WRITE(99,2101) 'PERSON I' 
         WRITE(99,2107) '       PERSON J', 
     C   (NSUBID(PORD(ZG)), ZG=1,NUMTEACH)
         WRITE(99,2107) '       GROUP ',
     C    (NEWDEPT(PORD(ZG2)) , ZG2=1,NUMTEACH)


        DO 2084 GROUP=1,MAXDEPT

         DO 2085 PERS=1,DEPARTN(GROUP)
               WRITE(99,2103) NSUBID(ALLGROUP(GROUP,PERS)), 
     C   GROUP ,
     C   (PROBPER(ALLGROUP(GROUP,PERS),PORD(GR)), 
     C   GR=1,NUMTEACH)
02085     CONTINUE
02084      CONTINUE
          CLOSE(99)
          END IF
C          PRINTO(7)=1

C      SUBROUTINE EVAL(MAXDEPT,DEPARTN,ALLGROUP,NEWMAT,NUMTEACH,
C     C RCHOICE,OLDDEPT,HUBERT,MEANWT,VARWT,PRINTT,
C     C FINAL,FSYMMAT,PRINTO,FCOMPACT,CHNGSIM,NEVAL,BASEVAL,
CN     C NBESTDEP)
C            CALL DEBUGO(DEBUG(36))
      
      IF (NEVAL .GE. 1) THEN
      OPEN(58,file='eval.dat')
      OPEN(50,file='eval.sas')

C      NUMRES=1
         KQMAX=MAXKLIQ
        UNO=1
         DUE=2
C       ON EXTERNAL ERROR CALL EXTERR (EXTPAR,EXTRES,EXTOP1,EXTOP2)
C       ON INTERNAL ERROR CALL INTERR (INTPAR,INTRES)
C       CALL CATCHEM (CPAR1)
      NUMRES=NUMRES+1
      CALL KEVAL(MAXDEPT,DEPARTN,NUMTEACH,
     C RCHOICE,NEWDEPT,MEANWT,VARWT,DUE,UNO,
     C SYMMAT,PRINTO,FCOMPACT,CHNGESIM,NEVAL,BASEVAL,
     C NBESTDEP,STRUCTEQ,NUMRES,TRYDEPT,QUANTYPE,TOPVAL,NEWGRPS,
     C PERGROUP,SQUAREIT,FIXR,HIWTEVAL,HYPERG,ROWWT,COLWT,
     C KQMAX,INFILE,SIMO)
C      IF (NUMRES .GT. 1) THEN
      

        WRITE(50,4301) 'options linesize=80;'
        WRITE(50,4301) 'options pagesize=59;'

      WRITE(50,4301) 
     C'TITLE1 ''Evaluation of Solution Through Simulated Data'';'
      WRITE(50,4301)
     C'TITLE2 ''Is this Solution Like other Good Solutions?'';'
      WRITE(50,4301) 'Title2 '',TITLES(1),TITLES(2),TITLES(3),'';'
      WRITE(50,4301) 'data one;'
      WRITE(50,4301) 'infile ''eval.dat'' missover;'
      WRITE(50,4301) 
     C'input (id pct chngcnt chngstd obfun increm hubert'
      WRITE(50,4301) ' hubdiag pearson g2 hubdiagx pearsonx g2x) '
      WRITE(50,4301) '(10.5);'
      WRITE(50,4301) 
     C 'indi='' '';'
      WRITE(50,4301)
     C'if pct=1.000 then indi=''F'';'

      WRITE(50,4301)
     C'label '
      WRITE(50,4301)
     C'hubert = ''Huberts Measure of compactness'''
      WRITE(50,4301)
     C'obfun = ''Value of your objective function'''
      WRITE(50,4301)
     C'chngstd=''Stdized simlrty with final soltion'''
      WRITE(50,4301)
     C'pct =''pct of changes made from final sltion'''
      WRITE(50,4301)
     C'chngcnt=''# in common with final'''
      WRITE(50,4301) 
     C'hubdiag=''sum of group compactness measures'''
      WRITE(50,4301) 
     C'pearson=''sum of pearson sqrd resids (group lev)'''
      WRITE(50,4301) 
     C'g2=''sum of LRT resids (group level)'''
      WRITE(50,4301) 
     C'hubdiagx=''sum of group compactness/Ng'''
      WRITE(50,4301) 'pearsonx=''sum of pearson diagonals'''
      WRITE(50,4301) 'g2x=''sum of LRT diagonals'';'
      WRITE(50,4301)
     C'proc means;'
      WRITE(50,4301)
     C'proc reg;'
      WRITE(50,4301)
     C'model obfun hubert hubdiag pearson g2 hubdiagx pearsonx'
      WRITE(50,4301) 'g2x=chngstd;'
      WRITE(50,4301)
     C'proc plot;'
      WRITE(50,4301)
     C'title3 ''* for generated, F for final'';'
      WRITE(50,4301)
     C'plot (obfun hubert hubdiag pearson g2 hubdiagx pearsonx g2x)*'
      WRITE(50,4301) '(chngstd)=indi;'
      WRITE(50,4301)
     C'plot obfun*hubert; '
      WRITE(50,4301)
     C'endsas;'
      CLOSE(58)
      CLOSE(50)


       WRITE(33,2109) 'EVALUATION COMPLETE.  OUTPUT IN eval.out'
       WRITE(33,2109) 'SAS CODE IN eval.sas'
       IF (PRINTO(24) .EQ. 1) THEN
       WRITE(6,2109) 'EVALUATION COMPLETE.  OUTPUT IN eval.out'
       WRITE(6,2109) 'SAS CODE IN eval.sas'
       END IF

       END IF
       
       SECSOL=0
       IF ((SECSOL .EQ. 1 ) .AND. ((COMPSIM .GT. 0) .OR. 
     C (NUMRES .GT. 1))) THEN

       WRITE(33,2109)
       WRITE(33,2109) 'SECOND SOLUTION'
       WRITE(33,2109)
       IF (PRINTO(24) .EQ. 1) THEN
       WRITE(6,2109)
       WRITE(6,2109) 'SECOND SOLUTION'
       WRITE(6,2109)
       END IF
       QUICKEND=0
       SOLUT=2
       IF (COMPSIM .GT. 0) THEN
        PCTILE=SPCTILE
        NEARVAL=SNEARVAL
C        NONEG=SNONEG
       DO 72441 OD=1,NUMTEACH
       TRYDEPT(OD)=OLDEPTS(OD)
72441   CONTINUE

       END IF
      IF (MAKEMISS .EQ. 1) THEN

       DO 20773 OD=1,NUMTEACH
       MDEPT(OD)=NEWDEPT(OD)
       DO 20774 PERS=1,NUMTEACH
       NEWMAT(OD,PERS)=INMAT(OD,PERS)
20774   CONTINUE
20773    CONTINUE

       CALL KMISS(NOWMISS,NUMTEACH,MSEED,TAKEOUT)

       DO 62624 OD=1,NUMTEACH
       IF (TAKEOUT(OD) .EQ. 1) THEN
       DO 62625 PERS=1,NUMTEACH
       NEWMAT(OD,PERS)=0
62625  CONTINUE
        END IF
62624     CONTINUE

C      CALL REMOVEO(INMAT,NUMTEACH,HITLIST,NUMHLIST,MDEPT,
C     C               NEWDEPT,USETRIAD,SUBID,NSUBID,KLIST,PAIRS,PAIRUP,
C     C   CONVID,TAGALONG,STRUCTEQ)

      NFIXR = FIXR !RTC
      CALL ARCHOICE(NUMTEACH,NEWMAT,RCHOICE,MAXCH,NFIXR,
     C FLAGR,MEANWT,VARWT)
      END IF   

      CALL ASSIGN2(NUMTEACH,TRYDEPT,MAXDEPT,
     C DEPARTN)

      CALL SASCENT (CHANGEC,STOPVAL,LOWMEM,NUMTEACH,
     C MADECHNG,ISO,ISOLIST,TRYDEPT,MEANWT,VARWT,WPIK,
     C NEARVAL,DEPARTN,MAXDEPT,
     C RCHOICE,DMEMBERS,QUITIT,LASTCHNG,NSUBID,
     C TITLES,KCOUNT2,PRINTO,BOUNDVAL,PCTILE,
     C DIRECT,TWXPX,SYMMAT,STARTTRY,IEXPECT,ISTD,ICON,
     C ACTRSQR,NOWCLOSE,STRUCTEQ,QUICKEND,ROWWT,COLWT,QUANTYPE,
     C SQUAREIT,SOLUT,NETLEV,PERGROUP,INFILE,BLABOUND,MAXCH,MUTDYAD,
     C NONEG,MAXSEED,ATTACHI,HALFDYAD,DISSOLVE,HYPERG)
C      CALL SASCENT (CHANGEC,STOPVAL,LOWMEM,NUMTEACH,
C     C MADECHNG,ISO,ISOLIST,TRYDEPT,MEANWT,VARWT,WPIK,
C     C NEARVAL,DEPARTN,MAXDEPT,
C     C RCHOICE,DMEMBERS,QUITIT,LASTCHNG,NSUBID,
C     C TITLES,KCOUNT2,PRINTO,BOUNDVAL,PCTILE,
C     C DIRECT,TWXPX,SYMMAT,STARTTRY,IEXPECT,ISTD,ICON,
C     C ACTRSQR,NOWCLOSE,STRUCTEQ,QUICKEND,ROWWT,COLWT,QUANTYPE,
C     C SQUAREIT,SOLUT,NETLEV,PERGROUP,INFILE,BLABOUND,MAXCH,MUTDYAD,
C     C NONEG,MAXSEED,ATTACHI,HALFDYAD,DISSOLVE,HYPERG)

       IF (DEPARTN(MAXDEPT) .LT. 1) THEN
       MAXDEPT=MAXDEPT-1
       END IF

       THINKING=0
       IF ((THINKING .EQ. 1) .AND. (MAKEMISS .EQ. 1)) THEN
       DO 24773 OD=1,NUMTEACH
       IF (TAKEOUT(OD) .EQ. 1) THEN
       DO 24774 PERS=1,NUMTEACH
       NEWMAT(OD,PERS)=INMAT(OD,PERS)
24774   CONTINUE
       END IF
24773    CONTINUE

      NFIXR = FIXR !RTC
      CALL ARCHOICE(NUMTEACH,NEWMAT,RCHOICE,MAXCH,NFIXR,
     C FLAGR,MEANWT,VARWT)

      CALL SASCENT (CHANGEC,STOPVAL,LOWMEM,NUMTEACH,
     C MADECHNG,ISO,ISOLIST,TRYDEPT,MEANWT,VARWT,WPIK,
     C NEARVAL,DEPARTN,MAXDEPT,
     C RCHOICE,DMEMBERS,QUITIT,LASTCHNG,NSUBID,
     C TITLES,KCOUNT2,PRINTO,BOUNDVAL,PCTILE,
     C DIRECT,TWXPX,SYMMAT,STARTTRY,IEXPECT,ISTD,ICON,
     C ACTRSQR,NOWCLOSE,STRUCTEQ,1,ROWWT,COLWT,QUANTYPE,
     C SQUAREIT,SOLUT,NETLEV,PERGROUP,INFILE,BLABOUND,MAXCH,MUTDYAD,
     C NONEG,MAXSEED,ATTACHI,HALFDYAD,DISSOLVE,HYPERG)

      END IF   

C     THINKING

      IF (PRINTO(6) .EQ. 1) THEN 
        DO 8188 GR=1,MAXDEPT
         RDEPTN(GR)=DEPARTN(GR)
08188     CONTINUE
        TNUMT=NUMTEACH

      OPEN(99,file='grpprobs.out')
      OPEN(98,file='grpprobs.dat')

       MBI=0
       FLAGI1=1
       CALL PROBS(MAXDEPT,NUMTEACH,DEPARTN,PAGB,
     C TRYDEPT,RCHOICE,FLAGI1,NUMTEACH,MAXDEPT,MBI)
       

         WRITE(99,2102) (TITLES(A) , A=1,3)
         WRITE(99,2102) 'PROBABILITIES'

         RMAXDEPT=MAXDEPT
         WRITE(99,2104) 'CHANCE=' , 1/RMAXDEPT
         WRITE(99,2107) 'GROUP', (ZG, ZG=1,MAXDEPT)
         WRITE(99,2107) 'GROUP SIZE', (DEPARTN(ZG2) , ZG2=1,MAXDEPT)
         WRITE(99,2104) 'PRIOR', (RDEPTN(ZG2)/TNUMT , 
     C   ZG2=1,MAXDEPT)
         WRITE(99,2101) 'ACTOR' , 'GROUP', '  PROB'
         PO=0
        DO 6848 GROUP=1,MAXDEPT
C         HDEPARTN(GROUP)=DEPARTN(GROUP)
         PROBGRP(GROUP)=1.000
         DO 6858 PERS=1,DEPARTN(GROUP)
         PROBGRP(GROUP)=PROBGRP(GROUP)*
     C                  PAGB(ALLGROUP(GROUP,PERS),GROUP)
         PO=PO+1
         PORD(PO)= ALLGROUP(GROUP,PERS)
         PFITDA(PO)=0
         PFITDB(PO)=0
         WRITE(99,2103) NSUBID(ALLGROUP(GROUP,PERS)), 
     C   GROUP ,
     C   (PAGB(ALLGROUP(GROUP,PERS),GR), 
     C   GR=1,MAXDEPT)
         WRITE(98,251) NSUBID(ALLGROUP(GROUP,PERS)), 
     C   GROUP ,
     C   (PAGB(ALLGROUP(GROUP,PERS),GR), 
     C   GR=1,MAXDEPT)
06858     CONTINUE
06848      CONTINUE
         WRITE(99,2101)
         WRITE(99,2101) 'TOTAL' , 'GROUP', '  PROB'
         WRITE(99,2103) 999999999,999999999,
     C   (PROBGRP(GR) , GR=1,MAXDEPT)
         WRITE(99,2101)
C       DO 1875 I=1,NUMTEACH
C        PNEWDEPT(I)=NEWDEPT(I)
C01875    CONTINUE

          CLOSE(98)
          CLOSE(99)
          END IF
C          PRINTO(6)
       
      IF ((PRINTO(6) .EQ. 1) .AND. (PRINTO(7) .EQ. 1)) THEN
      OPEN(99,file='perprobs.out')
      OPEN(98,file='perprobs.dat')
       TMISSDA=0         
       TMISSDB=0         
       DO 21876 PROBI=2,NUMTEACH
       DO 21877 PROBJ=1,(PROBI-1)
        PROBPER(PROBI,PROBJ)=0.000
        DO 21888 PROBGR=1,MAXDEPT
          PROBPER(PROBI,PROBJ)=PROBPER(PROBI,PROBJ)+PAGB(PROBJ,PROBGR)*
     C    PAGB(PROBI,PROBGR)
21888    CONTINUE
         IF (PROBPER(PROBI,PROBJ) .LT. .05) THEN
         PROBPER(PROBI,PROBJ) =.05
         END IF
         PROBPER(PROBJ,PROBI)=PROBPER(PROBI,PROBJ)
         PROBPER(PROBJ,PROBJ)=1.0
         PROBPER(PROBI,PROBI)=1.0
        
          MISSPROB=((PROBPER(PROBI,PROBJ)-HUBERT(PROBI,PROBJ))**2)/
     C                (PROBPER(PROBI,PROBJ))
         PFITDA(PROBI)=PFITDA(PROBI)+MISSPROB
         PFITDA(PROBJ)=PFITDA(PROBJ)+MISSPROB
         TMISSDA=TMISSDA+MISSPROB/(NUMTEACH*(NUMTEACH-1))
          MISSPROB=((PROBPER(PROBI,PROBJ)-RESULTM(PROBI,PROBJ))**2)/
     C                (PROBPER(PROBI,PROBJ))
         PFITDB(PROBI)=PFITDB(PROBI)+MISSPROB
         PFITDB(PROBJ)=PFITDB(PROBJ)+MISSPROB
         TMISSDB=TMISSDB+MISSPROB/(NUMTEACH*(NUMTEACH-1))
         WRITE(98,251) NSUBID(PROBI),TRYDEPT(PROBI),
     C   NSUBID(PROBJ),TRYDEPT(PROBJ),PROBPER(PROBI,PROBJ)
21877    CONTINUE

21876    CONTINUE
         CLOSE(98)
         CLOSE(99)
C         TMISSDA=TMISSDA/NUMTEACH
         RMAXDEPT=MAXDEPT
         OPEN(99,file='actprobs.out')
         WRITE(99,2102) 
         WRITE(99,2102) 
         WRITE(99,2102) (TITLES(A) , A=1,3)
         WRITE(99,2102) 'PERSON PROBS'
         WRITE(99,2104) 'CHANCE=' , 1/RMAXDEPT
         WRITE(99,2101) 'PERSON I' 
         WRITE(99,2107) '       PERSON J', 
     C   (NSUBID(PORD(ZG)), ZG=1,NUMTEACH)
         WRITE(99,2107) '       GROUP ',
     C    (TRYDEPT(PORD(ZG2)) , ZG2=1,NUMTEACH)

      
        DO 2984 GROUP=1,MAXDEPT

         DO 2985 PERS=1,DEPARTN(GROUP)
     
         WRITE(99,2103) NSUBID(ALLGROUP(GROUP,PERS)), 
     C   GROUP ,
     C   (PROBPER(ALLGROUP(GROUP,PERS),PORD(GR)), 
     C   GR=1,NUMTEACH)
02985     CONTINUE
02984      CONTINUE
          CLOSE(99)
          END IF
C          PRINTO(7)=1


      IF (NUMTEACH .GT. 2) THEN
       LAST=1
      CALL PRINTG(MAXDEPT,DEPARTN,NUMTEACH,
     C RCHOICE,TRYDEPT,MEANWT,VARWT,LABEL,TITLES,2,KLIST,
     C 2,SYMMAT,PRINTO,NSUBID,'   AFTER ASCENT      ',IEXPECT,ISTD,
     C ICON,STRUCTEQ,NOWCLOSE,PERGROUP,QUANTYPE,SQUAREIT,
     C FIXR,INFILE,HOWWIDE,BETWMULT,QUICKEND,NSIM,BOUNDVAL,BLABOUND,
     C HIWT,
     C  IGRATIO,NUMDIM,
     C CENTER,DANCHOR,DANCHOR2,MOVE2,ZSYMMAT,
     C STARTINC,BYINC,MAXINC,KEXP,NORMAL,MINVALG,
     C CENTERI,DANCHORI,DANCH2I,MOVE2I,ZSYMMATI,
     C STARTINI,BYINCI,MAXINCI,KEXPI,NORMALI,MINVALI,
     C RINCREM,MEASURE,EXTREME,DRADIUSG,DRADIUSI,
     C BYANGLE,BYSCALE,BYANGLEI,BYSCALEI,MINPICT,
     C PCTCENG1,PCTCENG2,PCTCENI1,PCTCENI2,ROWWT,COLWT,SIMO,
     C 4,DBICOORD,HYPERG,LAST)

C     C CENTER,IGRATIO,DANCHOR2,MOVE2,DANCHOR,ZSYMMAT,MAXINC,
C     C BYINC,STARTINC,NUMDIM,RINCREM,MEASURE,EXTREME,HYPERG,DRADIUS,
C     C KEXP,NORMAL,NORMALI,MINVALI,MINVALG)

       END IF
       IF (MAKEMISS .EQ. 1) THEN
       DO 94773 OD=1,NUMTEACH
       IF (TAKEOUT(OD) .EQ. 1) THEN
       DO 94774 PERS=1,NUMTEACH
       NEWMAT(OD,PERS)=INMAT(OD,PERS)
94774   CONTINUE
       END IF
94773    CONTINUE
      WRITE(6,*) 'p1'
      CALL ARCHOICE(NUMTEACH,NEWMAT,RCHOICE,MAXCH,NFIXR,
     C FLAGR,MEANWT,VARWT)
      DISTFILE=INFILE // '.xdist'
      CALL KSTRESS(STRESSB,DBICOORD,NORMALI,NUMTEACH,HIWT,
     C MINVALI,KEXPI,STRESS2B,FITI,ISTRESS,STRESS3B,MSTRESS2,
     C MSTRESS3,ABICOORD,DISTFILE,PRINTO,NEWDEPT,NSUBID,ODDSDA)
      END IF

      CALL DIFFDIST(ABICOORD,DBICOORD,NUMTEACH,NUMDIM,ADSTRESS,TAD)
      CALL DIFFDIST(CBICOORD,DBICOORD,NUMTEACH,NUMDIM,CDSTRESS,TBD)
      CALL HUBIZE(NEWDEPT,NUMTEACH,HUBERT,STRUCTEQ)
      WRITE(6,*) 'p2'
      DISTFILE=INFILE // '.ydist'
      CALL KSTRESS(STRESSB,DBICOORD,NORMALI,NUMTEACH,HIWT,
     C MINVALI,KEXPI,STRESS2B,FITI,ISTRESS,STRESS3B,ISTRESS2,
     C ISTRESS3,CBICOORD,DISTFILE,PRINTO,NEWDEPT,NSUBID,ODDSDB1)

       CALL KFIT(NUMTEACH,FIT,ODDSDB2)
      WRITE(6,*) 'p3'
      PFILE=INFILE(1:6) // '.lifit'
       OPEN(52,file=PFILE)
c             OUTFILE=INFILE(1:6) // '.clusters'
c      OPEN(33,file=OUTFILE)

C       IF (PRINTO(27) .EQ. 1) THEN
C       qqfile=INFILE(1:6) // '.COMPDAT'
C       OPEN(538,file=qqfile)
C       CALL MOVEEND(538)
C       CLOSE(538)
C       END IF
       DO 22144 PID=1,NUMTEACH
       WRITE(52,66251) INFILE,
     C NSIM,4,PID,NSUBID(PID),FIT(PID),ADSTRESS(PID),
     C CDSTRESS(PID) ,RCHOICE(PID),MEANWT(PID),VARWT(PID),
     C PFITDA(PID),PFITDB(PID),FITI(PID),ISTRESS(PID),
     C MSTRESS2(PID),MSTRESS3(PID),
     C ISTRESS2(PID),ISTRESS3(PID),TAKEOUT(PID)
22144   CONTINUE
       CLOSE(52)
      CALL HUBVAR(HUBERT,RESULTM,NUMTEACH,HUBSIM,STDHS,ALLCON,
     C HUBM1,HUBSTD1,TOTCOUNT)

      WRITE(33,'(20g20.5)') HUBSIM/2,ALLCON/2,STDHS,NSIM,4,TAD,TBD,TMISSDA,
     C TMISSDB,STRESSB,STRESS2B,STRESS3B,ODDSDB1,ODDSDB2,ODDSDA
      WRITE(19,'(20g20.5)') HUBSIM/2,ALLCON/2,STDHS,NSIM,4,TAD,TBD,TMISSDA,
     C TMISSDB,STRESSB,STRESS2B,STRESS3B,ODDSDB1,ODDSDB2,ODDSDA

      PFILE=INFILE(1:6) // '.2plac'
      OPEN(52,file=PFILE)

      DO 81667 PID=1,NUMTEACH
       WRITE(52,251) PID,NSUBID(PID),TRYDEPT(PID),NSIM,4
81667 CONTINUE

       ELSE
       WRITE(33,2109) 'END OUTPUT: ONLY ONE SOLUTION REQUESTED'
       END IF
04545   CONTINUE

      CLOSE(52)
      IF (PRINTO(24) .EQ. 1) THEN
      HIQ=0
      QI=0
      DO 6763 Q=1,MAXDEPT
      IF (DEPARTN(Q) .GT. 1) THEN
      QI=QI+1
      IF (DEPARTN(Q) .GT. HIQ) THEN
      HIQ=DEPARTN(Q)
      END IF
      END IF
06763  CONTINUE

      WRITE(6,4301) ' ***********************************************'
      WRITE(6,6764) QI,HIQ
      WRITE(6,4301) ' The sizes of the groups are:'
      WRITE(6,24545) (DEPARTN(J) , J=1,MAXDEPT)
      WRITE(6,4301) ' Main output in ',OUTFILE
      WRITE(6,4301) ' Additional output: '
      IF (PRINTO(6) .EQ. 1) THEN
      WRITE(6,4301) ' ***********************************************'
      WRITE(6,4301) ' Actor by group probabilities are in ' 
      WRITE(6,4301) ' grpprobs.out.  Data for analysis in grpprobs.dat'
      END IF

      IF (PRINTO(7) .EQ. 1) THEN
      WRITE(6,4301) ' ***********************************************'
      WRITE(6,4301) ' Actor by actor probabilities are in ' 
      WRITE(6,4301) ' actprobs.out.  Data for analysis in actprobs.dat'
      END IF
      IF (PRINTO(9) .EQ. 1) THEN
      WRITE(6,4301) ' ***********************************************'
      WRITE(6,4301) ' Data for logit analysis in logit.dat'
      END IF
      IF (PRINTO(10) .EQ. 1) THEN
      WRITE(6,4301) ' ***********************************************'
      WRITE(6,4301) ' Final solution in matrix form is in'
      WRITE(6,4301) ' clus.outmat'
      END IF

      IF (PRINTO(11) .EQ. 1) THEN
      WRITE(6,4301) ' ***********************************************'
      WRITE(6,4301) ' Output on boundary spanners'
      WRITE(6,4301) ' (all actors to all groups) is in ',BFILE
      END IF

      IF (PRINTO(12) .EQ. 1) THEN
      WRITE(6,4301) ' ***********************************************'
      WRITE(6,4301) ' Output on boundary spanners'
      WRITE(6,4301) ' (only boundary spanning actors) is in ',BFILE2
      END IF

      IF (PRINTO(13) .EQ. 1) THEN
      WRITE(6,4301) ' ***********************************************'
      WRITE(6,4301) ' Raw data for Multidimensional scaling'
      WRITE(6,4301) ' is in group.corr .  Systat commands to read'
      WRITE(6,4301) ' the data are in MDSREAD.CMD .  Systat commands'
      WRITE(6,4301) ' to Scale the Data are in MDSSCALE.CMD'
      END IF

      IF (PRINTO(26) .EQ. 1) THEN
      WRITE(6,4301) ' -----------------------------------------------'
      WRITE(6,4301) ' | Output --Blau''s Measures of density         |'
      WRITE(6,4301) ' |                                             |'
      IF (PRINTO(11) .EQ. 1) THEN
      WRITE(6,4301) ' | ******************************************* |'
      WRITE(6,4301) ' | Output on boundary spanners                 |'
      WRITE(6,4301) ' | (all actors to all groups) is in ',BFILEB
      END IF

      IF (PRINTO(12) .EQ. 1) THEN
      WRITE(6,4301) ' | ******************************************* |'
      WRITE(6,4301) ' | Output on boundary spanners                 |'
      WRITE(6,4301) ' | (only boundary spanning actors) is in ',
     C                  BFILE2B
      END IF

      IF (PRINTO(13) .EQ. 1) THEN
      WRITE(6,4301) ' | ******************************************* |'
      WRITE(6,4301) ' | Raw data for Multidimensional scaling       |'
      WRITE(6,4301) ' | based on Blau''s Measure of Density          |'
      WRITE(6,4301) ' | is in group.bcorr . Systat commands to read |'
      WRITE(6,4301) ' | the data are in MDSBREAD.CMD .  Systat      |'
      WRITE(6,4301) ' | commands to Scale the Data are in           |'
      WRITE(6,4301) ' | MDSSCALE.CMD                                |'

      WRITE(6,4301) ' | ******************************************* |'
      WRITE(6,4301) ' | Raw data for Multidimensional scaling       |'
      WRITE(6,4301) ' | based on Pct in group connections           |'
      WRITE(6,4301) ' | is in group.ccorr . Systat commands to read |'
      WRITE(6,4301) ' | the data are in MDSCREAD.CMD .  Systat      |'
      WRITE(6,4301) ' | commands to Scale the Data are in           |'
      WRITE(6,4301) ' | MDSSCALE.CMD                                |'
      END IF
      WRITE(6,4301) ' |                                             |'
      WRITE(6,4301) ' -----------------------------------------------'
      WRITE(6,4301)
      END IF

      IF (PRINTO(14) .EQ. 1) THEN
      WRITE(6,4301) ' ***********************************************'
      WRITE(6,4301) ' each actor''s internal id, external id and'
      WRITE(6,4301) ' group placement  is in ', PFILE
      WRITE(6,4301) ' data can be read with place.sas .'
      END IF

      IF (NEVAL .GT. 0) THEN
      WRITE(6,4301) ' ***********************************************'
      WRITE(6,4301) ' Data on evaluation of final solution in'
      WRITE(6,4301) ' eval.dat .  Data can be read with eval.sas'
      END IF

      END IF
      WRITE(33,4301)
      WRITE(33,4301)'             OUTPUT        '
      WRITE(33,4301)

      WRITE(33,4301) ' ***********************************************'
      WRITE(33,4301) ' This file contains the main output.'
      WRITE(33,4301) ' It is called: ',OUTFILE
      WRITE(33,4301) ' Additional output: '
      IF (PRINTO(6) .EQ. 1) THEN
      WRITE(33,4301) ' ***********************************************'
      WRITE(33,4301) ' Actor by group probabilities are in ' 
      WRITE(33,4301) ' grpprobs.out.  Data for analysis in grpprobs.dat'
      END IF

      IF (PRINTO(7) .EQ. 1) THEN
      WRITE(33,4301) ' ***********************************************'
      WRITE(33,4301) ' Actor by actor probabilities are in ' 
      WRITE(33,4301) ' actprobs.out.  Data for analysis in actprobs.dat'
      END IF
      IF (PRINTO(9) .EQ. 1) THEN
      WRITE(33,4301) ' ***********************************************'
      WRITE(33,4301) ' Data for logit analysis in logit.dat'
      END IF
      IF (PRINTO(10) .EQ. 1) THEN
      WRITE(33,4301) ' ***********************************************'
      WRITE(33,4301) ' Final solution in matrix form is in'
      WRITE(33,4301) ' clus.outmat'
      END IF
      IF (PRINTO(11) .EQ. 1) THEN
      WRITE(33,4301) ' ***********************************************'
      WRITE(33,4301) ' Output on boundary spanners'
      WRITE(33,4301) ' (all actors to all groups) is in ',BFILE
      END IF

      IF (PRINTO(12) .EQ. 1) THEN
      WRITE(33,4301) ' ***********************************************'
      WRITE(33,4301) ' Output on boundary spanners'
      WRITE(33,4301) ' (only boundary spanning actors) is in ',BFILE2
      END IF

      IF (PRINTO(13) .EQ. 1) THEN
      WRITE(33,4301) ' ***********************************************'
      WRITE(33,4301) ' Raw data for Multidimensional scaling'
      WRITE(33,4301) ' is in group.corr .  Systat commands to read'
      WRITE(33,4301) ' the data are in MDSREAD.CMD .  Systat commands'
      WRITE(33,4301) ' to Scale the Data are in MDSSCALE.CMD'
      END IF

      IF (PRINTO(26) .EQ. 1) THEN
      WRITE(33,4301) ' -----------------------------------------------'
      WRITE(33,4301) ' | Output --Blau''s Measures of density         |'
      WRITE(33,4301) ' |                                             |'
      IF (PRINTO(11) .EQ. 1) THEN
      WRITE(33,4301) ' | ******************************************* |'
      WRITE(33,4301) ' | Output on boundary spanners                 |'
      WRITE(33,4301) ' | (all actors to all groups) is in ',BFILEB
      END IF

      IF (PRINTO(12) .EQ. 1) THEN
      WRITE(33,4301) ' | ******************************************* |'
      WRITE(33,4301) ' | Output on boundary spanners                 |'
      WRITE(33,4301) ' | (only boundary spanning actors) is in ',
     C                  BFILE2B
      END IF

      IF (PRINTO(13) .EQ. 1) THEN
      WRITE(33,4301) '| ******************************************* |'
      WRITE(33,4301) '| Raw data for Multidimensional scaling       |'
      WRITE(33,4301) '| based on Blau''s Measure of Density          |'
      WRITE(33,4301) '| is in group.bcorr . Systat commands to read |'
      WRITE(33,4301) '| the data are in MDSBREAD.CMD .  Systat      |'
      WRITE(33,4301) '| commands to Scale the Data are in           |'
      WRITE(33,4301) '| MDSSCALE.CMD                                |'
      WRITE(33,4301) '| ******************************************* |'
      WRITE(33,4301) '| Raw data for Multidimensional scaling       |'
      WRITE(33,4301) '| based on Pct in group connections           |'
      WRITE(33,4301) '| is in group.ccorr . Systat commands to read |'
      WRITE(33,4301) '| the data are in MDSCREAD.CMD .  Systat      |'
      WRITE(33,4301) '| commands to Scale the Data are in           |'
      WRITE(33,4301) '| MDSSCALE.CMD                                |'
      END IF
      WRITE(33,4301) '|                                             |'
      WRITE(33,4301) '-----------------------------------------------'
      WRITE(33,4301)
      END IF

      IF (PRINTO(14) .EQ. 1) THEN
      WRITE(33,4301) '***********************************************'
      WRITE(33,4301) 'each actor''s internal id, external id and'
      WRITE(33,4301) 'group placement  is in ', PFILE
      WRITE(33,4301) 'data can be read with place.sas .'
      END IF
       DO 9334 I=15,19
      IF (PRINTO(I) .EQ. 1) THEN
      WRITE(33,4301) '***********************************************'
      WRITE(33,4301) APRINT(I)
      END IF
09334  CONTINUE
      IF (NEVAL .GT. 0) THEN
      WRITE(33,4301) '***********************************************'
      WRITE(33,4301) 'Data on evaluation of final solution in'
      WRITE(33,4301) 'eval.dat .  Data can be read with eval.sas'
      END IF

      IF (PRINTO(22) .EQ. 1) THEN
      WRITE(33,4301)
      DO 3320 PO=1,9
      WRITE(33,3339) FANCY(PO)
03320  CONTINUE

      WRITE(33,4301)
      DO 3341 PO=1,NPO
      WRITE(33,3340)  PO,PRINTO(PO),APRINT(PO)
03341  CONTINUE
      WRITE(33,4301)
      WRITE(33,4301)
      END IF
C      PRINTO (22)
      WRITE(33,3114)
      CALL MYSTOP



C      DO 283 I=1,NUMTEACH
C     WRITE(586,101) NBESTDEP(I) , (NEWMAT(I,J) , J=1,NUMTEACH)
C  283  CONTINUE

C
C
C       VARIOUS AND SUNDRY FORMATS
C      

19051   FORMAT (20I10)
06764  FORMAT(' KliqueFinder indentified ',I4, ' groups.  The largest',
     C ' group contains ',I4,' members.',/)
07761   FORMAT(A12)
07760   FORMAT(A6,I2.2,A4)
  191 FORMAT(/,' SIMILARITY BETWEEN THE START AND END GROUPS:   ACTUAL 
     C  POSS  STANDARDIZED',/,43X,I7,3X,I7,3X,F10.5)
07654  FORMAT(A16,F20.1$)
07652  FORMAT(A16$)
76543  FORMAT(F20.1$)
04301  FORMAT(20(A))
04302  FORMAT(20(A),F5.0)
4303   FORMAT('which is larger than',I4,'.  Please limit')
4304   FORMAT(A30,I5)
09101   FORMAT(251(I4.4,1X))
05101   FORMAT(3(I10))
24545   FORMAT(20(I5))
24575   FORMAT(20(F10.4))
24845   FORMAT(20(F5.0))
24546   FORMAT(12F5.0,I5,4F5.0,3I5,2F5.0,3I5,6F5.0,2I5,16F5.0)
04334   FORMAT(' ACTOR ',I4,' HAS CHOSEN ITSELF WITH VALUE',I4,
     C ', ZEROING OUT THIS DIAGONAL ELEMENT OF THE MATRIX')
 3338   FORMAT(210('*'))
 3339   FORMAT('*',10X,A200,2X,'*')
 3340   FORMAT('*',2X,I2,2X,I2,2X,A200,2X,'*')


 3331  FORMAT(//////////,140(10X,A200,/))
 3335  FORMAT(A200,/,A80)
34348  FORMAT(/////////////////////)
 3337   FORMAT(10(A100,/))
 3114  FORMAT('---------------------------------------------------------
     C-----------------')
 2103 FORMAT(I6,I6,200(F4.2))  
21033 FORMAT(I6,1X,I6,1X,I6,1X,10(F10.8))  

 2107 FORMAT(A15,251(I3))  
 2105 FORMAT(A15,251(I3))  
 2104 FORMAT(A15,251(F4.2))  
 2102 FORMAT(10(A30)) 
 2101 FORMAT(251(A8)) 
 2109 FORMAT(A)
21091 FORMAT(I1,',',I3,',',I3,',N,NM')

   78 FORMAT(//,'STARTING WITH ',A20,/,'NUMBER OF TRIADS= ',F5.0,//)  
   79 FORMAT(//,'STARTING WITH ',A20,/,'NUMBER OF TRIADS= ',I5,//)  
   77 FORMAT(3(A20,1X))
    7 FORMAT('RESULTING MATRIX OF WITHIN GROUP CONNECTIONS',/,
     C8X,A20,' ORDER')   
    9 FORMAT(/,'THE CURRENT COMPACTNESS IS',F10.5)
C  191 FORMAT(/,'SIMILARITY BETWEEN THE START AND END GROUPS:   ACTUAL 
C     C  POSS  STANDARDIZED',/,42X,I9,I10,F15.5)
  301 FORMAT(I2,20(F10.5))
C
  144 FORMAT(2F10.5)
66251 FORMAT(A16,1X,4I15,3F15.5,I15,10F15.5,I15)
88251 FORMAT(20(F10.1))
  251 FORMAT(20(G10.5))
05554 FORMAT(2I5,1X,200(F4.2))
  951 FORMAT(4I5,F10.5)
 1251 FORMAT(1X,6I10,20(G10.5))
 8251 FORMAT(I10,5F10.5,5I10)
  502 FORMAT(A12,1X)
  504 FORMAT(20(F10.5))
  511 FORMAT(251(A9,1X))
07511 FORMAT(251('AC',I3.3,','))
  132 FORMAT('DEPART    MEMBERS')
  133 FORMAT(I4,4X,251(I4,4X))
  134 FORMAT('(',I4,')',4X,251('(',F6.3,')'))
  137 FORMAT(A6,4X,251('(',F6.3,')'))
  136 FORMAT('HAVE MOVED ',I4,' FROM ',I4,' TO ',I4)
C
  198 FORMAT('TOTHGV1=',F10.4,'TOTHGV2=',F10.4,'TOTHGV3=',F10.4,
     C       'TOTHGV4=',F10.4)
  187 FORMAT(A12,F5.0)
   99 FORMAT(I2,251(F1.0))

  101 FORMAT(I2,251(I1))
 1717 FORMAT(251(1X,I1))
 4101 FORMAT(I2)
  102 FORMAT(I2,251(I1))
  109 FORMAT(I2,I3,251(I1))
  103 FORMAT(2I4)
  107 FORMAT(I1,1X,I5,1X,I1,1X,I1,1X,I4,1X,400(F10.5,1X))
  112 FORMAT(I5,1X,I5,1X,I7,1X,I7,3X,F8.7,4(1X,F10.5))
  110 FORMAT('DEPART=',F5.0,' DEPT. TOT=',F10.2,' CUM TOT =',F10.2,
     C       ' ITER=',I5)
  111 FORMAT(I10,1X,I10,1X,F10.5)
  113 FORMAT(/15X,A16/'DEPT   SIZE MAXCONN TOTCONN    PCONN     HMEAN  
     C HSTD      ZSCORE     PVALUE')
  114 FORMAT('--------------------------------------------------------
     C-----------------------TOTAL')
  120 FORMAT('G=',F7.2,' IG=',F7.2,' DEP=',F7.2,' G3=',F7.2)
  135 FORMAT('JPERSON=',I3,' DEPART=',I3)
  140 FORMAT(A16)
  160 FORMAT(I3,1X,I3,1X,F10.5,1X,F10.5)
  203 FORMAT(I3,1X,251(I3,1X))
01077 FORMAT(A20,F20.5)
01078 FORMAT(A20,I20)
      END
