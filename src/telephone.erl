-module(telephone).
-export([create/0, pick_up/1, dial/1, tell/2, hang_up/1]).

create() ->
    spawn(fun phone/0).

pick_up(Phone) ->
    Phone ! {pick_up, self()},
    get_response().

dial(Phone) ->
    Phone ! {dial, self()},
    get_response().

tell(Phone, Message) ->
    Phone ! {{tell, Message}, self()},
    get_response().

hang_up(Phone) ->
    Phone ! {hang_up, self()},
    get_response().

get_response() -> 
    receive
        Value ->
            Value
    end.

phone() ->
    phone(on_hook).

phone(on_hook) ->
    receive
        {pick_up, From} -> 
            From ! {idle, "Dooooo"},
            phone(idle);
        {_, From} ->
            From ! {on_hook, "Phone confused by your actions."},
            phone(on_hook);
        _ ->
            phone(on_hook)
    end;
phone(idle) ->
    receive
        {dial, From} ->
            From ! {connected, "Hello!"},
            phone({connected, 3});
        {hang_up, From} ->
            From ! {hang_up, "Clanck!"},
            phone(on_hook);
        {_, From} ->
            From ! {idle, "Phone confused by your actions."},
            phone(idle);
        _ ->
            phone(idle)
    end;
phone({connected, 0}) ->
    receive
        {hang_up, From} ->
            From ! {hang_up, "Clanck!"},
            phone(on_hook);
        {_, From} ->
            From ! {reset, "Doo Doo Doo"},
            phone(reset);
        _ ->
            phone(reset)
    end;
phone({connected, Count}) ->
    receive
        {{tell, Message}, From} ->
            From ! {phone_says, "Himself a " ++ Message ++ "!"},
            phone({connected, Count - 1});
        {hang_up, From} ->
            From ! {hang_up, "Clanck!"},
            phone(on_hook);
         {_, From} ->
            From ! {connected, "Phone confused by your actions."},
            phone({connected, Count});
        _ ->
            phone({connected, Count})
    end;
phone(reset) ->
    receive
        {hang_up, From} ->
            From ! {hang_up, "Clanck!"},
            phone(on_hook);
        {_, From} ->
            From ! {reset, "Phone confused by your actions."},
            phone(reset);
        _ ->
            phone(reset)
    end.
