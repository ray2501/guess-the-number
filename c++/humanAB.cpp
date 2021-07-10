/*
 * g++ -std=c++11 humanAB.cpp -o humanAB
 */

#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <string>
#include <vector>


int getA(std::string &answer, std::string &guess)
{
    int a = 0;

    if(answer.length() != guess.length()) {
        return 0;
    }

    for(int index = 0; index < answer.length(); index++) {
      if(answer[index] == guess[index]) {
        a++;
      }
    }

    return a;
}


int getB(std::string &answer, std::string &guess)
{
    int b = 0;

    if(answer.length() != guess.length()) {
        return 0;
    }

    for(int index = 0; index < answer.length(); index++) {
      for(int index2 = 0; index2 < guess.length(); index2++) {
          if(index != index2) {
             if(answer[index] == guess[index2]) {
               b++;
             }
          }
      }
    }

    return b;
}


bool isNumber(std::string &s) 
{
  for( char c : s )
  {
    if( !isdigit( c ) ) 
      return false;
  }

  return true;
}


int main(int argc, char *argv[])
{
    std::vector<std::string> resultset;

    for(int i = 0; i < 10; i++) {
       for(int j = 0; j < 10; j++) {
         for(int k = 0; k < 10; k++) {
           for(int m = 0; m < 10; m++) {
             if(i != j && i != k && i != m && j != k && j != m && k !=m) {
                 char buff[5];
                 sprintf(buff, "%d%d%d%d", i, j, k, m);
                 resultset.push_back(buff);
              }
           }
         }
       }
    }

    srand (time(NULL));
    int number = rand() % resultset.size();
    std::string answer = resultset[number];

    while(1) {
        std::string line;
        std::cout << "Please input a number to guess: ";
        std::getline(std::cin, line);
        if(line.length() != 4 || isNumber(line) == false) {
            std::cout << "It is not a valid answer..." << std::endl << std::endl;
            continue;
        }

        int a = getA(answer, line);
        int b = getB(answer, line);
        std::cout << "Result: A = " << a << ", B = " << b << std::endl << std::endl;

        if(a == 4 && b == 0) {
             break;
        }
    }

    return 0;
}

