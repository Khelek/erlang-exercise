-module(telephone_tests).
-include_lib("eunit/include/eunit.hrl").
-compile(export_all).

telephone_test_() ->
    {spawn,
     {setup,
      fun start/0,
      fun stop/1,
      fun(Phone) ->
              [
               test_long_talk(Phone),
               test_hang_up(Phone)
              ]
      end}
    }.

start() ->
    telephone:create().

stop(_) ->
    ok.

test_long_talk(Phone) ->
    [?_assertEqual({idle, "Dooooo"}, telephone:pick_up(Phone)),
    ?_assertEqual({connected, "Hello!"}, telephone:dial(Phone)),
    ?_assertEqual({phone_says, "Himself a John!"}, telephone:tell(Phone, "John")),
    ?_assertEqual({phone_says, "Himself a Sara!"}, telephone:tell(Phone, "Sara")),
    ?_assertEqual({phone_says, "Himself a Sam!"}, telephone:tell(Phone, "Sam")),
    ?_assertEqual({reset, "Doo Doo Doo"}, telephone:tell(Phone, "Jenny")),
    ?_assertEqual({hang_up, "Clanck!"}, telephone:hang_up(Phone))].

test_hang_up(Phone) ->
    [?_assertEqual({idle, "Dooooo"}, telephone:pick_up(Phone)),
    ?_assertEqual({connected, "Hello!"}, telephone:dial(Phone)),
    ?_assertEqual({phone_says, "Himself a John!"}, telephone:tell(Phone, "John")),
    ?_assertEqual({hang_up, "Clanck!"}, telephone:hang_up(Phone)),
    ?_assertEqual({idle, "Dooooo"}, telephone:pick_up(Phone)),
    ?_assertEqual({connected, "Hello!"}, telephone:dial(Phone)),
    ?_assertEqual({phone_says, "Himself a Iozhik!"}, telephone:tell(Phone, "Iozhik")),
    ?_assertEqual({hang_up, "Clanck!"}, telephone:hang_up(Phone)),
    ?_assertEqual({on_hook, "Phone confused by your actions."}, telephone:tell(Phone, "Iozhik"))].


