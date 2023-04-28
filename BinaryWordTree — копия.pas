UNIT BinaryWordTree;

INTERFACE

TYPE
  StrType = RECORD
              Val: ARRAY [1 .. 255] OF CHAR;
              Length: INTEGER
            END;
  Tree = ^NodeType;
  NodeType = RECORD
               Key: StrType;
               Count, Height: INTEGER;
               Left, Right: Tree
             END;
               
FUNCTION SearchWordInTree(Ptr: Tree; Word: StrType): BOOLEAN; 
{Определяет есть слово в дереве или нет, если есть, то увеличивает у слово число повторений}

FUNCTION Insert(VAR Ptr: Tree; Word: StrType): Tree; {Добавляет новое слово в дерево}

PROCEDURE OutputTree(Ptr: Tree); {Выводит элементы дерева в виде <слово><пробел><количество повторений>}

IMPLEMENTATION
  
CONST
  EqualKey = 0;
  RootBigger = 2;
  RootSmaller = 1;
  
FUNCTION Height(Ptr: Tree): INTEGER;
BEGIN {Height}
  IF Ptr <> NIL
  THEN
    Height := Ptr^.Height
  ELSE
    Height := 0
END; {Height}

FUNCTION BalanceFactor(Ptr: Tree): INTEGER;
VAR
  HeightL, HeightR: INTEGER;
BEGIN
  BalanceFactor := Height(Ptr^.Left) - Height(Ptr^.Right)
END;

PROCEDURE SetHeight(VAR Ptr: Tree);
VAR
  HeightL, HeightR: INTEGER;
BEGIN {Height}
  IF Ptr <> NIL
  THEN
    BEGIN
      HeightL := Height(Ptr^.Left);
      HeightR := Height(Ptr^.Right);
      IF HeightL >= HeightR
      THEN
        Ptr^.Height := HeightL + 1
      ELSE
        Ptr^.Height := HeightR + 1
    END
END; {Height}

FUNCTION RotateRight(VAR Ptr: Tree): Tree;
VAR
  TmpPtr: Tree;
BEGIN {RotateRight}
  TmpPtr := Ptr^.Left;
  Ptr^.Left := TmpPtr^.Right;
  TmpPtr^.Right := Ptr;
  SetHeight(Ptr);
  SetHeight(TmpPtr);
  RotateRight := TmpPtr
END;  {RotateRight} 

FUNCTION RotateLeft(VAR Ptr: Tree): Tree;
VAR
  TmpPtr: Tree;
BEGIN {RotateRight}
  TmpPtr := Ptr^.Right;
  Ptr^.Right := TmpPtr^.Left;
  TmpPtr^.Left := Ptr;
  SetHeight(Ptr);
  SetHeight(TmpPtr);
  RotateLeft := TmpPtr
END;  {RotateRight} 

FUNCTION Balance(VAR Ptr: Tree): Tree;
BEGIN {Balance}
  SetHeight(Ptr);
  Balance := Ptr;
  IF BalanceFactor(Ptr) = 2
  THEN
    BEGIN
      IF (BalanceFactor(Ptr^.Left) < 0)
      THEN
        Ptr^.Left := RotateLeft(Ptr^.Left);
      Balance := RotateRight(Ptr)
    END
  ELSE
    IF BalanceFactor(Ptr) = -2
    THEN
      BEGIN
        IF BalanceFactor(Ptr^.Right) > 0
        THEN
          Ptr^.Right := RotateRight(Ptr^.Right);
        Balance := RotateLeft(Ptr)
      END
END; {Balance}
    
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

FUNCTION Insert(VAR Ptr: Tree; Word: StrType): Tree;
VAR
  Flag: INTEGER;
BEGIN {Insert}
  IF Ptr = NIL
  THEN
    BEGIN
      NEW(Ptr);
      Ptr^.Key := Word;
      Ptr^.Count := 1;
      Ptr^.Height := 1;
      Ptr^.Left := NIL;
      Ptr^.Right := NIL
    END
  ELSE
    BEGIN
      Flag := Lexico(Ptr^.Key, Word);
      IF Flag = RootBigger
      THEN
        Ptr^.Left := Insert(Ptr^.Left, Word)
      ELSE
        Ptr^.Right := Insert(Ptr^.Right, Word)
    END;
  Insert := Balance(Ptr)
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

PROCEDURE OutputTree(Ptr: Tree; VAR F: TEXT);
VAR
  Word: StrType;
  Index: INTEGER;
  Ch: CHAR;
  FTmp: TEXT;
BEGIN {OutputTree}
  RESET(FOut);
  Index := 0;
  IF Ptr <> NIL
  THEN
    BEGIN
      OutputTree(Ptr^.Left, F);
      IF (NOT EOLN(FOut)) AND (NOT EOF(F))
      THEN
        READ(F, Ch);
      WHILE (Ch <> ' ') AND (NOT EOF(F)) AND (NOT EOLN(F))
      DO
        BEGIN
          Index := Index + 1;
          Word.Val[Index] := Ch;
          READ(F, Ch)
        END;
      Word.Length := Index;
      Flag := Lexico(Ptr^.Key, Word);
      
      OutputTree(Ptr^.Right, F)
    END
END; {OutputTree}
  
BEGIN {BinaryWordTree}
END.  {BinaryWordTree}
