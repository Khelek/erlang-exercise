-module(db).
-export([create_db/0, get/2, insert/3, update/3, delete/2]).


create_db() ->
    [].

get([], Key) ->
    {error, none};
get([{Key, Value} | T], Key) ->
    {ok, Value};
get([H | T], Key) ->
    get(T, Key).

insert(Db, Key, Value) ->
    case get(Db, Key) of
       {error, none} -> {ok, [{Key, Value} | Db]};
        {ok, _Value} -> {error, key_is_busy}
    end.

update(Db, Key, Value) ->
    case get(Db, Key) of
        {error, none} -> {error, none};
        {ok, _Value} -> 
            {ok, Db1} = delete(Db, Key),
            insert(Db1, Key, Value)
    end.

delete(Db, Key) ->
    {ok, [X || X <- Db, element(1, X) =/= Key]}.
    
