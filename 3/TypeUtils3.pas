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
  SingleLetEnds: ARRAY [1 .. SingleLetEndsCount] OF StrType = ('а', '€', 'о', 'е', 'ь', 'ы', 'и', 'у', 'ю', 'й', 's');
  DoubleLetEnds: ARRAY [1 .. DoubleLetEndsCount] OF StrType = ('а€', '€€', 'ое', 'ее', 'ой', 'ые', 'ие', 'ый', 
                                                               'ий', 'ем', 'им', 'ет', 'ит', 'ут', 'ют', '€т', 
                                                               'ал', '€л', 'ол', 'ел', 'ул', 'ам', 'ас', 'ах', 
                                                               'еЄ', 'еЄ', 'ех', 'ею', 'Єт', 'Єх', 'ие', 'ий', 
                                                               'им', 'ит', 'их', 'ию', 'ми', 'м€', 'ов', 'ое', 
                                                               'оЄ', 'ом', 'ою', 'см', 'ум', 'ух', 'ую', 'шь',
                                                               'ей', 'ью', 'и€', 'ии', '€х', '€м', 'Єй', 'ев', 
                                                               'es', 'ed'
                                                               );
  TripleLetEnds: ARRAY [1 .. TripleLetEndsCount] OF StrType = ('ать', '€ть', 'оть', 'еть', 'ешь', 'ишь', 'ете', 
                                                               'ите', 'ала', '€ла', 'али', '€ли', 'ола', 'ела', 
                                                               'оли', 'ели', 'ула', 'ули', 'ами', 'еми', 'ем€', 
                                                               'Єте', 'Єшь', 'ими', 'ого', 'его', 'ому', 'ум€', 
                                                               'ией', 'и€м', 'и€х', '€ми', 'от€', 'ing'
                                                               );
  QuadroLetEnds: ARRAY [1 .. QuadroLetEndsCount] OF StrType  = ('и€ми');
   

IMPLEMENTATION

BEGIN
END.
