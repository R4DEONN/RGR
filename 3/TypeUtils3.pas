UNIT TypeUtils3;

INTERFACE

TYPE
  StrType = ARRAY [1 .. 256] OF CHAR;
  WordType = RECORD
               Val: StrType;
               Len: INTEGER;
               LenWOEnd: INTEGER;
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
  SingleLetEndsCount = 11;
  DoubleLetEndsCount = 58;
  TripleLetEndsCount = 34;
  QuadroLetEndsCount = 1;
  MaxLen = 256;
  SingleLetEnds: ARRAY [1 .. SingleLetEndsCount] OF StrType = ('�', '�', '�', '�', '�', '�', '�', '�', '�', '�', 's');
  DoubleLetEnds: ARRAY [1 .. DoubleLetEndsCount] OF StrType = ('��', '��', '��', '��', '��', '��', '��', '��', 
                                                               '��', '��', '��', '��', '��', '��', '��', '��', 
                                                               '��', '��', '��', '��', '��', '��', '��', '��', 
                                                               '�', '�', '��', '��', '��', '��', '��', '��', 
                                                               '��', '��', '��', '��', '��', '��', '��', '��', 
                                                               '�', '��', '��', '��', '��', '��', '��', '��',
                                                               '��', '��', '��', '��', '��', '��', '��', '��', 
                                                               'es', 'ed'
                                                               );
  TripleLetEnds: ARRAY [1 .. TripleLetEndsCount] OF StrType = ('���', '���', '���', '���', '���', '���', '���', 
                                                               '���', '���', '���', '���', '���', '���', '���', 
                                                               '���', '���', '���', '���', '���', '���', '���', 
                                                               '���', '���', '���', '���', '���', '���', '���', 
                                                               '���', '���', '���', '���', '���', 'ing'
                                                               );
  QuadroLetEnds: ARRAY [1 .. QuadroLetEndsCount] OF StrType  = ('����');
   

IMPLEMENTATION

BEGIN
END.
