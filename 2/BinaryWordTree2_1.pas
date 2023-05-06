UNIT BinaryWordTree2_1;

INTERFACE

USES
  TypeUtils2;

PROCEDURE InsertWord(Word: WordType); {Добавляет новое слово в дерево}

PROCEDURE OutputTree(VAR FOut: TEXT); {Выводит элементы дерева в виде <слово><пробел><количество повторений>}

IMPLEMENTATION

USES
  WordHandler2;

VAR
  F: TEXT;
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

FUNCTION ThrowTreeToTemp(VAR F: TEXT; VAR Ptr: Tree): Tree;
VAR
  FTmp: TEXT;
  Ch: CHAR;
  Word: WordType;
FUNCTION MergeSort(VAR F, FTmp: TEXT; VAR Ptr: Tree; Word: WordType): WordType;
VAR
  Index, Flag: INTEGER;
  Ch: CHAR;
BEGIN {OutputTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      Word := MergeSort(F, FTmp, Ptr^.Left, Word);
      IF (NOT EOF(F)) OR (Word.Count <> 0)
      THEN
        REPEAT
          BEGIN
            Index := 0;
            IF (Word.Count = 0) AND (NOT EOLN(F)) AND (NOT EOF(F))
            THEN                                    
              BEGIN 
                READ(F, Ch);
                WHILE (Ch <> ' ') AND (Index < MaxLen) AND (NOT EOLN(F)) AND (NOT EOF(F))
                DO
                  BEGIN
                    Index := Index + 1;
                    Word.Val[Index] := Ch;
                    Word.Len := Index;
                    Word.Count := 1;
                    READ(F, Ch)
                  END;
                READLN(F, Word.Count)
              END; 
            IF Word.Count = 0
            THEN
              BEGIN
                PrintKey(FTmp, Ptr^.Key);
                Flag := 1
              END
            ELSE
              BEGIN 
                Flag := Lexico(Ptr^.Key, Word);
                IF Flag = 0
                THEN
                  Word.Count := Ptr^.Key.Count + Word.Count;
                IF Flag <> 1
                THEN
                  BEGIN
                    PrintKey(FTmp, Word);
                    Word.Count := 0;
                    Word.Len := 0
                  END
                ELSE
                  IF Flag = 1
                  THEN
                    PrintKey(FTmp, Ptr^.Key)
              END
          END
        UNTIL Flag <> 2
      ELSE            
        PrintKey(FTmp, Ptr^.Key);
      Word := MergeSort(F, FTmp, Ptr^.Right, Word);
      DISPOSE(Ptr)
    END;
  Result := Word
END; {OutputTree}
BEGIN         
  Word.Count := 0;
  Word.Len := 0;
  REWRITE(FTmp);
  RESET(F);
  Word := MergeSort(F, FTmp, Ptr, Word);
  REWRITE(F);
  RESET(FTmp);
  WHILE NOT EOF(FTmp)
  DO
    BEGIN
      WHILE (NOT EOF(FTmp)) AND (NOT EOLN(FTmp))
      DO
        BEGIN
          READ(FTmp, Ch);
          WRITE(F, Ch)
        END;
      WRITELN(F);
      READLN(FTmp)
    END;
  Result := NIL
END;
      

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
      Ptr^.Key := Word;
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
        IF Flag = EqualKey
        THEN
          Ptr^.Key.Count := Ptr^.Key.Count + 1
        ELSE
          Ptr^.Right := Insert(Ptr^.Right, Word)
    END;  
  Result := Balance(Ptr)
END; {Insert}

BEGIN {InsertWord}
  Root := Insert(Root, Word);
  IF Root^.Height > 15
  THEN
    Root := ThrowTreeToTemp(F, Root)
END;  {InsertWord}



PROCEDURE OutputTree(VAR FOut: TEXT);

PROCEDURE OutputFromTree(VAR FOut: TEXT; VAR F: TEXT; VAR Root: Tree);
VAR
  Ch: CHAR;
BEGIN {OutputTree}
  Root := ThrowTreeToTemp(F, Root);
  RESET(F);
  WHILE NOT EOF(F)
  DO
    BEGIN
      WHILE NOT EOLN(F)
      DO
        BEGIN
          READ(F, Ch);
          WRITE(FOut, Ch)
        END;
      WRITELN(FOut);
      READLN(F)
    END
END; {OutputTree}
BEGIN
  OutputFromTree(FOut, F, Root)
END;
  
BEGIN {BinaryWordTree}
  REWRITE(F);
  Root := NIL;
END.  {BinaryWordTree}
