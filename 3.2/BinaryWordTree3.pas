UNIT BinaryWordTree3;

INTERFACE

USES
  TypeUtils3;

PROCEDURE InsertWord(Word: WordType); {Добавляет новое слово в дерево}

PROCEDURE OutputTree(VAR FOut: TEXT); {Выводит элементы дерева в виде <слово><пробел><количество повторений>}

IMPLEMENTATION

USES
  WordHandler3;

VAR
  Root: Tree;
  
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
      
 
PROCEDURE InsertWord(Word: WordType);

FUNCTION Insert(VAR Ptr: Tree; Word: WordType): Tree;
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
      Ptr^.Key.WordArray[1] := Word;
      Ptr^.Key.Count := Word.Count;
      Ptr^.Key.Number := 1;
      Ptr^.Height := 1;
      Ptr^.Left := NIL;
      Ptr^.Right := NIL
    END
  ELSE
    BEGIN
      Flag := Lexico(Ptr^.Key.WordArray[1], Word);
      IF Flag = RootBigger
      THEN
        Ptr^.Left := Insert(Ptr^.Left, Word)
      ELSE
        IF Flag = EqualKey
        THEN
          BEGIN
            Ptr^.Key.Count := Ptr^.Key.Count + Word.Count;
            Ptr^.Key.WordArray[Ptr^.Key.Number + 1] := Word;
            Ptr^.Key.Number := Ptr^.Key.Number + 1
          END
        ELSE
          Ptr^.Right := Insert(Ptr^.Right, Word)
    END;  
  Result := Balance(Ptr)
END; {Insert}

BEGIN {InsertWord}
  Root := Insert(Root, Word)
END;  {InsertWord}

PROCEDURE OutputTree(VAR FOut: TEXT);

PROCEDURE OutputFromTree(VAR FOut: TEXT; Ptr: Tree);
VAR
  Index: INTEGER;
BEGIN {OutputTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      OutputFromTree(FOut, Ptr^.Left);
      PrintKey(FOut, Ptr^.Key);
      OutputFromTree(FOut, Ptr^.Right)
    END
END; {OutputTree}
BEGIN
  OutputFromTree(FOut, Root)
END;
  
BEGIN {BinaryWordTree}
  Root := NIL;   
END.  {BinaryWordTree}
