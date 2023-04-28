UNIT BinaryWordTree2;

INTERFACE

TYPE
  StrType = ARRAY [1 .. 255] OF CHAR;
  Tree = ^NodeType;
  NodeType = RECORD
               Key: StrType;
               Count, Height, Length: INTEGER;
               Left, Right: Tree
             END;

FUNCTION Insert(VAR Ptr: Tree; Word: StrType; Len: INTEGER): Tree; {ƒобавл€ет новое слово в дерево}

PROCEDURE OutputTree(VAR FOut: TEXT; Ptr: Tree); {¬ыводит элементы дерева в виде <слово><пробел><количество повторений>}

IMPLEMENTATION
  
FUNCTION Height(Ptr: Tree): INTEGER;
BEGIN {Height}
  IF Ptr <> NIL
  THEN
    Result := Ptr^.Height
  ELSE
    Result := 0
END; {Height}

FUNCTION BalanceFactor(Ptr: Tree): INTEGER;
BEGIN
  Result := Height(Ptr^.Left) - Height(Ptr^.Right)
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
  Result := TmpPtr
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
  Result := TmpPtr
END;  {RotateRight} 

FUNCTION Balance(VAR Ptr: Tree): Tree;
BEGIN {Balance}
  SetHeight(Ptr);
  Result := Ptr;
  IF BalanceFactor(Ptr) = 2
  THEN
    BEGIN
      IF BalanceFactor(Ptr^.Left) < 0
      THEN
        Ptr^.Left := RotateLeft(Ptr^.Left);
      Result := RotateRight(Ptr)
    END
  ELSE
    IF BalanceFactor(Ptr) = -2
    THEN
      BEGIN
        IF BalanceFactor(Ptr^.Right) > 0
        THEN
          Ptr^.Right := RotateRight(Ptr^.Right);
        Result := RotateLeft(Ptr)
      END
END; {Balance}
    
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

FUNCTION Insert(VAR Ptr: Tree; Word: StrType; Len: INTEGER): Tree;

CONST
  EqualKey = 0;
  RootBigger = 2;
  RootSmaller = 1;

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
      Ptr^.Length := Len;
      Ptr^.Left := NIL;
      Ptr^.Right := NIL
    END
  ELSE
    BEGIN
      Flag := Lexico(Ptr^.Key, Word, Ptr^.Length, Len);
      IF Flag = RootBigger
      THEN
        Ptr^.Left := Insert(Ptr^.Left, Word, Len)
      ELSE
        IF Flag = EqualKey
        THEN
          Ptr^.Count := Ptr^.Count + 1
        ELSE
          Ptr^.Right := Insert(Ptr^.Right, Word, Len)
    END;
  Result := Balance(Ptr)
END; {Insert}

PROCEDURE OutputTree(VAR FOut: TEXT; Ptr: Tree);
VAR
  Index: INTEGER;
BEGIN {OutputTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      OutputTree(FOut, Ptr^.Left);
      FOR Index := 1 TO Ptr^.Length
      DO
        WRITE(FOut, Ptr^.Key[Index]);
      WRITELN(FOut, ' ', Ptr^.Count);
      OutputTree(FOut, Ptr^.Right)
    END
END; {OutputTree}
  
BEGIN {BinaryWordTree}
END.  {BinaryWordTree}
