
      SUBROUTINE GGPER(QSEED,K,IPER)
      INCLUDE 'PARAM.H'
      INTEGER K,IPER(MAXKLIQ),SORTFLAG,IER,I
      DOUBLE PRECISION QSEED
      REAL ORDER(MAXKLIQ),LOW,HIGH
  
      LOW=0
      HIGH=1

      IF (K .GT.  0) THEN
      DO 2 I=1,K
       ORDER(I)=GENUNF(LOW,HIGH)
00002  CONTINUE
      SORTFLAG=1
      CALL SPSORT(ORDER,K,IPER,SORTFLAG,IER)     
      END IF
      RETURN
      END
