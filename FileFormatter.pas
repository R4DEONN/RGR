UNIT FileFormatter;

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
             
CONST
  SingleLetEndsCount = 11;
  DoubleLetEndsCount = 57;
  TripleLetEndsCount = 34;
  QuadroLetEndsCount = 1;
  MaxLen = 256;
  SingleLetEnds: ARRAY [1 .. SingleLetEndsCount] OF StrType = ('а', 'я', 'о', 'е', 'ь', 'ы', 'и', 'у', 'ю', 'й', 's');
  DoubleLetEnds: ARRAY [1 .. DoubleLetEndsCount] OF StrType = ('ая', 'яя', 'ое', 'ее', 'ой', 'ые', 'ие', 'ый', 
                                                               'ий', 'ем', 'им', 'ет', 'ит', 'ут', 'ют', 'ят', 
                                                               'ал', 'ял', 'ол', 'ел', 'ул', 'ам', 'ас', 'ах', 
                                                               'её', 'её', 'ех', 'ею', 'ёт', 'ёх', 'ие', 'ий', 
                                                               'им', 'ит', 'их', 'ию', 'ми', 'мя', 'ов', 'ое', 
                                                               'оё', 'ом', 'ою', 'см', 'ум', 'ух', 'ую', 'шь',
                                                               'ей', 'ью', 'ия', 'ии', 'ях', 'ям', 'ёй', 'es',
                                                               'ed'
                                                               );
  TripleLetEnds: ARRAY [1 .. TripleLetEndsCount] OF StrType = ('ать', 'ять', 'оть', 'еть', 'ешь', 'ишь', 'ете', 
                                                               'ите', 'ала', 'яла', 'али', 'яли', 'ола', 'ела', 
                                                               'оли', 'ели', 'ула', 'ули', 'ами', 'еми', 'емя', 
                                                               'ёте', 'ёшь', 'ими', 'ого', 'его', 'ому', 'умя', 
                                                               'ией', 'иям', 'иях', 'ями', 'отя', 'ing'
                                                               );
  QuadroLetEnds: ARRAY [1 .. QuadroLetEndsCount] OF StrType  = ('иями');
  
FUNCTION Lexico(Word1, Word2: StrType; Len1, Len2: INTEGER): BOOLEAN; {Проверяет эквивалентность слов}  
  
FUNCTION LenWithOutEnding(Word: WordType): INTEGER; {Возвращает длину слова без окончания}

PROCEDURE MergeSingleRootWords(VAR F, FTmp: TEXT; Words: WordsArray; FirstLetter: CHAR); {Соединяет в файле однокоренные слова}

PROCEDURE Copy(VAR FIn, FOut: TEXT); {Копирует один файл в другой}

IMPLEMENTATION

FUNCTION Lexico(Word1, Word2: StrType; Len1, Len2: INTEGER): BOOLEAN;
{Сравнивает два слова, возвращает TRUE, если равны, FALSE, если нет}
VAR
  Ch1, Ch2: CHAR;
  I: INTEGER;
BEGIN {Lexico}
  I := 1;
  Result := TRUE;
  IF Len1 <> Len2
  THEN
    Result := FALSE;
  WHILE (I <> Len1 + 1) AND (Result)
  DO
    BEGIN
      Ch1 := Word1[I];
      Ch2 := Word2[I];
      I := I + 1;
      IF (Ch1 <> Ch2)
      THEN
        Result := FALSE
    END
END; {Lexico}                  

FUNCTION CheckEnding(VAR Ending: WordType; Word: WordType; EndingLen, EndingCount: INTEGER): BOOLEAN;
{Возвращает TRUE, если нашлось окончание, иначе FALSE}
VAR
  I, J: INTEGER;
BEGIN {CheckEnding}
  J := 0;
  Result := FALSE;
  FOR I := EndingLen - 1 DOWNTO 0
  DO
    BEGIN
      J := J + 1;
      Ending.Val[J] := Word.Val[Word.Len - I]
    END;
  Ending.Len := J;       
  WHILE (I <= EndingCount) AND (NOT Result)
  DO
    BEGIN
      I := I + 1;
      Result := Lexico(Ending.Val, TripleLetEnds[I], EndingLen, EndingLen)
    END
END;  {CheckEnding}

FUNCTION LenWithOutEnding(Word: WordType): INTEGER;
{Возвращает длину слова без окончания}
VAR
  IsEnding: BOOLEAN;
  Ending: WordType;
BEGIN {CheckEndings}
  IsEnding := FALSE;
  IF (Word.Len > 4) AND (NOT IsEnding)
  THEN
    IsEnding := CheckEnding(Ending, Word, 4, QuadroLetEndsCount);
  IF (Word.Len > 3) AND (NOT IsEnding)
  THEN
    IsEnding := CheckEnding(Ending, Word, 3, TripleLetEndsCount);
  IF (Word.Len > 2) AND (NOT IsEnding)
  THEN
    IsEnding := CheckEnding(Ending, Word, 2, DoubleLetEndsCount);
  IF (Word.Len > 1) AND (NOT IsEnding)
  THEN
    IsEnding := CheckEnding(Ending, Word, 1, SingleLetEndsCount);
  IF IsEnding
  THEN
    Result := Word.Len - Ending.Len
  ELSE
    Result := Word.Len;
END;  {CheckEndings}

PROCEDURE MergeSingleRootWords(VAR F, FTmp: TEXT; Words: WordsArray; FirstLetter: CHAR);
{Соединяет однокоренные слова в файле в одну стрчку и записывает все данные во временный файл}
VAR
  I, J, K: INTEGER;
  Ch: CHAR;
  Word: WordType;
BEGIN {MergeSingleRootWords}
  K := 1;
  WHILE (NOT EOF(F)) AND (NOT EOLN(F))
  DO
    BEGIN
      I := 1;
      READ(F, Ch);
      IF Ch = FirstLetter
      THEN
        BEGIN
          WHILE (NOT EOLN(F)) AND (Ch <> ' ') AND (Ch <> ':')
          DO
            BEGIN
              Word.Val[I] := Ch;
              READ(F, Ch);
              I := I + 1
            END;
          IF Ch = ':'
          THEN
            READ(F, Ch);
          READ(F, Word.Count);
          Word.Len := I - 1;
          IF Lexico(Word.Val, Words.WordArray[K].Val, Word.Len, Words.WordArray[K].Len)
          THEN
            BEGIN
              IF K = 1
              THEN
                BEGIN
                  FOR I := 1 TO Words.Number
                  DO
                    BEGIN
                      FOR J := 1 TO Words.WordArray[I].Len
                      DO
                        WRITE(FTmp, Words.WordArray[I].Val[J]);
                        IF I <> Words.Number
                        THEN
                          WRITE(FTmp, ',')
                     END;
                   WRITELN(FTmp, ': ', Words.Count)
                END;
              K := K + 1
            END 
          ELSE
            BEGIN
              FOR I := 1 TO Word.Len
              DO
                WRITE(FTmp, Word.Val[I]);
              WRITELN(FTmp, ': ', Word.Count)
            END  
        END
      ELSE
        BEGIN
          WHILE (NOT EOLN(F)) AND (Ch <> ' ') AND (Ch <> ':')
          DO
            BEGIN
              WRITE(FTmp, Ch);
              READ(F, Ch)
            END;
          IF Ch = ':'
          THEN
            READ(F, Ch);
          READ(F, I);
          WRITELN(FTmp, ': ', I)
        END;
      READLN(F)
    END
END;  {MergeSingleRootWords}

PROCEDURE Copy(VAR FIn, FOut: TEXT);
{Копирует данные из одного файла в другой}
VAR
  Ch: CHAR;
BEGIN {Copy}
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      WHILE NOT EOLN(FIn)
      DO
        BEGIN
          READ(FIn, Ch);
          WRITE(FOut, Ch)
        END;
      WRITELN(FOut);
      READLN(FIn)
    END
END;  {Copy}

BEGIN {FileFormatter}
END.  {FileFormatter}
