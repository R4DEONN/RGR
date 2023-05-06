UNIT TypeUtils2;

INTERFACE

CONST
  MaxLen = 256;
  EngLet = ['a' .. 'z'];
  RusLet = ['à' .. 'ï'] + ['ð' .. 'ÿ'] + ['¸'];
  BigLetters = ['A' .. 'Z'] + ['a' .. 'z'] + ['À' .. 'ß'] + ['¨'];
  SmallLetters = EngLet + RusLet + ['-'];

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

IMPLEMENTATION

BEGIN
END.
