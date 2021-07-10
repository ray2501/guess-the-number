#!/usr/bin/env tclsh

set count 0

set A 0
set B 0
set total {}

set TrueAnswer 0
set MyAnswer(1) 0
set MyAnswer(2) 0
set MyAnswer(3) 0
set MyAnswer(4) 0

set useranswer(1) 0
set useranswer(2) 0
set useranswer(3) 0
set useranswer(4) 0

# create our total solution
proc totalSolution {} {
    global total
    for {set i 1} {$i < 10} {incr i 1} {
        for {set j 0} {$j < 10} {incr j 1} {
            for {set k 0} {$k < 10} {incr k 1} {
                for {set m 0} {$m < 10} {incr m 1} {
                    if {$i != $j && $i!= $k && $i != $m && $j != $k && $j != $m && $k!=$m} {
                        set a [expr ($i * 1000 + $j * 100 + $k * 10 + $m)];
                        lappend total $a
                    }
                }
            }
        }
    }
}


# compare total solution and check A/B count
proc checkTrueAnswer {answer} {
    global A
    global B
    global total
    global MyAnswer

    set useranswer(1) [expr $answer/1000]
    set useranswer(2) [expr ($answer/100)%10]
    set useranswer(3) [expr ($answer%100)/10]
    set useranswer(4) [expr $answer%10]

    set myA 0
    set myB 0
    for {set i 1} {$i < 5} {incr i 1} {
        if {$useranswer($i)==$MyAnswer($i)} {
            incr myA 1
        }
    }

    for {set i 1} {$i < 5} {incr i 1} {
        for {set j 1} {$j < 5} {incr j 1} {
            if {$i != $j} {
                if {$useranswer($i)==$MyAnswer($j)} {
                    incr myB 1
                }
            }
        }
    }

    # Remove the wrong answer
    if {$A != $myA || $B != $myB} {
        set inIndex [lsearch  -exact $total $answer]
        set total [lreplace $total $inIndex $inIndex]
    }
}

#**********************************************************
# Main program
#**********************************************************
puts "Welcome to play the guess-the-number game."
totalSolution

while (1) {
    if {[llength $total] == 0} {
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        puts ">> Sorry, but no answer in this game."
        puts "\nUser give the wrong answer."
        set response "Computer guess "
        append response $count
        append response " turns."
        puts $response

        break
    }

    incr count 1

    if {$count==1} {
      # OK, choose our answer randomly
      expr srand([clock seconds])
      set TrueAnswer [lindex $total [expr round(4000*rand())]]
    } else {
      set TrueAnswer [lindex $total 0]
    }

    set MyAnswer(1) [expr $TrueAnswer/1000]
    set MyAnswer(2) [expr ($TrueAnswer/100)%10]
    set MyAnswer(3) [expr ($TrueAnswer%100)/10]
    set MyAnswer(4) [expr $TrueAnswer%10]

    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    set response ">> Computer answer is "
    append response $TrueAnswer
    append response "."
    puts $response
    puts -nonewline "<< The A is: "
    flush stdout
    gets stdin A
    puts -nonewline "<< The B is: "
    flush stdout
    gets stdin B

    if {$A > 4 || $A < 0 || $B > 4 || $B < 0 } {
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        puts ">> User give the wrong A or B value."

        continue
    }

    if {$A==4 && $B==0} {
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        puts ">> Get the right answer."
        set response "\nComputer guess "
        append response $count
        append response " turns."
        puts $response

        break
    }

    foreach number $total {
        checkTrueAnswer $number
    }
}
