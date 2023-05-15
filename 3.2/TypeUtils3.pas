UNIT TypeUtils3;

INTERFACE

TYPE
  WordType = RECORD
               Val: STRING;
               Len: INTEGER;
               Count: INTEGER
             END;
  WordsArray = RECORD
                 WordArray: ARRAY [1 .. 256] OF WordType;
                 Count: INTEGER;
                 Number: INTEGER;
               END;   
  Tree = ^NodeType;
  NodeType = RECORD
               Key: WordsArray;
               Height: INTEGER;
               Left, Right: Tree
             END;
             
CONST
  MaxLen = 256;
   

IMPLEMENTATION

BEGIN
END.
