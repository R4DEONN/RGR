PROGRAM CountWords(INPUT, OUTPUT);
USES
  FileHandler2;

VAR
  FileName: STRING;
  FIn, FOut: TEXT;

BEGIN {CountWords}
  WRITE('������� �������� �������� �����: ');
  READLN(FileName);
  ASSIGN(FIn, FileName);
  WRITE('������� �������� ��������� �����: ');
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
