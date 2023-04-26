PROGRAM CountWords(INPUT, OUTPUT);

CONST
  MaxLength = 255;
  EngLet = ['a' .. 'z'];
  RusLet = ['а' .. 'п'] + ['р' .. 'я'] + ['ё'];
  Letters = EngLet + RusLet + ['-'];
  EqualKey = 0;
  RootBigger = 2;
  RootSmaller = 1;

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
{Result 0, 1, 2 если лексикографический порядок F1 =, <, > чем F2       
соответственно. Фактические параметры, соответствующие F1 и F2,
должны быть различными}
VAR
  Ch1, Ch2: CHAR;
  Index: INTEGER;
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
      THEN {Ch1 < Ch2 или F1 короче F2}
        Result := 1
      ELSE
        IF (Ch1 > Ch2)
        THEN {Ch1 > Ch2 или F2 короче F1}
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
VAR
  Flag: INTEGER;
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
  ELSE
    BEGIN
      Flag := Lexico(Ptr^.Key, Word);
      IF Flag = RootBigger
      THEN
        Insert(Ptr^.Left, Word)
      ELSE
        Insert(Ptr^.Right, Word)
    END
END; {Insert}

FUNCTION SearchWordInTree(Ptr: Tree; Word: StrType): BOOLEAN;
VAR
  Flag: INTEGER;
BEGIN {SearchPointer}
  SearchWordInTree := FALSE;
  IF Ptr <> NIL
  THEN
    BEGIN
      Flag := Lexico(Ptr^.Key, Word);
      IF Flag = EqualKey
      THEN
        BEGIN
          Ptr^.Count := Ptr^.Count + 1;
          SearchWordInTree := TRUE
        END
      ELSE
        IF Flag = RootBigger
        THEN
          SearchWordInTree := SearchWordInTree(Ptr^.Left, Word)
        ELSE
          SearchWordInTree := SearchWordInTree(Ptr^.Right, Word)
    END
END; {SearchPointer}


PROCEDURE OutputTree(VAR FOut: TEXT; Ptr: Tree);
VAR
  Index: INTEGER;
BEGIN {OutputTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      OutputTree(FOut, Ptr^.Left);
      FOR Index := 1 TO Ptr^.Key.Length
      DO
        WRITE(FOut, Ptr^.Key.Val[Index]);
      WRITELN(FOut, ' ', Ptr^.Count);
      OutputTree(FOut, Ptr^.Right)
    END
END; {OutputTree}

             
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
    'А': ToLower := 'а';
    'Б': ToLower := 'б';
    'В': ToLower := 'в';
    'Г': ToLower := 'г';
    'Д': ToLower := 'д';
    'Е': ToLower := 'е';
    'Ё': ToLower := 'ё';
    'Ж': ToLower := 'ж';
    'З': ToLower := 'з';
    'И': ToLower := 'и';
    'Й': ToLower := 'й';
    'К': ToLower := 'к';
    'Л': ToLower := 'л';
    'М': ToLower := 'м';
    'Н': ToLower := 'н';
    'О': ToLower := 'о';
    'П': ToLower := 'п';
    'Р': ToLower := 'р';
    'С': ToLower := 'с';
    'Т': ToLower := 'т';
    'У': ToLower := 'у';
    'Ф': ToLower := 'ф';
    'Х': ToLower := 'х';
    'Ц': ToLower := 'ц';
    'Ч': ToLower := 'ч';
    'Ш': ToLower := 'ш';
    'Щ': ToLower := 'щ';
    'Ъ': ToLower := 'ъ';
    'Ы': ToLower := 'ы';
    'Ь': ToLower := 'ь';
    'Э': ToLower := 'э';
    'Ю': ToLower := 'ю';
    'Я': ToLower := 'я'
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
                Word.Length := Index;
                IF NOT SearchWordInTree(Root, Word)
                THEN
                  Insert(Root, Word);
                Index := 0
              END
        END;
      IF Index <> 0
      THEN
        BEGIN
          Word.Length := Index;
          IF NOT SearchWordInTree(Root, Word)
          THEN
            Insert(Root, Word);
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
