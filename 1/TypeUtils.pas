UNIT TypeUtils;

INTERFACE

CONST
  MaxLen = 256;
  EngLet = ['a' .. 'z'];
  RusLet = ['�' .. '�'] + ['�' .. '�'] + ['�'];
  BigLetters = ['A' .. 'Z'] + ['a' .. 'z'] + ['�' .. '�'] + ['�'];
  SmallLetters = EngLet + RusLet + ['-'];

TYPE
  StrType = ARRAY [1 .. MaxLen] OF CHAR;
  Tree = ^NodeType;
  NodeType = RECORD
               Key: StrType;
               Count, Height, Length: INTEGER;
               Left, Right: Tree
             END;

IMPLEMENTATION

BEGIN
END.
