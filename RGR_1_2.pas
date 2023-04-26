PROGRAM CountWords(INPUT, OUTPUT);
USES
  BinaryWordTree;

CONST
  MaxLength = 255;
  EngLet = ['a' .. 'z'];
  RusLet = ['�' .. '�'] + ['�' .. '�'] + ['�'];
  Letters = EngLet + RusLet + ['-'];
             
FUNCTION ToLower(Ch: CHAR): CHAR;
BEGIN {ToLower}
  CASE Ch OF
    'A': ToLower := 'a';
    'B': ToLower := 'b';
    'C': ToLower := 'c';
    'D': ToLower := 'd';
    'E': ToLower := 'e';
    'F': ToLower := 'f';
    'G': ToLower := 'g';
    'H': ToLower := 'h';
    'I': ToLower := 'i';
    'J': ToLower := 'j';
    'K': ToLower := 'k';
    'L': ToLower := 'l';
    'M': ToLower := 'm';
    'N': ToLower := 'n';
    'O': ToLower := 'o';
    'P': ToLower := 'p';
    'Q': ToLower := 'q';
    'R': ToLower := 'r';
    'S': ToLower := 's';
    'T': ToLower := 't';
    'U': ToLower := 'u';
    'V': ToLower := 'v';
    'W': ToLower := 'w';
    'X': ToLower := 'x';
    'Y': ToLower := 'y';
    'Z': ToLower := 'z';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�';
    '�': ToLower := '�'
  END
END; {ToLower}           
             
VAR
  Root: Tree;
  Ch: CHAR;
  FIn, FOut: TEXT;
  Word: StrType;
  Index: 0 .. MaxLength;

BEGIN {CountWords}
  Index := 0;
  Root := NIL;
  
  WHILE NOT EOF
  DO
    BEGIN
      WHILE (NOT EOLN) AND (NOT EOF)
      DO
        BEGIN
          READ(Ch);
          Ch := ToLower(Ch);
          IF Ch IN Letters
          THEN
            BEGIN
              Index := Index + 1;
              Word.Val[Index] := Ch
            END
          ELSE
            IF Index <> 0
            THEN
              BEGIN
                Word.Length := Index;
                IF NOT SearchWordInTree(Root, Word)
                THEN
                  Root := Insert(Root, Word);
                Index := 0
              END
        END;
      IF Index <> 0
      THEN
        BEGIN
          Word.Length := Index;
          IF NOT SearchWordInTree(Root, Word)
          THEN
            Root := Insert(Root, Word);
          Index := 0
        END;
      IF NOT EOF
      THEN
        READLN
    END;
  OutputTree(Root)
END. {CountWords}
