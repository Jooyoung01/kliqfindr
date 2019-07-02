
      SUBROUTINE GETMEAN(NEWDEPT,NUMTEACH,GROUPMAT,MAXDEPT,
     C DEPARTN,WANTSS,SS,WSS,ROWWT,COLWT)
      INCLUDE 'PARAM.H'

      INTEGER NEWDEPT(MAXKLIQ),NUMTEACH,I,J,MAXDEPT,
     C DEPARTN(MAXKLIQ),TN,WANTSS,G
      REAL GROUPMAT(MAXKLIQ,MAXKLIQ),SS(MAXKLIQ,MAXKLIQ),TREAL,TDENOM,
     C WSS,ROWWT,COLWT,WT,WDENOM
       REAL ZCOMPMAT(MAXKLIQ,MAXKLIQ)
       INTEGER HUBERT(MAXKLIQ,MAXKLIQ),RESULTM(MAXKLIQ,MAXKLIQ),
     C ALLGROUP(MAXKLIQ,MAXKLIQ),NEWMAT(MAXKLIQ,MAXKLIQ)
       REAL BLAUC(MAXKLIQ,MAXKLIQ),DIFF(MAXKLIQ,MAXKLIQ)
       COMMON ZCOMPMAT,ALLGROUP,HUBERT,RESULTM,NEWMAT,
     C BLAUC,DIFF

C       COMMON ZCOMPMAT,ALLGROUP,HUBERT,RESULTM,NEWMAT


      
      DO 4 I=1,MAXDEPT
       DO 5 J=1,NUMTEACH
      GROUPMAT(I,J)=0.000
       SS(I,J)=0.000
00005  CONTINUE
00004  CONTINUE
      
      DO 06 I=1,NUMTEACH
        TDENOM=DEPARTN(NEWDEPT(I))
       DO 07 J=1,NUMTEACH
        TREAL=NEWMAT(I,J)
        GROUPMAT(NEWDEPT(I),J)=GROUPMAT(NEWDEPT(I),J)+TREAL/TDENOM
00007    CONTINUE
00006     CONTINUE

       IF (WANTSS .EQ. 1) THEN
       WSS=0
       WDENOM=ROWWT+COLWT
       DO 08 I=1,NUMTEACH
       G=NEWDEPT(I)
       DO 09 J=1,NUMTEACH
        TREAL=NEWMAT(I,J)
        IF (NEWDEPT(J) .EQ. G) THEN
          WT=ROWWT
         ELSE
         WT=COLWT
         END IF
         WT=WT/WDENOM    
       SS(G,J)=SS(G,J)+WT*(TREAL-GROUPMAT(G,J))**2
       WSS=WSS+WT*(TREAL-GROUPMAT(G,J))**2
00009    CONTINUE
00008     CONTINUE


       END IF
        RETURN
        END
