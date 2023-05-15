UNIT WordHandler3;

INTERFACE

USES
  TypeUtils3,
  PorterStemmer;

FUNCTION Lexico(Word1, Word2: WordType): INTEGER; {ѕровер€ет эквивалентность слов}  

PROCEDURE PrintKey(VAR FOut: TEXT; VAR Words: WordsArray);

IMPLEMENTATION

FUNCTION Lexico(Word1, Word2: WordType): INTEGER;
{Result 0, 1, 2 если лексикографический пор€док F1 =, <, > чем F2       
соответственно. ‘актические параметры, соответствующие F1 и F2,   
должны быть различными}
VAR
  BaseLen1, BaseLen2, I: INTEGER;
  BaseWord1, BaseWord2: STRING;
BEGIN {Lexico}
  BaseWord1 := '';
  BaseWord2 := '';
  BaseLen1 := BaseLen(Word1);
  BaseLen2 := BaseLen(Word2);
  FOR I := 1 TO BaseLen1
  DO
    INSERT(Word1.Val[I], BaseWord1, I);
  FOR I := 1 TO BaseLen2
  DO
    INSERT(Word2.Val[I], BaseWord2, I);
  IF BaseWord1 < BaseWord2
  THEN
    Result := 1
  ELSE
    IF BaseWord1 > BaseWord2
    THEN
      Result := 2
    ELSE
      Result := 0
END; {Lexico}

PROCEDURE PrintKey(VAR FOut: TEXT; VAR Words: WordsArray);
VAR
  I: INTEGER;
BEGIN
  FOR I := 1 TO Words.Number
  DO
    BEGIN
      WRITE(FOut, Words.WordArray[I].Val);
      IF I <> Words.Number
      THEN
        WRITE(FOut, ',')
    END;
  WRITELN(FOut, ': ', Words.Count)
END;

BEGIN
END.
