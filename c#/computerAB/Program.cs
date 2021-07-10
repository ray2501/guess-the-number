using System;
using System.Collections.Generic;
using System.Text;

namespace computerAB
{
    class Program
    {
        static int getA(string answer, string guess)
        {
            int a = 0;

            for (int count = 0; count < 4; count++)
            {
                if (answer[count] == guess[count])
                {
                    a++;
                }
            }

            return a;
        }

        static int getB(string answer, string guess)
        {
            int b = 0;

            for (int count = 0; count < 4; count++)
            {
                for (int count2 = 0; count2 < 4; count2++)
                {
                    if (answer[count] == guess[count2])
                    {
                        if (count != count2)
                        {
                            b++;
                        }
                    }
                }
            }

            return b;
        }

        static List<string> checkResult(List<string> oldResultSet, string guess, int a, int b)
        {
            List<string> newResultSet = new List<string>();

            foreach (string result in oldResultSet)
            {
                int testA = getA(result, guess);
                int testB = getB(result, guess);

                if (testA == a && testB == b)
                {
                    newResultSet.Add(result);
                }
            }
            return newResultSet;
        }

        static void Main(string[] args)
        {
            List<string> resultset = new List<string>();

            for (int i = 0; i < 10; i++)
            {
                for (int j = 0; j < 10; j++)
                {
                    for (int k = 0; k < 10; k++)
                    {
                        for (int m = 0; m < 10; m++)
                        {
                            if (i != j && i != k && i != m && j != k && j != m && k != m)
                            {
                                System.Text.StringBuilder sb = new StringBuilder();
                                sb.Append(i.ToString());
                                sb.Append(j.ToString());
                                sb.Append(k.ToString());
                                sb.Append(m.ToString());
                                resultset.Add(sb.ToString());
                            }
                        }
                    }
                }
            }

            while (true)
            {
                Random r = new Random();
                if (resultset.Count == 0)
                {
                    Console.WriteLine(">> User gives a wroing response!!!");
                    return;
                }

                Console.WriteLine(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                int number = r.Next(0, resultset.Count);
                string gnumber = resultset[number];
                Console.WriteLine($">> My answer is {gnumber}");

                Console.Write(value: $">> The A is: ");
                string aStr = Console.ReadLine();
                int aInt = 0;
                bool isaNumeric = int.TryParse(aStr, out aInt);
                if (aStr.Length != 1 || isaNumeric == false)
                {
                    Console.WriteLine(value: ">> It it not a valid input!!!\n");
                }

                Console.Write(value: $">> The B is: ");
                string bStr = Console.ReadLine();
                int bInt = 0;
                bool isbNumeric = int.TryParse(bStr, out bInt);
                if (bStr.Length != 1 || isbNumeric == false)
                {
                    Console.WriteLine(value: ">> It it not a valid input!!!\n");
                };

                if (aInt == 4 && bInt == 0)
                {
                    break;
                }

                resultset = checkResult(resultset, gnumber, aInt, bInt);
                Console.Write("\n");
            }
        }
    }
}

