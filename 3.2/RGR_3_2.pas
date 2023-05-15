PROGRAM GroupWords(INPUT, OUTPUT);
USES
  FileHandler3; 
   
VAR
  FileName: STRING;
  FIn, FOut: TEXT;
 
BEGIN {GroupWords}
  WRITE('¬ведите название входного файла: ');
  READLN(FileName);
  ASSIGN(FIn, FileName);
  WRITE('¬ведите название выходного файла: ');
  READLN(FileName);
  ASSIGN(FOut, FileName);
  RESET(FIn);  
  WHILE (NOT EOF(FIn)) AND (NOT EOLN(FIn))
  DO
    ReadStr(FIn);
  REWRITE(FOut);
  OutputList(FOut)
END.  {GroupWords}
