UNIT BinaryWordTree2;

INTERFACE

CONST
  MaxLen = 255;

TYPE
  StrType = ARRAY [1 .. MaxLen] OF CHAR;
  WordType = RECORD
               Val: StrType;
               Len, Count: INTEGER
             END;
  Tree = ^NodeType;
  NodeType = RECORD
               Key: WordType;
               Height: INTEGER;
               Left, Right: Tree
             END;

FUNCTION Insert(VAR Ptr: Tree; Word: WordType): Tree; {ƒобавл€ет новое слово в дерево}

FUNCTION OutputTree(VAR FOut: TEXT; VAR Ptr: Tree): Tree; 
{¬ыводит элементы дерева в виде <слово><пробел><количество повторений>}

IMPLEMENTATION
  
FUNCTION Height(Ptr: Tree): INTEGER;
VAR
  HL, HR: INTEGER;
BEGIN {Height}
  IF Ptr = NIL
  THEN
    Result := 0
  ELSE
    BEGIN
      HL := Height(Ptr^.Left);
      HR := Height(Ptr^.Right);
      IF HL >= HR
      THEN
        Result := HL + 1
      ELSE
        Result := HR + 1
    END 
END; {Height}

FUNCTION BalanceFactor(Ptr: Tree): INTEGER;
BEGIN
  Result := Height(Ptr^.Left) - Height(Ptr^.Right)
END;

FUNCTION RotateRight(VAR Ptr: Tree): Tree;
VAR
  TmpPtr: Tree;
BEGIN {RotateRight}
  TmpPtr := Ptr^.Left;
  Ptr^.Left := TmpPtr^.Right;
  TmpPtr^.Right := Ptr;
  Ptr^.Height := Height(Ptr);
  TmpPtr^.Height := Height(TmpPtr);
  Result := TmpPtr
END;  {RotateRight} 

FUNCTION RotateLeft(VAR Ptr: Tree): Tree;
VAR
  TmpPtr: Tree;
BEGIN {RotateRight}
  TmpPtr := Ptr^.Right;
  Ptr^.Right := TmpPtr^.Left;
  TmpPtr^.Left := Ptr;
  Ptr^.Height := Height(Ptr);
  TmpPtr^.Height := Height(TmpPtr);
  Result := TmpPtr
END;  {RotateRight} 

FUNCTION Balance(VAR Ptr: Tree): Tree;
BEGIN {Balance}
  Result := Ptr;
  Ptr^.Height := Height(Ptr);
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
    
FUNCTION Lexico(Word1, Word2: WordType): INTEGER;
{Result 0, 1, 2 если лексикографический пор€док F1 =, <, > чем F2       
соответственно. ‘актические параметры, соответствующие F1 и F2,   
должны быть различными}

VAR
  Ch1, Ch2: CHAR;
  Index: INTEGER;
BEGIN {Lexico}
  Index := 1;
  Result := 0;
  WHILE ((Index <> Word1.Len + 1) AND (Index <> Word2.Len + 1)) AND (Result = 0)
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
    IF Index <> Word1.Len + 1
    THEN
      Result := 2
    ELSE
      IF Index <> Word2.Len + 1
      THEN
        Result := 1
END; {Lexico}  

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

PROCEDURE PrintWord(VAR FOut: TEXT; Word: WordType);
VAR
  Index: INTEGER;
BEGIN {PrintWord}
  FOR Index := 1 TO Word.Len
  DO
    WRITE(FOut, Word.Val[Index]);
  WRITELN(FOut, ' ', Word.Count)
END;  {PrintWord}


FUNCTION OutputTree(VAR FOut: TEXT; VAR Ptr: Tree): Tree;
VAR
  FTmp: TEXT;
  Ch: CHAR;
  Word: WordType;
FUNCTION MergeSort(VAR FOut: TEXT; VAR Ptr: Tree; Word: WordType): WordType;
VAR
  Index, Flag: INTEGER;
  Ch: CHAR;
BEGIN {OutputTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      Word := MergeSort(FOut, Ptr^.Left, Word);
      IF (NOT EOF(FOut)) OR (Word.Count <> 0)
      THEN
        REPEAT
          BEGIN
            Index := 0;
            IF (Word.Count = 0) AND (NOT EOLN(FOut)) AND (NOT EOF(FOut))
            THEN                                    
              BEGIN 
                READ(FOut, Ch);
                WHILE (Ch <> ' ') AND (Index < MaxLen) AND (NOT EOLN(FOut)) AND (NOT EOF(FOut))
                DO
                  BEGIN
                    Index := Index + 1;
                    Word.Val[Index] := Ch;
                    Word.Len := Index;
                    Word.Count := 1;
                    READ(FOut, Ch)
                  END;
                READLN(FOut, Word.Count)
              END; 
            IF Word.Count = 0
            THEN
              BEGIN
                PrintWord(FTmp, Ptr^.Key);
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
                    PrintWord(FTmp, Word);
                    Word.Count := 0;
                    Word.Len := 0
                  END
                ELSE
                  IF Flag = 1
                  THEN
                    PrintWord(FTmp, Ptr^.Key)
              END
          END
        UNTIL Flag <> 2
      ELSE
        PrintWord(FTmp, Ptr^.Key);
      Word := MergeSort(FOut, Ptr^.Right, Word);
      DISPOSE(Ptr)
    END;
  Result := Word
END; {OutputTree}
BEGIN         
  Word.Count := 0;
  Word.Len := 0;
  REWRITE(FTmp);
  Word := MergeSort(FOut, Ptr, Word);
  REWRITE(FOut);
  RESET(FTmp);
  WHILE NOT EOF(FTmp)
  DO
    BEGIN
      WHILE (NOT EOF(FTmp)) AND (NOT EOLN(FTmp))
      DO
        BEGIN
          READ(FTmp, Ch);
          WRITE(FOut, Ch)
        END;
      WRITELN(FOut);
      READLN(FTmp)
    END;
  Result := NIL
END;
  
BEGIN {BinaryWordTree}
END.  {BinaryWordTree}
