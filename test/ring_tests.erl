-module(ring_tests).
-include_lib("eunit/include/eunit.hrl").
-compile(export_all).

db_test_() ->
    {spawn,
     {setup,
      fun start/0,
      fun stop/1,
      fun(Setup) ->
              [
              ]
      end}
    }.

start() ->
    ok.

stop(_) ->
    ok.

ring_test() ->
    % rewrite
    Pid = echo_server:start(),
    Pid ! {self(), echo},
    receive
        Message -> Message = echo
    end.
