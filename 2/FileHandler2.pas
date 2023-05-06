UNIT FileHandler2;

INTERFACE

USES
  TypeUtils2;
  
FUNCTION ToLower(Ch: CHAR): CHAR; 

PROCEDURE ReadStr(VAR FIn: TEXT);

PROCEDURE OutputList(VAR FOut: TEXT);

IMPLEMENTATION

USES
  BinaryWordTree2_1;

FUNCTION ToLower(Ch: CHAR): CHAR;
BEGIN {ToLower}
  CASE Ch OF
    'A': Result := 'a';
    'B': Result := 'b';
    'C': Result := 'c';
    'D': Result := 'd';
    'E': Result := 'e';
    'F': Result := 'f';
    'G': Result := 'g';
    'H': Result := 'h';
    'I': Result := 'i';
    'J': Result := 'j';
    'K': Result := 'k';
    'L': Result := 'l';
    'M': Result := 'm';
    'N': Result := 'n';
    'O': Result := 'o';
    'P': Result := 'p';
    'Q': Result := 'q';
    'R': Result := 'r';
    'S': Result := 's';
    'T': Result := 't';
    'U': Result := 'u';
    'V': Result := 'v';
    'W': Result := 'w';
    'X': Result := 'x';
    'Y': Result := 'y';
    'Z': Result := 'z';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�';
    '�': Result := '�'
  ELSE
    Result := Ch
  END
END; {Result}  

PROCEDURE ReadStr(VAR FIn: TEXT);
VAR
  I: INTEGER;
  Word: WordType;
  Ch: CHAR;
BEGIN {ReadWord}
  I := 0;
  WHILE (NOT EOLN(FIn)) AND (NOT EOF(FIn))
  DO
    BEGIN   
      READ(FIn, Ch);
      IF Ch IN BigLetters
      THEN 
        Ch := ToLower(Ch);
      IF (Ch IN SmallLetters) AND (I < MaxLen) AND ((Ch <> '-') OR ((NOT EOLN(FIn)) AND (I <> 0)))
      THEN
        BEGIN
          I := I + 1;
          Word.Val[I] := Ch
        END
      ELSE
        IF I <> 0
        THEN
          BEGIN
            Word.Len := I;
            Word.Count := 1;
            InsertWord(Word);
            Word.Len := 0;
            Word.Count := 0;
            I := 0
          END
    END;
  IF I <> 0
  THEN
    BEGIN
      Word.Len := I;
      Word.Count := 1;
      InsertWord(Word);
      Word.Len := 0;
      Word.Count := 0;
      I := 0
    END;
END;  {ReadWord}

PROCEDURE OutputList(VAR FOut: TEXT);
BEGIN {OutputTree}
  OutputTree(FOut)
END; {OutputTree}

BEGIN {WordHandler}
END.  {WordHandler}
