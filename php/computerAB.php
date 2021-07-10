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

while (1) {
     if (sizeof($resultset) == 0) {
         exit("Game over, you give the wrong answer.\n");
     }

     $rand_number = rand(0, sizeof($resultset) - 1);
     $current = $resultset[$rand_number];
     echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n";
     echo "My guess number is " . $current . ".\n";
     $a = (int) readline("The A is: ");
     $b = (int) readline("The B is: ");

     if($a < 0 || $a > 4 || !is_integer($a)) {
          exit("Wrong answer!!!\n");
     }

     if($b < 0 || $b > 4 || !is_integer($b)) {
          exit("Wrong answer!!!\n");
     }

     if($a == 4 && $b == 0) {
          echo "The game is completed.\n";
          break;
     }

     foreach ($resultset as $r) {
          $guessa = getA($current, $r);
          $guessb = getB($current, $r);

          if ($guessa != $a || $guessb != $b) {
              $key = array_search($r, $resultset);
              if ($key !== false) {
                   unset($resultset[$key]);
              }
          }
     }

     $resultset = array_values($resultset);
}
?>
