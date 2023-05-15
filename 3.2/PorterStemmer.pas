UNIT PorterStemmer;

INTERFACE

USES
  TypeUtils3;                                                 

FUNCTION BaseLen(Word: WordType): INTEGER;

IMPLEMENTATION

CONST               
  Vowels = ['а', 'е', 'и', 'о', 'у', 'ы', 'э', 'ю', '€', 'Є'];
  NonVowels = ['б', 'в', 'г', 'д', 'ж', 'з', 'й', 'к', 'л', 
               'м', 'н', 'п', 'р', 'с', 'т', 'ф', 'х', 'ц', 
               'ч', 'ш', 'щ'
              ];
  
  Gerund1Count = 3;
  Gerund2Count = 6; 
  ReflexiveCount = 2; 
  AdjectiveCount = 26;
  Participle1Count = 5;
  Participle2Count = 3; 
  Verb1Count = 17;
  Verb2Count = 29;   
  NounCount = 36; 
  DerivationalCount = 2;
  SuperlativeCount = 2;     
  PerfectiveGerund1: ARRAY [1 .. Gerund1Count] OF STRING = ('в', 'вши', 'вшись');
  PerfectiveGerund2: ARRAY [1 .. Gerund2Count] OF STRING = ('ив', 'ивши', 'ившись', 'ыв', 'ывши', 'ывшись');
  Adjective: ARRAY [1 .. AdjectiveCount] OF STRING = ('ее', 'ие', 'ые', 'ое', 'ими', 'ыми', 'ей', 'ий', 
                                           'ый', 'ой', 'ем', 'им', 'ым', 'ом', 'его', 'ого', 
                                           'ему', 'ому', 'их', 'ых', 'ую', 'юю', 'а€', '€€', 
                                           'ою', 'ею'
                                          );
  Participle1: ARRAY [1 .. Participle1Count] OF STRING = ('ем', 'нн', 'вш', 'ющ', 'щ');
  Participle2: ARRAY [1 .. Participle2Count] OF STRING = ('ивш', 'ывш', 'ующ');
  Reflexive: ARRAY [1 .. ReflexiveCount] OF STRING = ('с€', 'сь');
  Verb1: ARRAY [1 .. Verb1Count] OF STRING = ('ла', 'на', 'ете', 'йте', 'ли', 'й', 'л', 'ем', 'н', 
                                       'ло', 'но', 'ет', 'ют', 'ны', 'ть', 'еш', 'нно'
                                      );
  Verb2: ARRAY [1 .. Verb2Count] OF STRING = ('ила', 'ыла', 'ена', 'ейте', 'уйте', 'ите', 'или', 
                                       'ыли', 'ей', 'уй', 'ил', 'ыл', 'им', 'ым', 'ен', 
                                       'ило', 'ыло', 'ено', '€т', 'ует', 'уют', 'ит', 'ыт', 
                                       'ены', 'ить', 'ыть', 'ишь', 'ую', 'ю'
                                      );
  Noun: ARRAY [1 .. NounCount] OF STRING = ('а', 'ев', 'ов', 'ие', 'ье', 'е', 'и€ми', '€ми', 'ами', 
                                      'еи', 'ии', 'и', 'ией', 'ей', 'ой', 'ий', 'й', 'и€м', 
                                      '€м', 'ием', 'ем', 'ам', 'ом', 'о', 'у', 'ах', 'и€х', 
                                      '€х', 'ы', 'ь', 'ию', 'ью', 'ю', 'и€', 'ь€', '€'
                                     );
  Superlative: ARRAY [1 .. SuperlativeCount] OF STRING = ('ейш', 'ейше');
  Derivational: ARRAY [1 .. DerivationalCount] OF STRING = ('ост', 'ость');

                                   
FUNCTION FindRV(Word: WordType): INTEGER;
VAR
  I: INTEGER;
  Ch: CHAR;
BEGIN {FindRV}
  I := 1;
  WHILE (NOT (Word.Val[I] IN Vowels)) AND (I <= Word.Len)
  DO
    I := I + 1;
  Result := I + 1
END;  {FindRV}

FUNCTION FindR1(Word: WordType): INTEGER;
VAR
  I: INTEGER;
BEGIN {FindR1}
  I := 1;
  WHILE (I < Word.Len) AND ((NOT (Word.Val[I] IN Vowels)) OR (NOT (Word.Val[I + 1] IN NonVowels)))
  DO
    I := I + 1;
  IF (NOT (Word.Val[I] IN Vowels)) AND (NOT (Word.Val[I + 1] IN NonVowels))
  THEN
    Result := Word.Len + 1
  ELSE
    Result := I + 2
END;  {FindR1}

FUNCTION FindR2(Word: WordType; R1Index: INTEGER): INTEGER;
VAR
  I: INTEGER;
BEGIN {FindR1}
  I := R1Index;
  WHILE (I < Word.Len) AND ((NOT (Word.Val[I] IN Vowels)) OR (NOT (Word.Val[I + 1] IN NonVowels)))
  DO
    I := I + 1;
  IF (NOT (Word.Val[I] IN Vowels)) AND (NOT (Word.Val[I + 1] IN NonVowels))
  THEN
    Result := Word.Len + 1
  ELSE
    Result := I + 2
END;  {FindR1}

FUNCTION CheckGerund(Word: WordType; RVIndex: INTEGER; VAR EndLen: INTEGER): BOOLEAN;
VAR
  Ending: STRING;
  Ch: CHAR;
  I, EndLen1, EndLen2, EndingLen: INTEGER;
BEGIN {CheckGerund}
  Result := FALSE;
  Ending := '';
  EndLen1 := 0;
  EndLen2 := 0;
  I := Word.Len - RVIndex + 1;
  IF I > 7
  THEN
    EndingLen := 7
  ELSE
    EndingLen := I;
  FOR I := EndingLen - 1 DOWNTO 0
  DO
    Ending := Ending + Word.Val[Word.Len - I];
  FOR I := 1 TO Gerund1Count
  DO
    IF (POS(PerfectiveGerund1[I], Ending) <> 0) AND ((Ending[EndingLen - LENGTH(PerfectiveGerund1[I])] = 'а') 
        OR (Ending[EndingLen - LENGTH(PerfectiveGerund1[I])] = '€')) AND (EndLen1 < LENGTH(PerfectiveGerund1[I]))
    THEN
      EndLen1 := LENGTH(PerfectiveGerund1[I]);
  FOR I := 1 TO Gerund2Count
  DO
    IF (POS(PerfectiveGerund2[I], Ending) <> 0) AND (EndLen2 < LENGTH(PerfectiveGerund2[I]))
    THEN
      EndLen2 := LENGTH(PerfectiveGerund2[I]);
  IF EndLen1 > EndLen2
  THEN
    EndLen := EndLen1
  ELSE
    EndLen := EndLen2;
  IF (EndLen1 <> 0) OR (EndLen2 <> 0)
  THEN
    Result := TRUE;
END;  {CheckGerund}

FUNCTION CheckReflexive(Word: WordType; RVIndex: INTEGER; VAR EndLen: INTEGER): BOOLEAN;
VAR
  Ending: STRING;
  Ch: CHAR;
  I, EndLen1, EndingLen: INTEGER;
BEGIN {CheckReflexive}
  Result := FALSE;
  Ending := '';
  EndLen1 := 0;
  I := Word.Len - RVIndex + 1;
  IF I > 2
  THEN
    EndingLen := 2
  ELSE
    EndingLen := I;
  FOR I := EndingLen - 1 DOWNTO 0
  DO
    Ending := Ending + Word.Val[Word.Len - I];
  FOR I := 1 TO ReflexiveCount
  DO
    IF (POS(Reflexive[I], Ending) <> 0) AND (EndLen1 < LENGTH(Reflexive[I]))
    THEN
      EndLen1 := LENGTH(Reflexive[I]);
  IF EndLen1 <> 0
  THEN
    BEGIN
      Result := TRUE;
      EndLen := EndLen1
    END
END;  {CheckReflexive}

FUNCTION CheckAdjective(Word: WordType; RVIndex: INTEGER; VAR EndLen: INTEGER): BOOLEAN;
VAR
  Ending: STRING;
  Ch: CHAR;
  I, EndLen1, EndingLen: INTEGER;
BEGIN {CheckReflexive}
  Result := FALSE;
  Ending := '';
  EndLen1 := 0;
  I := Word.Len - RVIndex + 1;
  IF I > 3
  THEN
    EndingLen := 3
  ELSE
    EndingLen := I;
  FOR I := EndingLen - 1 DOWNTO 0
  DO
    Ending := Ending + Word.Val[Word.Len - I];
  FOR I := 1 TO AdjectiveCount
  DO
    IF (POS(Adjective[I], Ending) <> 0) AND (EndLen1 < LENGTH(Adjective[I]))
    THEN
      EndLen1 := LENGTH(Adjective[I]);
  IF EndLen1 <> 0
  THEN
    BEGIN
      Result := TRUE;
      EndLen := EndLen1
    END
END;  {CheckReflexive}

FUNCTION CheckParticiple(Word: WordType; RVIndex: INTEGER; VAR EndLen: INTEGER): BOOLEAN;
VAR
  Ending: STRING;
  Ch: CHAR;
  I, EndLen1, EndLen2, EndingLen: INTEGER;
BEGIN {CheckGerund}
  Result := FALSE;
  Ending := '';
  EndLen1 := 0;
  EndLen2 := 0;
  I := Word.Len - RVIndex + 1;
  IF I > 3
  THEN
    EndingLen := 3
  ELSE
    EndingLen := I;
  FOR I := EndingLen - 1 DOWNTO 0
  DO
    Ending := Ending + Word.Val[Word.Len - I];
  FOR I := 1 TO Participle1Count
  DO
    IF (POS(Participle1[I], Ending) <> 0) AND ((Ending[EndingLen - LENGTH(Participle1[I])] = 'а') 
        OR (Ending[EndingLen - LENGTH(Participle1[I])] = '€')) AND (EndLen1 < LENGTH(Participle1[I]))
    THEN
      EndLen1 := LENGTH(Participle1[I]);
  FOR I := 1 TO Participle2Count
  DO
    IF (POS(Participle2[I], Ending) <> 0) AND (EndLen2 < LENGTH(Participle2[I]))
    THEN
      EndLen2 := LENGTH(Participle2[I]);
  IF EndLen1 > EndLen2
  THEN
    EndLen := EndLen1
  ELSE
    EndLen := EndLen2;
  IF (EndLen1 <> 0) OR (EndLen2 <> 0)
  THEN
    Result := TRUE;
END;  {CheckGerund}

FUNCTION CheckVerb(Word: WordType; RVIndex: INTEGER; VAR EndLen: INTEGER): BOOLEAN;
VAR
  Ending: STRING;
  Ch: CHAR;
  I, EndLen1, EndLen2, EndingLen: INTEGER;
BEGIN {CheckGerund}
  Result := FALSE;
  Ending := '';
  EndLen1 := 0;
  EndLen2 := 0;
  I := Word.Len - RVIndex + 1;
  IF I > 4
  THEN
    EndingLen := 4
  ELSE
    EndingLen := I;
  FOR I := EndingLen - 1 DOWNTO 0
  DO
    Ending := Ending + Word.Val[Word.Len - I];
  FOR I := 1 TO Verb1Count
  DO
    IF (POS(Verb1[I], Ending) <> 0) AND ((Ending[EndingLen - LENGTH(Verb1[I])] = 'а') 
        OR (Ending[EndingLen - LENGTH(Verb1[I])] = '€')) AND (EndLen1 < LENGTH(Verb1[I]))
    THEN
      EndLen1 := LENGTH(Verb1[I]);
  FOR I := 1 TO Verb2Count
  DO
    IF (POS(Verb2[I], Ending) <> 0) AND (EndLen2 < LENGTH(Verb2[I]))
    THEN
      EndLen2 := LENGTH(Verb2[I]);
  IF EndLen1 > EndLen2
  THEN
    EndLen := EndLen1
  ELSE
    EndLen := EndLen2;
  IF (EndLen1 <> 0) OR (EndLen2 <> 0)
  THEN
    Result := TRUE;
END;  {CheckGerund}

FUNCTION CheckNoun(Word: WordType; RVIndex: INTEGER; VAR EndLen: INTEGER): BOOLEAN;
VAR
  Ending: STRING;
  Ch: CHAR;
  I, EndLen1, EndingLen: INTEGER;
BEGIN {CheckReflexive}
  Result := FALSE;
  Ending := '';
  EndLen1 := 0;
  I := Word.Len - RVIndex + 1;
  IF I > 4
  THEN
    EndingLen := 4
  ELSE
    EndingLen := I;
  FOR I := EndingLen - 1 DOWNTO 0
  DO
    Ending := Ending + Word.Val[Word.Len - I];
  FOR I := 1 TO NounCount
  DO
    IF (POS(Noun[I], Ending) <> 0) AND (EndLen1 < LENGTH(Noun[I]))
    THEN
      EndLen1 := LENGTH(Noun[I]);
  IF EndLen1 <> 0
  THEN
    BEGIN
      Result := TRUE;
      EndLen := EndLen1
    END
END;  {CheckReflexive}

FUNCTION CheckDerivational(Word: WordType; RVIndex: INTEGER; VAR EndLen: INTEGER): BOOLEAN;
VAR
  Ending: STRING;
  Ch: CHAR;
  I, EndLen1, EndingLen: INTEGER;
BEGIN {CheckReflexive}
  Result := FALSE;
  Ending := '';
  EndLen1 := 0;
  I := Word.Len - RVIndex + 1;
  IF I > 4
  THEN
    EndingLen := 4
  ELSE
    EndingLen := I;
  FOR I := EndingLen - 1 DOWNTO 0
  DO
    Ending := Ending + Word.Val[Word.Len - I];
  FOR I := 1 TO DerivationalCount
  DO
    IF (POS(Derivational[I], Ending) <> 0) AND (EndLen1 < LENGTH(Derivational[I]))
    THEN
      EndLen1 := LENGTH(Derivational[I]);
  IF EndLen1 <> 0
  THEN
    BEGIN
      Result := TRUE;
      EndLen := EndLen1
    END
END;  {CheckReflexive}

FUNCTION CheckSuperlative(Word: WordType; RVIndex: INTEGER; VAR EndLen: INTEGER): BOOLEAN;
VAR
  Ending: STRING;
  Ch: CHAR;
  I, EndLen1, EndingLen: INTEGER;
BEGIN {CheckReflexive}
  Result := FALSE;
  Ending := '';
  EndLen1 := 0;
  I := Word.Len - RVIndex + 1;
  IF I > 4
  THEN
    EndingLen := 4
  ELSE
    EndingLen := I;
  FOR I := EndingLen - 1 DOWNTO 0
  DO
    Ending := Ending + Word.Val[Word.Len - I];
  FOR I := 1 TO SuperlativeCount
  DO
    IF (POS(Superlative[I], Ending) <> 0) AND (EndLen1 < LENGTH(Superlative[I]))
    THEN
      EndLen1 := LENGTH(Superlative[I]);
  IF EndLen1 <> 0
  THEN
    BEGIN
      Result := TRUE;
      EndLen := EndLen1
    END
END;  {CheckReflexive}

FUNCTION BaseLen(Word: WordType): INTEGER;
VAR
  RVIndex, R1Index, R2Index, I, EndLen: INTEGER;
BEGIN {BaseLen}
  EndLen := 0;
  RVIndex := FindRV(Word);
  R1Index := FindR1(Word); 
  R2Index := FindR2(Word, R1Index); 
  IF CheckGerund(Word, RVIndex, EndLen)
  THEN
    BEGIN
      DELETE(Word.Val, Word.Len - EndLen + 1, EndLen);
      Word.Len := Word.Len - EndLen
    END
  ELSE
    BEGIN
      IF CheckReflexive(Word, RVIndex, EndLen)
      THEN
        BEGIN
          DELETE(Word.Val, Word.Len - EndLen + 1, EndLen);
          Word.Len := Word.Len - EndLen
        END;
      IF CheckAdjective(Word, RVIndex, EndLen)
      THEN
        BEGIN
          DELETE(Word.Val, Word.Len - EndLen + 1, EndLen);
          Word.Len := Word.Len - EndLen;
          IF CheckParticiple(Word, RVIndex, EndLen)
          THEN
            BEGIN                   
              DELETE(Word.Val, Word.Len - EndLen + 1, EndLen);
              Word.Len := Word.Len - EndLen
            END
        END
      ELSE
        IF CheckVerb(Word, RVIndex, EndLen)
        THEN
          BEGIN                   
            DELETE(Word.Val, Word.Len - EndLen + 1, EndLen);
            Word.Len := Word.Len - EndLen
          END
        ELSE
          IF CheckNoun(Word, RVIndex, EndLen)
          THEN
            BEGIN                   
              DELETE(Word.Val, Word.Len - EndLen + 1, EndLen);
              Word.Len := Word.Len - EndLen
            END
    END;
  IF (Word.Val[Word.Len] = 'и')
  THEN
    BEGIN
      DELETE(Word.Val, Word.Len, 1);
      Word.Len := Word.Len - 1
    END;
  IF CheckDerivational(Word, R2Index, EndLen)
  THEN
    BEGIN                   
      DELETE(Word.Val, Word.Len - EndLen + 1, EndLen);
      Word.Len := Word.Len - EndLen
    END;
  IF (Word.Val[Word.Len] = 'н') AND (Word.Val[Word.Len - 1] = 'н')
  THEN
    BEGIN
      DELETE(Word.Val, Word.Len, 1);
      Word.Len := Word.Len - 1
    END
  ELSE
    IF CheckSuperlative(Word, RVIndex, EndLen)
    THEN
      BEGIN
        DELETE(Word.Val, Word.Len - EndLen + 1, EndLen);
        Word.Len := Word.Len - EndLen;
        IF (Word.Val[Word.Len] = 'н') AND (Word.Val[Word.Len - 1] = 'н')
        THEN
          BEGIN
            DELETE(Word.Val, Word.Len, 1);
            Word.Len := Word.Len - 1
          END
      END
    ELSE
      IF (Word.Val[Word.Len] = 'ь')
      THEN
        BEGIN
          DELETE(Word.Val, Word.Len, 1);
          Word.Len := Word.Len - 1
        END;
  Result := Word.Len
END;  {BaseLen}

BEGIN {PorterStemmer}
END.  {PorterStemmer}
