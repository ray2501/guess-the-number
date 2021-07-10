'
' Guess the number game
'
Function getA(Answer As String, Guess As String) As Integer

    Dim count as Integer = 0

    Dim I as Integer
    For I = 0 to Len(Answer) - 1
        If Answer[I] = Guess[I] then
            count = count + 1
        End If
    Next

    return count

End Function

Function getB(Answer As String, Guess As String) As Integer

    Dim count as Integer = 0

    Dim I as Integer
    Dim J as Integer
    For I = 0 to Len(Answer) - 1
        For J = 0 to Len(Guess) - 1
            If I <> J Then
                If Answer[I] = Guess[J] then
                    count = count + 1
                End If
            End If
        Next
    Next

    return count

End Function


Dim Results(5040) as String * 4
Dim As Integer I, J, K, L, Count
Count = 0
For I = 1 to 9
    For J = 1 to 9
         For K = 1 to 9
              For L = 1 to 9
                  If I <> J AND I <> K AND I <> L AND _
                     J <> K AND J <> L AND K <> L Then
                     Dim R as String * 4 = STR(I) + STR(J) + STR(K) + STR(L)
                     Results(Count) = R
                     Count = Count + 1
                 End If
             Next
        Next
   Next
Next

Dim avalue as Integer = 0
Dim bvalue as Integer = 0
Dim aguess as Integer = 0
Dim bguess as Integer = 0

' Pick up the first answer
RANDOMIZE TIMER
Dim num as Integer = INT(RND * (Count - 1))
Dim answer as String * 4
answer = Results(num)

While True
    Print "My Answer is " + answer + "."
    Input "Please give the A value: ", avalue
    Input "Please give the B value: ", bvalue
    If avalue = 4 AND bvalue = 0 Then
        Exit While
    End If

    Dim Index As Integer = 0
    Dim Currents(5040) as String * 4
    For I = 0 to Count - 1
       aguess =  getA(Results(I), answer)
       bguess =  getB(Results(I), answer)

       If aguess = avalue AND bguess = bvalue Then
           Currents(index) = Results(I)
           index = index + 1
       End If
    Next

    If Index = 0 Then
       Print "Something is wrong."
       Exit While
    End If   

    For I = 0 to Index - 1
        Results(I) = Currents(I)
    Next

    Count = Index
    Answer = Results(0)
    Print
WEnd
Print "Game Over."
