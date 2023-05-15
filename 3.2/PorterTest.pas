PROGRAM Test(INPUT, OUTPUT);
USES
  TypeUtils3,
  PorterStemmer;
  
VAR
  Word: WordType;
  I: INTEGER;
  BaseLength: INTEGER;
  Ch: CHAR;
  
BEGIN
  I := 0;
  READ(Ch);
  WHILE (NOT EOLN) AND (NOT EOF) AND (Ch <> ' ')
  DO
    BEGIN
      I := I + 1;
      INSERT(Ch, Word.Val, I);;
      READ(Ch)
    END;
  Word.Len := LENGTH(Word.Val);
  WRITE(Word.Val, ' ', Word.Len);
  WHILE NOT EOF
  DO
    BEGIN
      READ(Word.Val);
      WRITELN(Word.Val);
      Word.Len := LENGTH(Word.Val);
      BaseLength := BaseLen(Word);
      FOR I := 1 TO BaseLength
      DO
        WRITE(Word.Val[I]);
      READLN;
      WRITELN
    END    
END.
