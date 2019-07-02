
C      CALL ASSIGN(NUMTEACH,NEWDEPT,MAXDEPT,ALLGROUP
C     C,DEPARTN,RCHOICE,ALLGROUR,MEANWT,VARWT,ALLGROUM,ALLGROUV)

C        CALL ASSIGN(NUMTEACH,NEWDEPT,MAXDEPT,ALLGROUP
C     C  ,DEPARTN,RCHOICE,ALLGROUR,MEANWT,VARWT,ALLGROUM,ALLGROUV)

C        CALL ASSIGN(NUMTEACH,NEWDEPT,MAXDEPT,ALLGROUP
C     C  ,DEPARTN,RCHOICE,ALLGROUR,MEANWT,VARWT,ALLGROUM,ALLGROUV,
C     C  NEWMAT,I,THISMEM)
C      CALL ASSIGN(NUMTEACH,NEWDEPT,MAXDEPT,
C     C RCHOICE,MEANWT,VARWT,
C     C 1,2)

      SUBROUTINE ASSIGN(SUBJECTS,KAFFIL,MAXGROUP,
     C COUNTGR,INCHOICE,MEANW,VARW,
     C P1,P2)
      INCLUDE 'PARAM.H'
c      CALL ASSIGN(NUMTEACH,NEWDEPT,MAXDEPT,
c     C DEPARTN,RCHOICE,MEANWT,VARWT,
c     C 1,2)

C
      INTEGER SUBJECTS,KAFFIL(MAXKLIQ),MAXGROUP,
     C        COUNTGR(MAXKLIQ),INCHOICE(MAXKLIQ)
      INTEGER C,IG,ADEPART,TSUBJECT,P1,P2
      REAL MEANW(MAXKLIQ),VARW(MAXKLIQ)
       INTEGER HUBERT(MAXKLIQ,MAXKLIQ),RESULTM(MAXKLIQ,MAXKLIQ),
     C ASSIGNG(MAXKLIQ,MAXKLIQ),NEWMAT(MAXKLIQ,MAXKLIQ)
       REAL BLAUC(MAXKLIQ,MAXKLIQ),DIFF(MAXKLIQ,MAXKLIQ),
     C ZCOMPMAT(MAXKLIQ,MAXKLIQ)
       COMMON ZCOMPMAT,ASSIGNG,HUBERT,RESULTM,NEWMAT,
     C BLAUC,DIFF

C           ASSIGNV(ADEPART,COUNTGR(ADEPART))=VARW(IG)
C   
C      ASSIGN PEOPLE TO DEPARTMENTS ACCORDING TO THEIR INPUT DATA
C
C         NUMTEACH = TOTAL NUMBER OF TEACHERS
C         DEPART IS BASED ON THE INPUT DATA
C         ADEPART IS A TEMPOARARY NUMBER FOR THE DEPARTMENT
C         MAXDEPT IF THE MAXIMUM NUMBER OF DEPARTMENTS
C         DEPARTN IS AN ARRAY OF THE DEPARTMENTAL SIZES
C         ALLGROUP IS AN ARRAY OF DEPARTMENTS BY PEOPLE IN 
C            THE DEPARTMENTS (AHH FOR A PASCAL POINTER)
C
C
C        CALL CHECKVAL(INMAT,SUBJECTS,P1,P2,'BEGIN ASSIGN')

       DO 20 C=1,SUBJECTS
       COUNTGR(C)=0
   20  CONTINUE

       DO 23 IG=1,SUBJECTS
           ADEPART=KAFFIL(IG)
           IF (MAXGROUP .LT. ADEPART) THEN 
             MAXGROUP=ADEPART
           END IF
           IF ((ADEPART .GE. 1) .AND. (ADEPART .LT. MAXKLIQ)) THEN
           COUNTGR(ADEPART)=COUNTGR(ADEPART) + 1
           ASSIGNG(ADEPART,COUNTGR(ADEPART))=IG
           END IF
C           WRITE(17,117) IG,KAFFIL(IG),MAXGROUP,COUNTGR(ADEPART)
   23   CONTINUE
  117 FORMAT('PERSON=',F4.0,' DEPT=',F4.0,' MAXD=',F4.0,' DC=',F4.0)
  777 FORMAT('PERSON=',I3,' DEPART=',I3)
C
      RETURN
      END
