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
  I := 0;
  READ(FIn, Ch);
  WHILE (NOT EOLN(FIn)) AND (NOT EOF(FIn)) AND (Ch <> ' ')
  DO
    BEGIN
      I := I + 1;
      Word.Val[I] := Ch;
      READ(FIn, Ch)
    END;
  Word.Len := I;
  READ(FIn, Word.Count);
  Word.LenWOEnd := LenWithOutEnding(Word);
  InsertWord(Word);
  READLN(FIn)
END;

PROCEDURE OutputList(VAR FOut: TEXT);
BEGIN
  OutputTree(FOut);
END;

BEGIN {FileFormatter}
END.  {FileFormatter}
