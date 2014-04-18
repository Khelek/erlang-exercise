-module(ring).
-export([start/1, stop/1, send/3, start_proc/2]).


start(ProcsCount) ->
    spawn(ring, start_proc, [ProcsCount, undefined]).

send(Pid, Message, Count) ->
    Pid ! {message, Message, Count}.

stop(Pid) ->
    Pid ! {stop, youre_die}.

start_proc(Number, undefined) ->
    start_proc(Number, self());
start_proc(1, FirstPid) ->
    loop(1, FirstPid);
start_proc(Number, FirstPid) ->
    Pid = spawn(ring, start_proc, [Number - 1, FirstPid]),
    loop(Number, Pid).

loop(Number, NextPid) ->
    receive
        {message, Message, 0} ->
            erlang:display([Message, Number]),
            loop(Number, NextPid);
        {message, Message, Counter} ->
            NextPid ! {message, Message, Counter - 1},
            loop(Number, NextPid);
        {stop, Reason} ->
            NextPid ! {stop, Reason},
            ok
    end.
