PROGRAM CountWords(INPUT, OUTPUT);
USES
  FileHandler2;

VAR
  FileName: STRING;
  FIn, FOut: TEXT;

BEGIN {CountWords}
  WRITE('¬ведите название входного файла: ');
  READLN(FileName);
  ASSIGN(FIn, FileName);
  WRITE('¬ведите название выходного файла: ');
  READLN(FileName);
  ASSIGN(FOut, FileName);
  RESET(FIn);
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      ReadStr(FIn);
      IF NOT EOF(FIn)
      THEN
        READLN(FIn)
    END;
  REWRITE(FOut);
  OutputList(FOut)
END. {CountWords}
