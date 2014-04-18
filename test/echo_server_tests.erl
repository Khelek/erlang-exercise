-module(echo_server_tests).
-include_lib("eunit/include/eunit.hrl").
-compile(export_all).

echo_test() ->
    Pid = echo_server:start(),
    Pid ! {self(), echo},
    receive
        Message -> Message = echo
    end.



