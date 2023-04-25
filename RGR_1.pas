PROGRAM CountWords(INPUT, OUTPUT);

CONST
  MaxLength = 100; 

TYPE
  StrType = ARRAY [1 .. MaxLength] OF CHAR;
  Tree = ^NodeType;
  NodeType = RECORD
               Val: StrType;
               Length, Count: INTEGER;
               Left, Right: Tree
             END;
             
FUNCTION  ToLower(Ch: CHAR):            
             
VAR
  Root: Tree;
  Ch: CHAR;
  FIn, FOut: TEXT;
  Word: StrType;
  Index: 1 .. MaxLength;

BEGIN {CountWords}
  ASSIGN(FIn, 'in.txt');
  ASSIGN(FOut, 'out.txt');
  RESET(FIn);
  REWRITE(FOut);
  Index := 1;
  NEW(Root);
  
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      WHILE (NOT EOLN(FIn)) AND (NOT EOF(FIn))
      DO
        BEGIN
          READ(FIn, Ch);
        END;
      READLN(FIn)
    END;
  
  CLOSE(FIn);
  CLOSE(FOut)                  
END. {CountWords}
