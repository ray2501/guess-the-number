#!/usr/bin/env escript
-module(computer_AB).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(_) ->
    Result = [ [A, B, C, D]  ||
        A <- lists:seq(48, 57),
        B <- lists:seq(48, 57),
        C <- lists:seq(48, 57),
        D <- lists:seq(48, 57),
        A =/= B, A =/= C, A =/= D, B =/= C, B =/= D, C =/= D],
    {A1,A2,A3} = erlang:timestamp(),
    rand:seed(exs1024s, {A1, A2, A3}),
    T = 1,
    try
        guess(Result, T)
    catch
        exit:Msg ->
            io:format("~p~n", [Msg]),
            guess(Result, T)
    end.


%%====================================================================
%% Functions
%%====================================================================

guess(Result, T) ->
    % check our answer set, if it is empty -> wrong input
    Current = length(Result),
    if
       Current =:= 0 ->
          io:format("User gives the wrong answer, end.!!!~n"),
          halt();
       true ->
          true
    end,

    % pick up our answer          
    N = rand:uniform(length(Result)),
    L1 = lists:nth(N, Result),
    io:format(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>~n"),
    io:format(">> My answer is ~s.~n", [L1]),

    case io:fread(">> The A is: ","~d") of
        {ok, [A]} ->
          if
              A > 4 ->
                  exit("Input A is wrong!!!");
              A < 0 ->
                  exit("Input A is wrong!!!");
              A =:= 4 ->
                  io:format(">> Get the correct answer, use ~w turns to guess.~n", [T]),
                  halt(0);
              true ->
                  true
          end
    end,
    case io:fread(">> The B is: ","~d") of
        {ok, [B]} ->
          if
              B > 4 ->
                  exit("Input B is wrong!!!");
              B < 0 ->
                  exit("Input B is wrong!!!");
              true ->
                  true
          end
    end,
    io:format(">> Response: ~w A ~w B~n~n", [A, B]),
    Newresult = num(Result, A, B, L1),
    try
        guess(Newresult, T + 1)
    catch
        exit:Msg ->
            io:format("~p~n", [Msg]),
            guess(Newresult, T + 1)
    end.

num([], _, _, _) -> [];
num(List1, A, B, Answer) ->
        num(List1, [], A, B, Answer).

num([H|L], Result, A, B, Answer) ->
       [A1, B1] = get_guess_result(H, Answer),
        if
            A1 == A, B1 == B ->
               Newresult = [H | Result];
            true ->
               Newresult = Result
        end,
        num(L, Newresult, A, B, Answer);

num([], Result, _, _, _) ->
        Result.

get_guess_result(L1, L2) ->
    L = lists:zip(L1, L2),
    LSame = lists:filter(fun({X,Y}) -> X=:=Y end,L),
    LSameCount = length(LSame),
    % Check L1 element is L2 member
    LLike = [X || X<-L1, lists:member(X,L2)],
    LLikeCount = length(LLike),
    [LSameCount, LLikeCount - LSameCount].

