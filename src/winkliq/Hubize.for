
      SUBROUTINE HUBIZE(GROUPS,N,MATRIX,STRUCTEQ)
      INCLUDE 'PARAM.H'
      INTEGER GROUPS(MAXKLIQ),N,MATRIX(MAXKLIQ,MAXKLIQ),HUB1,HUB2,
     C STRUCTEQ
      DO 25 HUB1=1,N
       DO 27 HUB2=1,N
        IF ((GROUPS(HUB1) .EQ. GROUPS(HUB2)) .AND. (HUB1 .NE.
     C      HUB2) .AND. (GROUPS(HUB1) .NE. 0)) THEN
          MATRIX(HUB1,HUB2)=1
        ELSE
          MATRIX(HUB1,HUB2)=0
        END IF
   27 CONTINUE
      IF (STRUCTEQ .EQ. 1) THEN
       MATRIX(HUB1,HUB1)=1
      END IF
   25 CONTINUE
      RETURN 
      END
