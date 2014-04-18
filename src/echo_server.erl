-module(echo_server).
-export([start/0]).

start() ->
    spawn(fun loop/0).

loop() ->
    receive
        {From, Message} ->
            From ! Message,
            loop();
        _ -> exit
    end.
