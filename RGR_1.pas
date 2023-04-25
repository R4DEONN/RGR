PROGRAM CountWords(INPUT, OUTPUT);

CONST
  MaxLength = 255;
  EngLet = ['a' .. 'z'];
  RusLet = ['�' .. '�'] + ['�' .. '�'] + ['�'];
  Letters = EngLet + RusLet;

TYPE
  StrType = RECORD
              Val: ARRAY [1 .. MaxLength] OF CHAR;
              Length: INTEGER
            END;
  Tree = ^NodeType;
  NodeType = RECORD
               Key: StrType;
               Count: INTEGER;
               Left, Right: Tree
             END;
             
FUNCTION Lexico(Word1, Word2: StrType): INTEGER;
{Result 0, 1, 2 ���� ������������������ ������� F1 =, <, > ��� F2       
��������������. ����������� ���������, ��������������� F1 � F2,
������ ���� ����������}
VAR
  Ch1, Ch2: CHAR;
  Index{, Result}: INTEGER;
BEGIN {Lexico}
  Index := 1;
  Result := 0;
  WHILE ((Index <> Word1.Length + 1) AND (Index <> Word2.Length + 1)) AND (Result = 0)
  DO
    BEGIN
      Ch1 := Word1.Val[Index];
      Ch2 := Word2.Val[Index];
      Index := Index + 1;
      IF (Ch1 < Ch2)
      THEN {Ch1 < Ch2 ��� F1 ������ F2}
        Result := 1
      ELSE
        IF (Ch1 > Ch2)
        THEN {Ch1 > Ch2 ��� F2 ������ F1}
          Result := 2
    END; {WHILE}
  IF Result = 0
  THEN
    IF Index <> Word1.Length + 1
    THEN
      Result := 2
    ELSE
      IF Index <> Word2.Length + 1
      THEN
        Result := 1;
  Lexico := Result
END; {Lexico}             
             
PROCEDURE Insert(VAR Ptr: Tree; Word: StrType);
BEGIN {Insert}
  IF Ptr = NIL
  THEN
    BEGIN
      NEW(Ptr);
      Ptr^.Key := Word;
      Ptr^.Count := 1;
      Ptr^.Left := NIL;
      Ptr^.Right := NIL
    END
  //TODO Lexico
END; {Insert}

FUNCTION SearchPointer(Ptr: Tree; Word: StrType): Tree;
BEGIN {SearchPointer}
  SearchPointer := NIL
END; {SearchPointer}
             
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
                //TODO Search
                Word.Length := Index;
                Insert(Root, Word);
                Index := 0
              END
        END;
      IF Index <> 0
      THEN
        BEGIN
          Insert(Root, Word);
          Index := 0
        END;
      IF NOT EOF(FIn)
      THEN
        READLN(FIn)
    END;
  //TODO Output to FOut
  CLOSE(FIn);
  CLOSE(FOut)                  
END. {CountWords}
