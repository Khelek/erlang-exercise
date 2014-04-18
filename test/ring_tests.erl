-module(ring_tests).
-include_lib("eunit/include/eunit.hrl").
-compile(export_all).

db_test_() ->
    {spawn,
     {setup,
      fun start/0,
      fun(_) -> stop() end,
      fun(Setup) ->
              [
              ]
      end}
    }.

start() ->
    ok.

stop(_) ->
    ok.

echo_test() ->
    Pid = echo_server:start(),
    Pid ! {self(), echo},
    receive
        Message -> Message = echo
    end.
