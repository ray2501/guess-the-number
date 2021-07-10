package com.danilo.guessAB;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class App 
{
   static int getA(String answer, String guess) {
        int a = 0;

        for (int count = 0; count < 4; count++) {
            if (answer.charAt(count) == guess.charAt(count)) {
                a++;
            }
        }

        return a;
    }

    static int getB(String answer, String guess) {
        int b = 0;

        for (int count = 0; count < 4; count++) {
            for (int count2 = 0; count2 < 4; count2++) {
                if (answer.charAt(count) == guess.charAt(count2)) {
                    if (count != count2) {
                        b++;
                    }
                }
            }
        }

        return b;
    }

    public static void main(String[] args) {
        Random ran = new Random();
        int number = 0;
        String nstr;
        int a = 0, b = 0;

        // Generate the game answer
        while (true) {
            number = ran.nextInt(10000);
            nstr = String.format("%04d", number);
            if (nstr.length() != 4) {
                continue;
            }

            if (nstr.charAt(0) != '0' && nstr.charAt(0) != nstr.charAt(1) && nstr.charAt(0) != nstr.charAt(2)
                    && nstr.charAt(0) != nstr.charAt(3) && nstr.charAt(1) != nstr.charAt(2)
                    && nstr.charAt(1) != nstr.charAt(3) && nstr.charAt(2) != nstr.charAt(3))
                break;
        }

        // Play the game
        while (true) {
            System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
            System.out.println(">> Input the guess number: ");

            String gnumber;

            try {
                BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
                gnumber = reader.readLine();
            } catch (IOException nfe) {
                System.out.println(">> It it not a valid input!!!");
                continue;
            }

            if (gnumber.length() != 4) {
                System.out.println(">> It it not a valid input!!!");
                continue;
            }

            a = getA(nstr, gnumber);
            b = getB(nstr, gnumber);
            System.out.println(">> Result: A = " + a + " B = " + b + "\n");

            if (a == 4 && b == 0) {
                break;
            }

        }

        System.out.println(">> Game is completed.");
    }
}
