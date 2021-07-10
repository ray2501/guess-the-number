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

    static ArrayList<String> checkResult(ArrayList<String> oldResultSet, String guess, int a, int b) {
        ArrayList<String> newResultSet = new ArrayList<String>();

        oldResultSet.forEach(result -> {
            int testA = getA(result, guess);
            int testB = getB(result, guess);

            if (testA == a && testB == b) {
                newResultSet.add(result);
            }
        });

        return newResultSet;
    }

    public static void main(String[] args) {
        ArrayList<String> resultset = new ArrayList<String>();

        // Create a result set
        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++) {
                for (int k = 0; k < 10; k++) {
                    for (int m = 0; m < 10; m++) {
                        if (i != j && i != k && i != m && j != k && j != m && k != m) {
                            StringBuilder sb = new StringBuilder();
                            sb.append(Integer.toString(i));
                            sb.append(Integer.toString(j));
                            sb.append(Integer.toString(k));
                            sb.append(Integer.toString(m));
                            resultset.add(sb.toString());
                        }
                    }
                }
            }
        }

        Random ran = new Random();
        while (true) {
            int aInt = 0, bInt = 0;
            if (resultset.size() == 0) {
                System.out.println(">> User gives a wroing response!!!");
                return;
            }

            // Pick an answer to check
            System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
            int number = ran.nextInt(resultset.size());
            String gnumber = resultset.get(number);
            System.out.println(">> My answer is " + gnumber);

            String aStr;
            System.out.println(">> The A is: ");
            try {
                BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
                aStr = reader.readLine();
            } catch (IOException nfe) {
                System.out.println(">> It it not a valid input!!!");
                continue;
            }

            if (aStr.length() != 1) {
                System.out.println(">> It it not a valid input!!!\n");
                continue;
            }
            aInt = Integer.parseInt(aStr);

            String bStr;
            System.out.println(">> The B is: ");
            try {
                BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
                bStr = reader.readLine();
            } catch (IOException nfe) {
                System.out.println(">> It it not a valid input!!!");
                continue;
            }

            if (bStr.length() != 1) {
                System.out.println(">> It it not a valid input!!!\n");
                continue;
            }
            bInt = Integer.parseInt(bStr);

            if (aInt == 4 && bInt == 0) {
                break;
            }

            resultset = checkResult(resultset, gnumber, aInt, bInt);
        }

        System.out.println(">> Game is completed.");
    }
}
