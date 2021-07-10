#!/usr/bin/env tclsh

set count 0

set A 0
set B 0

# variable records answer
set TrueAnswer 0
# variable records user answer
set userAnswer 0

set MyAnswer(1) 0
set MyAnswer(2) 0
set MyAnswer(3) 0
set MyAnswer(4) 0

set useranswer(1) 0
set useranswer(2) 0
set useranswer(3) 0
set useranswer(4) 0

# Create our answer by using random number
proc createAnswer {} {
    global TrueAnswer
    global MyAnswer

    expr srand([clock seconds])

    while {1} {
        set TrueAnswer [expr round(10000*rand())]
        set MyAnswer(1) [expr $TrueAnswer/1000]
        set MyAnswer(2) [expr ($TrueAnswer/100)%10]
        set MyAnswer(3) [expr ($TrueAnswer%100)/10]
        set MyAnswer(4) [expr $TrueAnswer%10]

        if {$MyAnswer(1)==0 || $MyAnswer(1)==$MyAnswer(2) ||
            $MyAnswer(3)==$MyAnswer(2) || $MyAnswer(3) == $MyAnswer(1) ||
            $MyAnswer(4) == $MyAnswer(3) || $MyAnswer(4) == $MyAnswer(2) ||
            $MyAnswer(4) == $MyAnswer(1)} {
            continue
        } else {
            break;
        }
    }
}

# Count A B number
proc checkAnswer {answer} {
    global TrueAnswer
    global MyAnswer
    global useranswer
    global count

    global A
    global B

    incr count 1
    set wrongAnswer 0

    if {$answer <= 1000 || $answer >=10000} {
        puts "<<\tNot a suitable answer.\n"
        return
    } else {
        set useranswer(1) [expr $answer/1000]
        set useranswer(2) [expr ($answer/100)%10]
        set useranswer(3) [expr ($answer%100)/10]
        set useranswer(4) [expr $answer%10]

        for {set i 1} {$i < 5} {incr i 1} {
            for {set j 1} {$j < 5} {incr j 1} {
              if {$i != $j} {
                if {$useranswer($i)==$useranswer($j)} {
                   puts "<<\tNot a suitable answer.\n"
                   return
                }
              }
            }
        }
    }

    if {$answer == $TrueAnswer} {
        set A 4
        set B 0

        return
    }

    set A 0
    set B 0
    for {set i 1} {$i < 5} {incr i 1} {
        if {$useranswer($i)==$MyAnswer($i)} {
            incr A 1
        }
    }

    for {set i 1} {$i < 5} {incr i 1} {
        for {set j 1} {$j < 5} {incr j 1} {
            if {$i != $j} {
                if {$useranswer($i)==$MyAnswer($j)} {
                    incr B 1
                }
            }
        }
    }
}

#**********************************************************
# Main program
#**********************************************************
puts "Welcome to play the guess-the-number game."
createAnswer

while {1} {
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    puts -nonewline stdout ">> User Input answer: ";
    flush stdout
    gets stdin userAnswer
    checkAnswer $userAnswer

    set response "<<\t Return: "
    append response $A
    append response " A "
    append response $B
    append response " B."
    puts $response

    if {$A==4 && $B==0} {
        break
    }
}

puts "\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
set countTurn ">> You use "
append countTurn $count
append countTurn " turns to guest."
puts $countTurn
