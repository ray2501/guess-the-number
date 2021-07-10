using System;

namespace humanAB
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

        static void Main(string[] args)
        {
            Random r = new Random();
            int number = 0;
            string nstr = String.Empty;
            int a = 0, b = 0;
            int turns = 1;

            while (true)
            {
                number = r.Next(0, 10000);
                nstr = number.ToString();
                if (nstr.Length != 4)
                {
                    continue;
                }

                if (nstr[0] != '0' && nstr[0] != nstr[1] && nstr[0] != nstr[2]
                    && nstr[0] != nstr[3] && nstr[1] != nstr[2]
                    && nstr[1] != nstr[3] && nstr[2] != nstr[3])
                    break;
            }

            while (true)
            {
                Console.WriteLine(value: ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                Console.Write(value: $">> Input the guess number: ");

                string gnumber = Console.ReadLine();
                int gnumberInt = 0;
                bool isNumeric = int.TryParse(gnumber, out gnumberInt);
                if (gnumber.Length != 4 || isNumeric == false)
                {
                    Console.WriteLine(value: ">> It it not a valid input!!!\n");
                    continue;
                }

                a = getA(nstr, gnumber);
                b = getB(nstr, gnumber);
                Console.WriteLine(value: $">> Result: A = {a}, B = {b}\n");

                if (a == 4 && b == 0)
                {
                    break;
                }

                turns++;
            }

            Console.WriteLine(value: $">> User uses {turns} turns to guess.\n");
        }
    }
}
