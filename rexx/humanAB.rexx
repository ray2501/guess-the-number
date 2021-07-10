/* Guess the number game */
main_routine:
    resultset. = '0000'
    resultset.0 = 0
    do i = 0 to 9
        do j = 0 to 9
            do k = 0 to 9
                do m = 0 to 9
                    if i\==j & i\==k & i\==m & ,
                       j\==k & j\==m & k\== m then do
                        result = i || j || k || m
                        resultset.0 = resultset.0 + 1
                        count = resultset.0
                        resultset.count = result
                    end
                end
            end
        end
    end

    rvalue = random(1, resultset.0)
    answer = resultset.rvalue

    do forever
        call charout, "Please input your answer: "
        pull guessnumber

        if length(guessnumber) \== 4 then do
            say "Invalid input."
            iterate
            end

        avalue = getA(answer, guessnumber)
        bvalue = getB(answer, guessnumber)
        if (avalue==4 & bvalue==0) then do
            say "Game over."
            leave
            end

        say "Result: " avalue " A " bvalue " B"
    end

    exit 0

getA: procedure
    parse arg arg1, arg2

    if length(arg1)\==4 | length(arg2)\==4 then
        return 0

    count = 0
    do i = 1 to length(arg1)
        if substr(arg1, i, 1) == substr(arg2, i, 1) then
            count = count + 1

        end       

    return count

getB: procedure
    parse arg arg1, arg2

    if length(arg1)\==4 | length(arg2)\==4 then
        return 0

    count = 0
    do i = 1 to length(arg1)
        do j = 1 to length(arg2)
            if i \== j then do
                if substr(arg1, i, 1) == substr(arg2, j, 1) then
                    count = count + 1

                end
            end
        end

    return count
