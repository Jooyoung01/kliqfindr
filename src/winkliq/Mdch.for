CSTART OF AS 91

 

      SUBROUTINE MDCH(CHI,DF,PVAL,IER)
      REAL CHI,PVAL,BOUND,RDF
      INTEGER DF,IER,ONE
      RDF=DF
      ONE=1
      IER=0
      IF ((CHI .GT. 0) .AND. (DF .GT. 0)) THEN
C      CALL CDFCHI(ONE,PVAL,CHI,RDF,IER,BOUND)
      PVAL=0
      ELSE
      PVAL=1
      END IF
      PVAL=999999
      RETURN
      END
