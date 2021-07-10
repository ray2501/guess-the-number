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

' Pick up a number to be our answer
RANDOMIZE TIMER
Dim num as Integer = INT(RND * (Count - 1))
Dim answer as String * 4
answer = Results(num)

Dim avalue as Integer = 0
Dim bvalue as Integer = 0
Do
    Dim guess as String * 4
    Input "Please input an answer: ", guess
    If Len(Trim(guess)) <> 4 Then
        Print "Invalid input."
        Print
        Continue Do
    End If

    avalue = getA(answer, guess)
    bvalue = getB(answer, guess)
    Print "Result: " + str(avalue) + "A, " + str(bvalue) + "B."
    Print
Loop Until avalue = 4 AND bvalue = 0
Print "Game Over."
