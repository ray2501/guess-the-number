/*
 * g++ -std=c++11 computerAB.cpp -o computerAB
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


std::vector<std::string> checkAnswer(std::vector<std::string> &resultset, std::string &guess, int A, int B)
{
  std::vector<std::string> newResultSet;

  for(auto it = resultset.begin(); it != resultset.end(); it++) {
     int a = getA(*it, guess);
     int b = getB(*it, guess);

     if(a == A && b == B) {
        newResultSet.push_back(*it);
     }
  }

  return newResultSet;
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

    while(1) {
        if(resultset.size() == 0) {
           std::cout << "User gives the wrong input..., end." << std::endl;
           break;
        }

        int number = rand() % resultset.size();
        std::string answer = resultset[number];
        std::cout << "My answer is " << answer << std::endl;

        std::string A;
        std::cout << "Please input A value: ";
        std::getline(std::cin, A);
        if(A.length() != 1 || isNumber(A) == false) {
            std::cout << "It is not a valid answer..." << std::endl << std::endl;
            continue;
        }

        std::string B;
        std::cout << "Please input B value: ";
        std::getline(std::cin, B);
        if(B.length() != 1 || isNumber(A) == false) {
            std::cout << "It is not a valid answer..." << std::endl << std::endl;
            continue;
        }

        if(std::stoi(A) == 4 && std::stoi(B) == 0) {
            std::cout << "Guess the correct number, end." << std::endl;
            break;
        }

        resultset = checkAnswer(resultset, answer, std::stoi(A), std::stoi(B));
        std::cout << std::endl;
    }

    return 0;
}

