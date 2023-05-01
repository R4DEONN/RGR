PROGRAM CountWords(INPUT, OUTPUT);
USES
  BinaryWordTree2;

CONST
  EngLet = ['a' .. 'z'];
  RusLet = ['�' .. '�'] + ['�' .. '�'] + ['�'];
  BigLetters = ['A' .. 'Z'] + ['a' .. 'z'] + ['�' .. '�'] + ['�'];
  SmallLetters = EngLet + RusLet + ['-'];
             
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
             
VAR
  Word: WordType;
  Root: Tree;
  Ch: CHAR;
  FOut: TEXT;
  Index: 0 .. MaxLen;

BEGIN {CountWords}
  ASSIGN(FOut, 'out.txt');
  REWRITE(FOut);
  Index := 0;
  Root := NIL;
  WHILE NOT EOF
  DO
    BEGIN
      WHILE (NOT EOLN) AND (NOT EOF)
      DO
        BEGIN
          READ(Ch);
          IF Ch IN BigLetters
          THEN 
            Ch := ToLower(Ch);
          IF (Ch IN SmallLetters) AND (Index < MaxLen) AND ((Ch <> '-') OR ((NOT EOLN) AND (Index <> 0)))
          THEN
            BEGIN
              Index := Index + 1;
              Word.Val[Index] := Ch
            END
          ELSE
            IF Index <> 0
            THEN
              BEGIN
                Word.Len := Index;
                Word.Count := 1;                               
                Root := Insert(Root, Word);
                Word.Len := 0;
                Word.Count := 0;
                IF Root^.Height >= 15
                THEN
                  BEGIN
                    RESET(FOut);
                    Root := OutputTree(FOut, Root)
                  END;
                Index := 0
              END
        END;
      IF Index <> 0
      THEN
        BEGIN
          Word.Len := Index;
          Word.Count := 1;                               
          Root := Insert(Root, Word);
          Word.Len := 0;
          Word.Count := 0;
          IF Root^.Height >= 15
          THEN
            BEGIN
              RESET(FOut);
              Root := OutputTree(FOut, Root)
            END;
          Index := 0
        END;
      IF NOT EOF
      THEN
        READLN
    END;
  RESET(FOut);
  Root := OutputTree(FOut, Root)
END. {CountWords}