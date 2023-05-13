UNIT WordHandler3;

INTERFACE

USES
  TypeUtils3;

FUNCTION Lexico(Word1, Word2: StrType; Len1, Len2: INTEGER): INTEGER; {ѕровер€ет эквивалентность слов}  

FUNCTION LenWithOutEnding(Word: WordType): INTEGER; {¬озвращает длину слова без окончани€}

PROCEDURE PrintKey(VAR FOut: TEXT; VAR Words: WordsArray);

IMPLEMENTATION

FUNCTION Lexico(Word1, Word2: StrType; Len1, Len2: INTEGER): INTEGER;
{Result 0, 1, 2 если лексикографический пор€док F1 =, <, > чем F2       
соответственно. ‘актические параметры, соответствующие F1 и F2,   
должны быть различными}

VAR
  Ch1, Ch2: CHAR;
  Index: INTEGER;
BEGIN {Lexico}
  Index := 1;
  Result := 0;
  WHILE ((Index <> Len1 + 1) AND (Index <> Len2 + 1)) AND (Result = 0)
  DO
    BEGIN
      Ch1 := Word1[Index];
      Ch2 := Word2[Index];
      Index := Index + 1;
      IF (Ch1 < Ch2)
      THEN {Ch1 < Ch2 или F1 короче F2}
        Result := 1
      ELSE
        IF (Ch1 > Ch2)
        THEN {Ch1 > Ch2 или F2 короче F1}
          Result := 2
    END; {WHILE}
  IF Result = 0
  THEN
    IF Index <> Len1 + 1
    THEN
      Result := 2
    ELSE
      IF Index <> Len2 + 1
      THEN
        Result := 1
END; {Lexico}

FUNCTION CheckEnding(VAR Ending: WordType; Word: WordType; EndingLen, EndingCount: INTEGER): INTEGER;
{¬озвращает TRUE, если нашлось окончание, иначе FALSE}
VAR
  I, J: INTEGER;
BEGIN {CheckEnding}
  J := 0;
  Result := 1;
  FOR I := EndingLen - 1 DOWNTO 0
  DO
    BEGIN
      J := J + 1;
      Ending.Val[J] := Word.Val[Word.Len - I]
    END;
  Ending.Len := J;
  WHILE (I <= EndingCount) AND (Result <> 0) AND (EndingLen = 4)
  DO
    BEGIN
      I := I + 1;
      Result := Lexico(Ending.Val, QuadroLetEnds[I], EndingLen, EndingLen)
    END;
  WHILE (I <= EndingCount) AND (Result <> 0) AND (EndingLen = 3)
  DO
    BEGIN
      I := I + 1;
      Result := Lexico(Ending.Val, TripleLetEnds[I], EndingLen, EndingLen)
    END;
  WHILE (I <= EndingCount) AND (Result <> 0) AND (EndingLen = 2)
  DO
    BEGIN
      I := I + 1;
      Result := Lexico(Ending.Val, DoubleLetEnds[I], EndingLen, EndingLen)
    END;
  WHILE (I <= EndingCount) AND (Result <> 0)
  DO
    BEGIN
      I := I + 1;
      Result := Lexico(Ending.Val, SingleLetEnds[I], EndingLen, EndingLen)
    END
END;  {CheckEnding}

FUNCTION LenWithOutEnding(Word: WordType): INTEGER;
{¬озвращает длину слова без окончани€}
VAR
  IsEnding: INTEGER;
  Ending: WordType;
BEGIN {CheckEndings}
  IsEnding := 1;
  IF (Word.Len > 4) AND (IsEnding <> 0)
  THEN
    IsEnding := CheckEnding(Ending, Word, 4, QuadroLetEndsCount);
  IF (Word.Len > 3) AND (IsEnding <> 0)
  THEN
    IsEnding := CheckEnding(Ending, Word, 3, TripleLetEndsCount);
  IF (Word.Len > 2) AND (IsEnding <> 0)
  THEN
    IsEnding := CheckEnding(Ending, Word, 2, DoubleLetEndsCount);
  IF (Word.Len > 1) AND (IsEnding <> 0)
  THEN
    IsEnding := CheckEnding(Ending, Word, 1, SingleLetEndsCount);
  IF IsEnding = 0
  THEN
    Result := Word.Len - Ending.Len
  ELSE
    Result := Word.Len;
END;  {CheckEndings}

PROCEDURE PrintKey(VAR FOut: TEXT; VAR Words: WordsArray);
VAR
  I, J: INTEGER;
BEGIN
  FOR I := 1 TO Words.Number
  DO
    BEGIN
      FOR J := 1 TO Words.WordArray[I].Len
      DO
        WRITE(FOut, Words.WordArray[I].Val[J]);
      IF I <> Words.Number
      THEN
        WRITE(FOut, ',')
    END;
  WRITELN(FOut, ': ', Words.Count)
END;

BEGIN
END.
