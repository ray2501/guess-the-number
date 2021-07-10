#!/usr/bin/env php
<?php

function getA(string $answer, string $guess): int {
    $num = 0;
    $len = strlen($answer);
    if($len != strlen($guess)) {
        return 0;
    }

    for ($count = 0; $count < $len; $count++) {
        if ($answer[$count] == $guess[$count]) {
            $num++;
        }
    }

    return $num;
}

function getB(string $answer, string $guess): int {
    $num = 0;

    $len1 = strlen($answer);
    $len2 = strlen($guess);
    if($len1 != $len2) {
        return 0;
    }

    for ($count = 0; $count < $len1; $count++) {
        for ($count2 = 0; $count2 < $len2; $count2++) {
            if ($answer[$count] == $guess[$count2]) {
                if ($count != $count2) {
                    $num++;
                }
            }
        }
    }

    return $num;
}


$resultset= [];

for ($i = 0; $i < 10; $i++) {
    for ($j = 0; $j < 10; $j++) {
        for ($k = 0; $k < 10; $k++) {
            for ($m = 0; $m < 10; $m++) {
                if ($i != $j && $i != $k && $i != $m && $j != $k && $j != $m && $m != $k) {
                    $result = (string )$i . (string)$j . (string )$k . (string )$m;
                    array_push($resultset, $result);
                }
            }
        }
    }
}


$rand_number = rand(0, sizeof($resultset) - 1);
$answer = $resultset[$rand_number];

while (1) {
     echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n";
     $guess = readline("Your answer is: ");

     if(strlen($guess) != 4) {
          exit("Wrong answer!!!\n");
     }

     $guessa = getA($answer, $guess);
     $guessb = getB($answer, $guess);
     echo "The A is "  . $guessa . ", the B is " . $guessb . ".\n";
     if($guessa == 4 && $guessb == 0) {
          echo "The game is completed.\n";
          break;
     }
}
?>
