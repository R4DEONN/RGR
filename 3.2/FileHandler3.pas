UNIT FileHandler3;

INTERFACE

USES
  TypeUtils3;

PROCEDURE ReadStr(VAR FIn: TEXT);

PROCEDURE OutputList(VAR FOut: TEXT);

IMPLEMENTATION

USES
  BinaryWordTree3,
  WordHandler3;

PROCEDURE ReadStr(VAR FIn: TEXT);
VAR
  I: INTEGER;
  Word: WordType;
  Ch: CHAR;
BEGIN
  Word.Val := '';
  I := 0;
  READ(FIn, Ch);
  WHILE (NOT EOLN(FIn)) AND (NOT EOF(FIn)) AND (Ch <> ' ')
  DO
    BEGIN
      I := I + 1;
      INSERT(Ch, Word.Val, I);
      READ(FIn, Ch)
    END;
  Word.Len := LENGTH(Word.Val);
  READ(FIn, Word.Count);
  InsertWord(Word);
  READLN(FIn)
END;

PROCEDURE OutputList(VAR FOut: TEXT);
BEGIN
  OutputTree(FOut);
END;

BEGIN {FileFormatter}
END.  {FileFormatter}
