{$mode Delphi}

Program computerAB;

{
    I am useing Free Pascal to test.
}

Uses 
Sysutils, classes;

Function GetA(Guess: String; Answer: String): Integer;

Var 
  index1: Integer;
  length1: LongInt;
  length2: LongInt;
Begin
  length1 := Length(Guess);
  length2 := Length(Answer);
  If (length1 <> 4) Or (length2 <> 4) Then
    Begin
      Exit(0);
    End;

  Result := 0;
  For index1 := 1 To 4 Do
    Begin
      If (Guess[index1] = Answer[index1]) Then
        Begin
          Result := Result + 1;
        End;
    End;
End;

Function GetB(Guess: String; Answer: String): Integer;

Var 
  index1: Integer;
  index2: Integer;
  length1: LongInt;
  length2: LongInt;
Begin
  length1 := Length(Guess);
  length2 := Length(Answer);
  If (length1 <> 4) Or (length2 <> 4) Then
    Begin
      Exit(0);
    End;

  Result := 0;
  For index1 := 1 To 4 Do
    Begin
      For index2 := 1 To 4 Do
        Begin
          If (index1 <> index2) Then
            Begin
              If (Guess[index1] = Answer[index2]) Then
                Begin
                  Result := Result + 1;
                End;
            End;
        End;
    End;
End;

Var 
  stringlist : TStringList;
  RNumber : Longint;
  Guess   : String;
  Answer  : String;
  i, j, k, m : Integer;
  aresult: Integer;
  bresult: Integer;
  avalue: Integer;
  bvalue: Integer;

Begin
(* Initialize random number generator *)
  Randomize;
  stringlist := TStringList.Create;

  Try

    For i := 0 To 9 Do
      Begin
        For j := 0 To 9 Do
          Begin
            For k := 0 To 9 Do
              Begin
                For m := 0 To 9 Do
                  Begin
                    If (i <> j) And (i <> k) And (i <> m) And
                       (j <> k) And (j <> m) And (k <> m) Then
                      Begin
                        stringlist.add(IntToStr(i) + IntToStr(j) + IntToStr(k) + IntToStr(m));
                      End;
                  End;
              End;
          End;
      End;

    While true Do
      Begin
        (* Pick up a number to be the answer *)
        RNumber := Random (stringlist.Count);
        Answer := stringlist[RNumber];
        writeln('My Answer is ', Answer);

        write('Please input the A value: ');
        readln(aresult);
        If ((aresult < 0) Or (aresult > 4)) Then
          Begin
            writeln('It is not a valid input.');
            writeln();
            continue;
          End;

        write('Please input the B value: ');
        readln(bresult);
        If ((bresult < 0) Or (bresult > 4)) Then
          Begin
            writeln('It is not a valid input.');
            writeln();
            continue;
          End;

        If (aresult = 4) And (bresult = 0) Then
          Begin
            writeln('End game.');
            writeln();
            break;
          End;

        For i := stringlist.Count - 1 Downto 0 Do
          Begin
            Guess := stringlist[i];
            avalue := GetA(Answer, Guess);
            bvalue := GetB(Answer, Guess);

            If (avalue <> aresult) Or (bvalue <> bresult) Then
              stringlist.Delete(i);
          End;

        If stringlist.Count = 0 Then
          Begin
            writeln('I cannot find a suitable solution, end game.');
            break;
          End;
        writeln();
      End;

  Finally
    FreeAndNIL(stringlist);
End;
End.
