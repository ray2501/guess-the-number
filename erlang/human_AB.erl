#!/usr/bin/env escript
-module(human_AB).

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
    N = rand:uniform(length(Result)),
    L1 = lists:nth(N, Result),
    T = 1,
    check(L1, T).


%%====================================================================
%% Functions
%%====================================================================

check(L1, T) ->
    io:format(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>~n"),
    case io:fread(">> Please input a number: ","~4s") of
        {ok, [Terms]} ->
            L2 = Terms,
            %L = [ {X,Y} || X <- L1, Y<-L2],
            [A, B] = get_guess_result(L1, L2),
            io:format(">> Result: ~p A ~p B.~n~n", [A, B])
    end,
    if
        A =:= 4 ->
            io:format("Yes, you guess the number, use ~w turns to guest.~n", [T]);
        true ->
            check(L1, T+1)
    end.


get_guess_result(L1, L2) ->
    L = lists:zip(L1, L2),
    LSame = lists:filter(fun({X,Y}) -> X=:=Y end,L),
    LSameCount = length(LSame),
    % Check L1 element is L2 member
    LLike = [X || X<-L1, lists:member(X,L2)],
    LLikeCount = length(LLike),
    [LSameCount, LLikeCount - LSameCount].
