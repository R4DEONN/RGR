PROGRAM CountWords(INPUT, OUTPUT);
USES
  BinaryWordTree;

CONST
  MaxLength = 100;
  EngLet = ['a' .. 'z'];
  RusLet = ['�' .. '�'] + ['�' .. '�'] + ['�'];
  BigLetters = ['A' .. 'Z'] + ['a' .. 'z'] + ['�' .. '�'] + ['�'];
  SmallLetters = EngLet + RusLet + ['-'];
             
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
  ELSE
    ToLower := Ch
  END
END; {ToLower}           
             
VAR
  Root: Tree;
  Ch: CHAR;
  FIn, FOut: TEXT;
  Word: StrType;
  Index: 0 .. MaxLength;

BEGIN {CountWords}
  ASSIGN(FIn, 'in.txt');
  ASSIGN(FOut, 'out.txt');
  RESET(FIn);
  REWRITE(FOut);
  Index := 0;
  Root := NIL;
  
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      WHILE (NOT EOLN(FIn)) AND (NOT EOF(FIn))
      DO
        BEGIN
          READ(FIn, Ch);
          IF Ch IN BigLetters
          THEN 
            Ch := ToLower(Ch);
          IF (Ch IN SmallLetters) AND (Index <= MaxLength)
          THEN
            BEGIN
              Index := Index + 1;
              Word[Index] := Ch
            END
          ELSE
            IF Index <> 0
            THEN
              BEGIN
                Root := Insert(Root, Word, Index);
                Index := 0
              END
        END;
      IF Index <> 0
      THEN
        BEGIN
          Root := Insert(Root, Word, Index);
          Index := 0
        END;
      IF NOT EOF(FIn)
      THEN
        READLN(FIn)
    END;
  OutputTree(FOut, Root);
  CLOSE(FIn);
  CLOSE(FOut)
END. {CountWords}
