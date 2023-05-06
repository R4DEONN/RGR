UNIT WordHandler;

INTERFACE

USES
  TypeUtils;

FUNCTION Lexico(Word1, Word2: StrType; Len1, Len2: INTEGER): INTEGER;

FUNCTION OutputKey(VAR FOut: TEXT; Word: StrType; Len: INTEGER): STRING;

IMPLEMENTATION

FUNCTION Lexico(Word1, Word2: StrType; Len1, Len2: INTEGER): INTEGER;
{Result 0, 1, 2 ���� ������������������ ������� F1 =, <, > ��� F2       
��������������. ����������� ���������, ��������������� F1 � F2,   
������ ���� ����������}

VAR
  Ch1, Ch2: CHAR;
  Index: INTEGER;
BEGIN {Lexico}
  Index := 1;
  Result := 0;
  WHILE ((Index <> Len1 + 1) AND (Index <> Len2 + 1)) AND (Result = 0)
  DO
    BEGIN
      Ch1 := Word1[Index];
      Ch2 := Word2[Index];
      Index := Index + 1;
      IF (Ch1 < Ch2)
      THEN {Ch1 < Ch2 ��� F1 ������ F2}
        Result := 1
      ELSE
        IF (Ch1 > Ch2)
        THEN {Ch1 > Ch2 ��� F2 ������ F1}
          Result := 2
    END; {WHILE}
  IF Result = 0
  THEN
    IF Index <> Len1 + 1
    THEN
      Result := 2
    ELSE
      IF Index <> Len2 + 1
      THEN
        Result := 1
END; {Lexico}

FUNCTION OutputKey(VAR FOut: TEXT; Word: StrType; Len: INTEGER): STRING;
VAR
  Index: 1 .. MaxLen;
BEGIN
  Result := '';
  FOR Index := 1 TO Len
  DO
    Result := Result + Word[Index]
END;

BEGIN
END.
