      INTEGER FUNCTION SYMLNK(OLD,NEW)
      CHARACTER*12 OLD,NEW
      CHARACTER*36 COMMAND
      SYMLNK = 0
      COMMAND(1:5) = 'COPY '
      COMMAND(6:17) = OLD
      COMMAND(18:18) = ' '
      COMMAND(19:30) = NEW
      COMMAND(31:31) = CHAR(0)
      CALL SYSTEM(COMMAND)
      RETURN
      END
