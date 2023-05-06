UNIT FileHandler;

INTERFACE

USES
  TypeUtils;
  
FUNCTION ToLower(Ch: CHAR): CHAR; 

PROCEDURE ReadStr(VAR FIn: TEXT);

PROCEDURE OutputList(VAR FOut: TEXT);

IMPLEMENTATION

USES
  BinaryWordTree;

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
    'À': Result := 'à';
    'Á': Result := 'á';
    'Â': Result := 'â';
    'Ã': Result := 'ã';
    'Ä': Result := 'ä';
    'Å': Result := 'å';
    '¨': Result := '¸';
    'Æ': Result := 'æ';
    'Ç': Result := 'ç';
    'È': Result := 'è';
    'É': Result := 'é';
    'Ê': Result := 'ê';
    'Ë': Result := 'ë';
    'Ì': Result := 'ì';
    'Í': Result := 'í';
    'Î': Result := 'î';
    'Ï': Result := 'ï';
    'Ð': Result := 'ð';
    'Ñ': Result := 'ñ';
    'Ò': Result := 'ò';
    'Ó': Result := 'ó';
    'Ô': Result := 'ô';
    'Õ': Result := 'õ';
    'Ö': Result := 'ö';
    '×': Result := '÷';
    'Ø': Result := 'ø';
    'Ù': Result := 'ù';
    'Ú': Result := 'ú';
    'Û': Result := 'û';
    'Ü': Result := 'ü';
    'Ý': Result := 'ý';
    'Þ': Result := 'þ';
    'ß': Result := 'ÿ'
  ELSE
    Result := Ch
  END
END; {Result}  

PROCEDURE ReadStr(VAR FIn: TEXT);
VAR
  I: INTEGER;
  Word: StrType;
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
          Word[I] := Ch
        END
      ELSE
        IF I <> 0
        THEN
          BEGIN
            InsertWord(Word, I);
            I := 0
          END
    END;
  IF I <> 0
  THEN
    BEGIN
      InsertWord(Word, I);
      I := 0
    END;
END;  {ReadWord}

PROCEDURE OutputList(VAR FOut: TEXT);
VAR
  Index: INTEGER;
BEGIN {OutputTree}
  OutputTree(FOut)
END; {OutputTree}

BEGIN {WordHandler}
END.  {WordHandler}
